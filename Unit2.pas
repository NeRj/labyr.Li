unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Image2: TImage;
    procedure FormClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure StaticText2Click(Sender: TObject);
    procedure StaticText3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormClick(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.StaticText1Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.StaticText2Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.StaticText3Click(Sender: TObject);
begin
  Form2.Close;
end;

end.
