object FrmMensagem: TFrmMensagem
  Left = 513
  Top = 67
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Processando...'
  ClientHeight = 104
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000000000000000000000000000BB
    BBBBBBBBBBBBBBBBBBBBBBBB00000BBBBBBBBBBBBBBBBBBBBBBBBBBBBB00BBBB
    BBBBBBBBBBBBBBBBBBBBBBBBBBB0BB444444444BB4444444444444444BBBB444
    4444444444444444444444444BBBB4444444444444444444444444444BBBB444
    BBBBBB44444444444444444444BBB444BBBBBBB4444444444444444444BBB44B
    BBBBBBB44444B4444BBBBBBB44BBB44BBBBBBB444444BB44444BBBBBBBBBBB4B
    BBBBBB4444444BB44444BBBBBBBBBBBBBBBBB44444444BBB44444BBBB000BBBB
    BBBB44444444BBBBB44444BBBB000BB0BBB444444444BBBBBB44444BBBB00000
    BB444444444BBBBBBBB44444BBBB000BB444444444BBBBBBBBB444444BBB00BB
    B44444444BBBBBBBBBBB444444BB00BB44444444BBBBBBBBBBBBB444444B00BB
    4444444BBBBBBBBBBBBBB444444B00BB4444444BBBBBB4BBBBBBB444444B00BB
    B44444BBBBBBB44BBBBBB444444B000BB44444BBBBBBB444BBBBB444444B000B
    BB44444BBBBB44444BBBB444444B000BBB444444444444444444444444BB0000
    BBBB4444444444444444444444B000000BBBB444444444BB44444444BBB00000
    0BBBBBBBBBBBBBBBBBBBBBBBBB000000000BBBBBBBBBBBBBBBBBBBBB00000000
    00000BBBBBBBBBBBBBBBBB00000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFC000000F80000003000000010000000000000000000000000000
    000000000000000000000000000000000000000000070000000390000001F000
    0000E0000000C0000000C0000000C0000000C0000000C0000000E0000000E000
    0000E0000000F0000001F8000001F8000003FE00000FFF80003FFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlMensagem: TPanel
    Left = 0
    Top = 0
    Width = 336
    Height = 104
    Align = alClient
    BevelOuter = bvLowered
    BorderWidth = 1
    Color = clWhite
    TabOrder = 0
    object PrgBrMensagem: TGauge
      Left = 2
      Top = 79
      Width = 332
      Height = 23
      Align = alClient
      Color = clWhite
      ForeColor = clSkyBlue
      MaxValue = 567
      ParentColor = False
      Progress = 2
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 83
      ExplicitWidth = 383
      ExplicitHeight = 29
    end
    object Panel2: TPanel
      Left = 573
      Top = 16
      Width = 330
      Height = 106
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      Visible = False
      object diduknow: TLabel
        Left = 42
        Top = 14
        Width = 43
        Height = 13
        Caption = 'Aten'#231#227'o:'
      end
      object BulbImage: TImage
        Left = 144
        Top = 0
        Width = 28
        Height = 37
        AutoSize = True
        Picture.Data = {
          07544269746D6170C6020000424DC60200000000000076000000280000001C00
          0000250000000100040000000000500200000000000000000000100000001000
          000000000000000080000080000000808000800000008000800080800000C0C0
          C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFF8FFFFFFFFFFFFFF0000FFFFFFFFFFFF888FFFFFFFFFFFFF
          0000FFFFFFFFFFF88888FFFFFFFFFFFF0000FFFFFFFFFF8888888FFFFFFFFFFF
          0000FFFFFFFFF888808888FFFFFFFFFF0000FFFFFFFF88880F08888FFFFFFFFF
          0100FFFFFFF88880FFF08888FFFFFFFF0000FFFFFF88880FEFEF08888FFFFFFF
          0100FFFFF88880FFFFFFF08888FFFFFF0000FFFF88880FEFEFEFEF08888FFFFF
          0000FFF88880FFFFFFFFFFF08888FFFF0000FF88880FEFEF0000FFEF08888FFF
          0000FFF880FFFFF007700FFFF088FFFF0000FFFF0FEFEFE088880FEFEF0FFFFF
          0000FFF0FFFFFFF077770FFFFFF0FFFF0000FF0FEFEFEFE088880FEFEFEF0FFF
          0000FFF8FFFFFFF0BBBB0FFFFFF8FFFF0100FFFF8FEFEF0BBBBBB0EFEF8FFFFF
          0000FFFFF8FFF0BBB00BBB0FF8FFFFFF0000FFFFFF8F0BBBB00BBBB08FFFFFFF
          0000FFFFFFF0BBBBBBBBBBBB0FFFFFFF5E00FFFF0FF0BBBBB00BBBBB0FF0FFFF
          0000FFFFFF0BBBBBB00BBBBBB0FFFFFFFFFFBFBFBF0BBBBBB00BBBBBB0FBFBFB
          00A0FFF80F0BBBBBB00BBBBBB0F08FFF0100BFBFBF0BBBBBB00BBBBBB0FBFBFB
          0100FFFFFF0BBBBBB00BBBBBB0FFFFFF0100FFFF0FF0BBBBB00BBBBB0FF0FFFF
          0100FFFFFFFF0BBBBBBBBBB0FFFFFFFF5E00FFFFFFFFF00BBBBBB00FFFFFFFFF
          0000FFFFFB0FFFF000000FFFF0BFFFFF0000FFFFF8BFFFFFFFFFFFFFFB8FFFFF
          0000FFFBFFFFF0FFB0BFF0FFFFFFBFFF0000FFFFBFFFFFFFF8FFFFFFFFFBFFFF
          0000FFFFFFFFFFFFB8BFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFBFBFFFFFFFFFFFFF00F0}
      end
      object BtnOK: TBitBtn
        Left = 159
        Top = 43
        Width = 75
        Height = 31
        Caption = 'Fechar'
        Default = True
        TabOrder = 0
        Visible = False
        OnClick = BtnOKClick
      end
    end
    object mmoMensagem: TMemo
      Left = 2
      Top = 2
      Width = 332
      Height = 77
      Align = alTop
      TabOrder = 1
    end
    object btn1: TJvXPButton
      Left = 717
      Top = 106
      Width = 61
      Height = 28
      Caption = '           '
      TabOrder = 2
      Glyph.Data = {
        055449636F6E0000010001001010000000002000680400001600000028000000
        1000000020000000010020000000000040040000000000000000000000000000
        00000000FFFFFF0127299825555DC4472226A11DFFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01
        FFFFFF0105067D135258B8A37280E0F12D35B18BFFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01
        FFFFFF013033A74B757FE4E95A70F8FF263CD9F5040A920DFFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF010407A4770408AF63FFFFFF01
        FFFFFF01272BAB5B4B53DBF32536E8FF0D22DAFB060A9013FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF010303821F0710BFD1050AB247FFFFFF01
        FFFFFF010A0B92291316C2CF050DD7FF0511D8FF04099C7104047C07FFFFFF01
        FFFFFF01FFFFFF01FFFFFF0103058E130814BEA70915C7B502038817FFFFFF01
        FFFFFF01020382090204A2870003CFFF0209D5FF040BC2D504079635FFFFFF01
        FFFFFF01FFFFFF01FFFFFF010712AF6B0B1FDBF1050A9E5701028103FFFFFF01
        FFFFFF01FFFFFF0104067F050102B0B90001CBFD0105D0FF0206B4C30306860F
        FFFFFF0104027905060E9B4D0C26DFF5081AC2B3FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01030498350101B6CB0000CEFF0102CBFD0305A077
        04068509050B9E49081BD2D70B26DFE10610A145FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF0104058C210102B6C70000CCFB0001C4EF
        0203AB99030AC6EF0512DAFD050A9C6B04017505FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF0103049A2B0202AFAB0001CBFF
        0001C8FF0003CCFF0307B2B504037D0DFFFFFF01FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF0100018B030309AA39030AB5A70207D0FF
        0003CEFF0001C6F50203A78101038809FFFFFF01FFFFFF01FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF010406940F0A12AF670B1BD6DD0616DEFD040FD9FF
        0207BEDF0204C2F30506C9F10608A3710204890DFFFFFF01FFFFFF01FFFFFF01
        FFFFFF013334A51B4A4FBE5B4956D8D73F59F5FF1C3AF6FF0D26EBFF0410C3B5
        03069A270305A03D080BBDB92123CEF72627BBAD0A0B901F0A0B9003FFFFFF01
        FFFFFF018C90D8B99AA3EEF18493FDFF657AFDFF3550F4FD1022CCBB03049521
        FFFFFF01020498030204911D1B1DB7953C3DCDEF4B4DCABD2526A64FFFFFFF01
        FFFFFF01898BD1ADAFB4EEF39CA4F7FD6E79E5E1272CB26B090D9D0FFFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF0103048F2B4445C1A35F60CCE14546B6AD
        1213985F2F309C297576C8B58A8EDFDD3A3CAD750A098A05FFFFFF01FFFFFF01
        FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01050592152123A3774E50BFE9
        17189ECB0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
        0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
        0000FFFF}
    end
  end
  object PnlChkBxMensagem: TPanel
    Left = 136
    Top = 193
    Width = 489
    Height = 24
    TabOrder = 1
    Visible = False
    object ChkBxMensagem: TCheckBox
      Left = 313
      Top = 6
      Width = 361
      Height = 17
      Caption = 'ChkBxMensagem'
      Checked = True
      State = cbChecked
      TabOrder = 0
      Visible = False
    end
  end
end
