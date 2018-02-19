unit View.ConfiguracaoConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, Vcl.ComCtrls, Vcl.ExtCtrls,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.Buttons, View.FrmConsulta;

type
  TForm1 = class(TForm)
    FDConnection1: TFDConnection;
    cbbDriver: TComboBox;
    Label1: TLabel;
    PageControl1: TPageControl;
    tsMySQL: TTabSheet;
    edtUser: TLabeledEdit;
    edtPassword: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    edt1: TLabeledEdit;
    edt2: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  with FDConnection1 do
  begin
    Close;
    Params.UserName := Trim(edtUser.Text);
    Params.Password := Trim(edtPassword.Text);

  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmConsulta, FrmConsulta);
    FrmConsulta.ShowModal;

  finally
    FreeAndNil(FrmConsulta);
  end;
end;

end.
