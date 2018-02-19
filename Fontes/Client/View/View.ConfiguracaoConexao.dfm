object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Configura'#231#227'o de Banco de Dados'
  ClientHeight = 290
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Driver DB'
  end
  object cbbDriver: TComboBox
    Left = 7
    Top = 24
    Width = 304
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'MySQL'
    Items.Strings = (
      'MySQL'
      'MSSQL'
      'FB')
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 51
    Width = 405
    Height = 190
    ActivePage = tsMySQL
    TabOrder = 1
    object tsMySQL: TTabSheet
      Caption = 'MySQL'
      object edtUser: TLabeledEdit
        Left = 16
        Top = 24
        Width = 121
        Height = 21
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        TabOrder = 0
      end
      object edtPassword: TLabeledEdit
        Left = 143
        Top = 24
        Width = 165
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        PasswordChar = '*'
        TabOrder = 1
      end
      object LabeledEdit1: TLabeledEdit
        Left = 314
        Top = 24
        Width = 71
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = 'Porta'
        NumbersOnly = True
        TabOrder = 2
      end
      object edt1: TLabeledEdit
        Left = 16
        Top = 72
        Width = 186
        Height = 21
        EditLabel.Width = 95
        EditLabel.Height = 13
        EditLabel.Caption = 'Servidor (IP, Nome)'
        TabOrder = 3
      end
      object edt2: TLabeledEdit
        Left = 208
        Top = 72
        Width = 177
        Height = 21
        EditLabel.Width = 121
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do banco de dados'
        TabOrder = 4
      end
      object BitBtn1: TBitBtn
        Left = 16
        Top = 120
        Width = 137
        Height = 25
        Caption = 'Testar conex'#227'o'
        TabOrder = 5
        OnClick = BitBtn1Click
      end
    end
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 256
    Width = 281
    Height = 25
    Caption = 'Chamada funcao remota'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sa'
      'Password=CI5458OM'
      'Database=DB'
      'Server=KRONUS-PC\SQLEXPRESS'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 344
    Top = 24
  end
end
