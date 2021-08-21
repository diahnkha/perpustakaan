unit Uperpus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
a,b:string;
begin
a:=(Edit1.Text);
b:=(Edit2.Text);
if (a='diah') and (b='admin') or (a='alcazaba') and (b='admin')
then
begin
form2.Show;
form1.Hide;
end
else if Edit1.Text='' then ShowMessage('Username Anda masih kosong')
else if Edit2.Text='' then ShowMessage('Password Anda masih kosong')
else
MessageBox(handle,'Username dan Password Anda Salah!','Error',mb_iconerror)
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
if (application.MessageBox('Apakah anda yakin ingin keluar ?','Warning!!',mb_YesNo or mb_iconquestion)=idyes)
then
application.Terminate;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked
then begin
edit2.PasswordChar:=#0;
end else
begin
edit2.PasswordChar:='*';
end;
end;

end.
