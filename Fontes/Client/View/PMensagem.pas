unit PMensagem;

interface

uses
  Windows, StdCtrls, Buttons, Graphics, ExtCtrls,
  Controls, Gauges, Forms, Classes, ShellAPI, ComCtrls, JvExComCtrls,
  JvProgressBar, JvExControls, JvXPCore, JvXPButtons, Dialogs, JvBaseDlg,
  JvProgressDialog;

type
  TFrmMensagem = class(TForm)
    PnlMensagem: TPanel;
    PrgBrMensagem: TGauge;
    PnlChkBxMensagem: TPanel;
    ChkBxMensagem: TCheckBox;
    Panel2: TPanel;
    diduknow: TLabel;
    BulbImage: TImage;
    BtnOK: TBitBtn;
    mmoMensagem: TMemo;
    btn1: TJvXPButton;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure MensagemChange(Sender: TObject);
    procedure MensagemClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
    VsEnderecoLink: String;
  public
    { Public declarations }
//    AppHandle: THandle;
    procedure PProgressoMax(ViMax: Integer);
    procedure PProgresso(ViPosition: Integer);
    procedure PIncrementaProgresso;
    procedure PMensagem(VsMensagem: String);
    procedure PShow;

  end;

var
  FrmMensagem: TFrmMensagem;

implementation

uses Math;//, UBiblioteca;

//uses Math;

{$R *.dfm}
procedure TFrmMensagem.PMensagem(VsMensagem: String);
begin
  Try
     // mmoMensagem.Lines.Clear;
//     If FsValorStringList(VsMensagem, 0)='@' then
//     begin
//        //É link.  No Segundo parâmetro é passado o endereço
//        VsEnderecoLink:=FsValorStringList(VsMensagem, 1);
//        //No terceiro é passado o texto
//        mmoMensagem.Lines.Add(FsValorStringList(VsMensagem, 2));
//        mmoMensagem.Font.Style:=[fsItalic, fsUnderline, fsBold];
//        mmoMensagem.Font.Color:=clBlue;
//        mmoMensagem.Font.Size:=10;
//        mmoMensagem.Cursor:=crHandPoint;
//     end
//     else
        mmoMensagem.Lines.Add(VsMensagem);
     Update;
     Repaint;
  Finally
     Application.ProcessMessages;
  end;
end;

procedure TFrmMensagem.PShow;
begin
   Show;
   Update;
   Repaint;
   Application.ProcessMessages;
end;

procedure TFrmMensagem.PProgressoMax(ViMax: Integer);
begin
   PrgBrMensagem.MaxValue:=ViMax;
   PProgresso(0);
end;

procedure TFrmMensagem.PProgresso(ViPosition: Integer);
begin

  PrgBrMensagem.Visible:=True;
  PrgBrMensagem.Progress:=ViPosition;
  PrgBrMensagem.Update;
  Update;
  Repaint;
  Application.ProcessMessages;
end;

procedure TFrmMensagem.PIncrementaProgresso;
begin
   PrgBrMensagem.Visible:=True;
   PrgBrMensagem.Progress:=PrgBrMensagem.Progress+1;
   PrgBrMensagem.Update;
   Update;
   Repaint;
   Application.ProcessMessages;
end;

procedure TFrmMensagem.FormShow(Sender: TObject);
begin
   If not(fsModal in FormState) then
   begin
      BtnOK.OnClick:=nil;
      BtnOK.Visible:=False;
      OnKeyPress:=nil;
      width:=342;//277;
   end;
   PnlChkBxMensagem.Visible:= ChkBxMensagem.Visible;
   Update;
   Refresh;
   Application.ProcessMessages;
end;

procedure TFrmMensagem.FormKeyPress(Sender: TObject; var Key: Char);
begin
   Close;
end;

procedure TFrmMensagem.FormCreate(Sender: TObject);
begin
   mmoMensagem.Lines.Clear;
   VsEnderecoLink:='';
end;

procedure TFrmMensagem.MensagemChange(Sender: TObject);
begin
   Update;
   Application.ProcessMessages;
end;

procedure TFrmMensagem.MensagemClick(Sender: TObject);
begin
  If VsEnderecoLink<>'' then
  begin
    ShellExecute(0, nil, PChar(VsEnderecoLink), nil, nil, SW_NORMAL);
    BtnOK.Click;
  end;
end;

procedure TFrmMensagem.BtnOKClick(Sender: TObject);
begin
  Close;
end;

end.


