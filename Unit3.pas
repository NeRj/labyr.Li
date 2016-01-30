unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, OleCtnrs, OleCtrls, SHDocVw;

type
  TForm3 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  WebBrowser1.Navigate(ExtractFileDir(Application.ExeName) + '\va.htm');
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Form3.SetFocus;
end;

end.
