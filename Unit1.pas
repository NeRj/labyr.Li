unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdActns, ActnCtrls, Ribbon, ToolWin, ActnMan, ActnMenus,
  RibbonActnMenus, ImgList, RibbonObsidianStyleActnCtrls, Menus, ComCtrls,
  ExtCtrls, StdCtrls, Unit2, Unit3, PlatformDefaultStyleActnCtrls, ActnPopup;

type
  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    Ribbon1: TRibbon;
    RibbonPage1: TRibbonPage;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    FileOpen1: TFileOpen;
    RibbonGroup2: TRibbonGroup;
    Action1: TAction;
    RibbonGroup1: TRibbonGroup;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    StatusBar1: TStatusBar;
    PopupActionBar1: TPopupActionBar;
    N2: TMenuItem;
    N1: TMenuItem;
    FileSaveAs1: TFileSaveAs;
    Panel1: TPanel;
    Image1: TImage;
    ImageList2: TImageList;
    RibbonGroup3: TRibbonGroup;
    procedure Action4Execute(Sender: TObject);
    procedure FileOpen1OnAccept(Sender: TObject);
    procedure Ribbon1HelpButtonClick(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    Procedure DisplayHint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Action1Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure FileSaveAs1Accept(Sender: TObject);
    procedure Ribbon1RecentItemClick(Sender: TObject; FileName: string;
      Index: Integer);
  private
    FNowDraw, Draw, pointG, pointR: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  GridSize = 40;

var
  Form1: TForm1;
  aP: array [0 .. GridSize - 1, 0 .. GridSize - 1] of byte;
  Ni: Integer = 0;
  Nk: Integer = 300;
  Xglob, Yglob: Integer;
  X, Y, X1, Y1: Integer;

implementation

{$R *.dfm}

procedure TForm1.Action2Execute(Sender: TObject);
var
  i, j, startTime, timeOut: Integer;
  min: byte;
  Ni: byte;
begin
  pointG := false;
  pointR := false;
  for i := 0 to GridSize - 1 do
    for j := 0 to GridSize - 1 do
    begin
      case Image1.Canvas.Pixels[i * 10 + 1, j * 10 + 1] of
        clBlack:
          aP[i][j] := 255; // непроходимо
        clWhite:
          aP[i][j] := 254; // проходимо
        clGreen:
          begin
            pointG := true;
            aP[i][j] := 253; // старт
            X := i;
            Y := j;
          end;
        clRed:
          begin
            pointR := true;
            aP[i][j] := 0; // финиш
          end;
      end;
    end;
  if (not pointG) or (not pointR) then
  begin
    ShowMessage('Не установлены начальная и/или конечная точки!');
    Exit;
  end;
  for Ni := 0 to 253 do
    for i := 0 to GridSize - 1 do
      for j := 0 to GridSize - 1 do
      begin
        if aP[i, j] = Ni then
        begin
          case aP[i + 1, j] of
            253:
              break;
            254:
              aP[i + 1, j] := Ni + 1;
          end;
          case aP[i - 1, j] of
            253:
              break;
            254:
              aP[i - 1, j] := Ni + 1;
          end;
          case aP[i, j + 1] of
            253:
              break;
            254:
              aP[i, j + 1] := Ni + 1;
          end;
          case aP[i, j - 1] of
            253:
              break;
            254:
              aP[i, j - 1] := Ni + 1;
          end;
        end;
      end;
  Image1.Canvas.Brush.Color := clBlue;
  timeOut := 5000;
  startTime := GetTickCount;
  while (GetTickCount < (starttime + timeout)) and (aP[X1,Y1] <> 0) do
  begin
    Application.ProcessMessages;
    sleep(10);
    min := aP[X + 1, Y];
    if aP[X - 1, Y] < min then
      min := aP[X - 1, Y];
    if aP[X, Y - 1] < min then
      min := aP[X, Y - 1];
    if aP[X, Y + 1] < min then
      min := aP[X, Y + 1];
    if min = aP[X, Y - 1] then
    begin
      X1 := X;
      Y1 := Y - 1;
    end;
    if min = aP[X, Y + 1] then
    begin
      X1 := X;
      Y1 := Y + 1;
    end;
    if min = aP[X + 1, Y] then
    begin
      X1 := X + 1;
      Y1 := Y;
    end;
    if min = aP[X - 1, Y] then
    begin
      X1 := X - 1;
      Y1 := Y;
    end;
    X := X1;
    Y := Y1;
    Image1.Canvas.FillRect(rect(X * 10 + 1, Y * 10 + 1, X * 10 + 10,
      Y * 10 + 10));
    Image1.Update;
  end;
  for i := 0 to GridSize - 1 do
    for j := 0 to GridSize - 1 do
      if Image1.Canvas.Pixels[i * 10 + 1, j * 10 + 1] = clRed then
          ShowMessage('Не возможно найти путь!');
  Draw := false;
  Image1.Cursor := crDefault;
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
  Form3.Show;
end;

procedure TForm1.Action4Execute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Action5Execute(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := clGreen;
  Image1.Canvas.FillRect(rect((Xglob div 10) * 10 + 1, (Yglob div 10) * 10 + 1,
    (Xglob div 10) * 10 + 10, (Yglob div 10) * 10 + 10));
  pointG := true;
  if pointG and pointR then
    Action2.Enabled := true;
end;

procedure TForm1.Action6Execute(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := clRed;
  Image1.Canvas.FillRect(rect((Xglob div 10) * 10 + 1, (Yglob div 10) * 10 + 1,
    (Xglob div 10) * 10 + 10, (Yglob div 10) * 10 + 10));
  pointR := true;
  if pointG and pointR then
    Action2.Enabled := true;
end;

procedure TForm1.Action1Execute(Sender: TObject);
var
  i: Integer;
begin
  pointG := false;
  pointR := false;
  Image1.Picture := nil;
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.FillRect(rect(0, 0, GridSize * 10, GridSize * 10));
  Image1.SetBounds(0, 0, GridSize * 10, GridSize * 10);
  Image1.Canvas.Pen.Color := clLtGray;
  for i := 1 to GridSize do
  begin
    Image1.Canvas.MoveTo(i * 10, 0);
    Image1.Canvas.LineTo(i * 10, GridSize * 10);
    Image1.Canvas.MoveTo(0, i * 10);
    Image1.Canvas.LineTo(GridSize * 10, i * 10);
  end;
  Image1.Canvas.Brush.Color := clBlack;
  for i := 1 to (GridSize * 10 - 5) do
  begin
    Image1.Canvas.FillRect(rect((1 div 10) * 10 + 1, (i div 10) * 10 + 1,
      (1 div 10) * 10 + 10, (i div 10) * 10 + 10));
    Image1.Canvas.FillRect(rect((i div 10) * 10 + 1, (1 div 10) * 10 + 1,
      (i div 10) * 10 + 10, (1 div 10) * 10 + 10));
    Image1.Canvas.FillRect(rect((i div 10) * 10 + 1,
      ((GridSize * 10 - 5) div 10) * 10 + 1, (i div 10) * 10 + 10,
      ((GridSize * 10 - 5) div 10) * 10 + 10));
    Image1.Canvas.FillRect(rect(((GridSize * 10 - 5) div 10) * 10 + 1,
      (i div 10) * 10 + 1, ((GridSize * 10 - 5) div 10) * 10 + 10,
      (i div 10) * 10 + 10));
  end;
  Ni := 0;
  Nk := 300;
  Draw := true;
  Image1.Cursor := crCross;
  Action2.Enabled := false;
end;

procedure TForm1.FileOpen1OnAccept(Sender: TObject);
var
  i, j: Integer;
begin
  Ni := 0;
  Nk := 300;
  Image1.Picture.LoadFromFile(FileOpen1.Dialog.FileName);
  Ribbon1.AddRecentItem(FileOpen1.Dialog.FileName);
  Action2.Enabled := true;
end;

procedure TForm1.FileSaveAs1Accept(Sender: TObject);
begin
  Image1.Picture.SaveToFile(FileSaveAs1.Dialog.FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnHint := DisplayHint;
  pointG := false;
  pointR := false;
  Action1Execute(Form1);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Draw then
    case Button of
      mbLeft:
        begin
          FNowDraw := true;
          Image1.Canvas.Brush.Color := clBlack;
        end;
      mbRight:
        begin
          Xglob := X;
          Yglob := Y;
          FNowDraw := false;
          PopupActionBar1.Popup(Image1.ClientToScreen(point(X, Y)).X,
            Image1.ClientToScreen(point(X, Y)).Y);
        end;
    end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FNowDraw then
    Image1.Canvas.FillRect(rect((X div 10) * 10 + 1, (Y div 10) * 10 + 1,
      (X div 10) * 10 + 10, (Y div 10) * 10 + 10));
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FNowDraw := false;
end;

procedure TForm1.Ribbon1HelpButtonClick(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.Ribbon1RecentItemClick(Sender: TObject; FileName: string;
  Index: Integer);
begin
  Image1.Picture.LoadFromFile(FileName);
end;

procedure TForm1.DisplayHint(Sender: TObject);
var
  Counter, NumComps: Integer;
begin
  with Screen.ActiveForm do
  begin
    NumComps := ControlCount - 1;
    for Counter := 0 to NumComps do
      if (TControl(Controls[Counter]).Name = 'StatusBar1') then
      begin
        if (Application.Hint = '') then
          TStatusBar(Controls[Counter]).SimpleText := ' '
        else
          TStatusBar(Controls[Counter]).SimpleText := Application.Hint;
        break;
      end;
  end;
end;

end.
