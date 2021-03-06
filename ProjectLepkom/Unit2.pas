unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Grids, DBGrids, DB, ADODB, Buttons;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Button5: TButton;
    DBGrid1: TDBGrid;
    DataPerpustakaan1: TDataSource;
    ADOKoneksi: TADOConnection;
    QueryBuku: TADOQuery;
    Image3: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    Image4: TImage;
    Edit6: TEdit;
    Label9: TLabel;
    Edit7: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    procedure refreshdata;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ TForm2 }

procedure TForm2.refreshdata;
begin
with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('SELECT*FROM Tabel_DataBuku');;
    open;

  Edit1.Text:='otomatis';
  Edit2.Text:='ACZ0'+IntToStr(QueryBuku.RecordCount+1)+FormatDateTime('hms',now)+FormatDateTime('yyyMMdd',now);
  Edit3.Text:='';
  Edit4.Text:='';
  Edit5.Text:='';
  Edit6.Text:='';
  ComboBox1.Text:='Pilih';
  Edit7.Text:='';
  ComboBox2.Text:='Pilih';
  Edit3.SetFocus;
end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if (Edit2.Text=' ')or
  (Edit3.Text=' ')or
  (Edit4.Text=' ')or
  (ComboBox1.Text=' ')or
  (ComboBox2.Text=' ')or
  (Edit5.Text=' ')or
  (Edit6.Text=' ')or
  (ComboBox1.Text='Pilih')or
  (ComboBox2.Text='Pilih') then
  begin
    MessageDlg('Data Tidak Valid!!',mtError,[mbOK],0);
    Exit;
  end;

  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO Tabel_DataBuku (ID_Buku, Judul_Buku, Pengarang, Tahun, Penerbit, Kota_Penerbit, Kategori) VALUES (:B, :C, :D, :E, :F, :G, :H)');
    Parameters[0].Value:=Edit2.Text;
    Parameters[1].Value:=Edit3.Text;
    Parameters[2].Value:=Edit4.Text;
    Parameters[3].Value:=ComboBox1.Text;
    Parameters[4].Value:=Edit5.Text;
    Parameters[5].Value:=Edit6.Text;
    Parameters[6].Value:=ComboBox2.Text;
    ExecSQL;
  end;

  refreshdata;
  MessageDlg('Data Telah Tersimpan!',mtInformation,[mbOk],0);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  if (Edit2.Text=' ')or
  (Edit3.Text=' ')or
  (Edit4.Text=' ')or
  (ComboBox1.Text=' ')or
  (ComboBox1.Text='Pilih')or
  (Edit5.Text=' ')or
  (Edit6.Text=' ')or
  (ComboBox2.Text=' ')or
  (ComboBox2.Text='Pilih') then
  begin
    MessageDlg('Data Tidak Valid!!',mtError,[mbOK],0);
    Exit;
  end;

  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('UPDATE Tabel_DataBuku SET Judul_Buku=:C, Pengarang=:D, Tahun=:E, Penerbit=:F, Kota_Penerbit=:G, Kategori=:H WHERE ID_Buku =:B');
    Parameters[0].Value:=Edit3.Text;
    Parameters[1].Value:=Edit4.Text;
    Parameters[2].Value:=ComboBox1.Text;
    Parameters[3].Value:=Edit5.Text;
    Parameters[4].Value:=Edit6.Text;
    Parameters[5].Value:=ComboBox2.Text;
    Parameters[6].Value:=Edit2.Text;
    ExecSQL;
  end;

  refreshdata;
  MessageDlg('Data Telah di Perbaharui!!',mtInformation,[mbOk],0);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  if (Edit2.Text=' ')or
  (Edit3.Text=' ')or
  (Edit4.Text=' ')or
  (ComboBox1.Text=' ')or
  (ComboBox1.Text='Pilih')or
  (Edit5.Text=' ')or
  (Edit6.Text=' ')or
  (ComboBox2.Text=' ')or
  (ComboBox2.Text='Pilih') then
  begin
    MessageDlg('Data Tidak Valid!!',mtError,[mbOK],0);
    Exit;
  end else

  if MessageDlg('Apakah yakin data Buku Berjudul " '+Edit3.Text+' " akan dihapus?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('DELETE FROM Tabel_DataBuku WHERE ID_Buku=:A');
    Parameters[0].Value:=Edit2.Text;
    ExecSQL;
  end;

  refreshdata;
  MessageDlg('Data Telah Terhapus!',mtInformation,[mbOk],0);
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
refreshdata;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  if (Edit7.Text='') then
  begin
    MessageDlg('Data Tidak ditemukan!',mtWarning,[mbOK],0);
    Edit7.SetFocus;
    Exit;
  end
  else

  if(RadioButton1.Checked=true) then
  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('SELECT*FROM Tabel_DataBuku where ID_Buku ='''+Edit7.Text+''' ');
    Open;
    if QueryBuku.RecordCount=0 then
        MessageDlg('Data Tidak ditemukan!',mtWarning,[mbOK],0);
        Edit7.SetFocus;
        Exit;
  end
  else

  if(RadioButton2.Checked=true) then
  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('SELECT*FROM Tabel_DataBuku where Judul_Buku ='''+Edit7.Text+''' ');
    Open;
    if QueryBuku.RecordCount=0 then
        MessageDlg('Data Tidak ditemukan!',mtWarning,[mbOK],0);
        Edit7.SetFocus;
        Exit;

  end
  else

  if(RadioButton3.Checked=true) then
  with QueryBuku do
  begin
    SQL.Clear;
    SQL.Add('SELECT*FROM Tabel_DataBuku where Pengarang ='''+Edit7.Text+''' ');
    Open;
    if QueryBuku.RecordCount=0 then
        MessageDlg('Data Tidak ditemukan!',mtWarning,[mbOK],0);
        Edit7.SetFocus;
        Exit;
  end;
end;


procedure TForm2.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TForm2.DBGrid1DblClick(Sender: TObject);
begin
  with QueryBuku do
  begin
    Edit1.Text:=Fields[0].AsString;
    Edit2.Text:=Fields[1].AsString;
    Edit3.Text:=Fields[2].AsString;
    Edit4.Text:=Fields[3].AsString;
    ComboBox1.Text:=Fields[4].AsString;
    Edit5.Text:=Fields[5].AsString;
    Edit6.Text:=Fields[6].AsString;
    ComboBox2.Text:=Fields[7].AsString;
  end;
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
Close;
end;

end.
