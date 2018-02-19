object FrmSistema: TFrmSistema
  Left = 0
  Top = 0
  Caption = 'Gerenciamento do Sistema'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnNovo: TBitBtn
      Left = 5
      Top = 4
      Width = 80
      Height = 50
      Caption = 'Nova Tabela'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5
        FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF13A5FF10A0FF14A4FF1FADFF2DBAFF43C6FF57CFFF
        4DCEFF3ACAFF37CBFF3ACFFF3ED3FF3DD1FF01860300810000810000820313A5
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF1AA5FF29B6FF57CEFF7E
        DEFF9AE7FFAAEDFF9EEBFF88E9FF77E7FF7BEAFF80EDFF80EDFF00810016B01E
        11AC1800810013A5FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF42C1
        FF2DBBFF56CEFF7DDDFF99E7FFA7EBFF9CEAFF84E6FF72E5FF74E7FF77E9FF76
        E9FF00810024B1291DAC2100810013A5FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF13A5FF50C6FF2DBBFF55CCFF7ADCFF97E6FFA5EBFF98E9FF80E5FF6AE1
        FF6BE2FF6DE3FF6DE3FF00810038BC3C2DB73200810013A5FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF13A5FF5ECCFF2BBBFF52CBFF78DAFF95E5FFA3EAFF
        95E7FF7AE2FF068A090081000081000081002AAC2C50CA533EC14114A0170081
        00008100008100008100FF00FFFF00FFFF00FF13A5FF6FD1FF29BBFF51CBFF75
        D9FF91E3FF9FE7FF90E5FF74DEFF00810091E99596E79897E9998BE38E6CDA6D
        49C54B39BF3E26B22B14A61907A40E008100FF00FFFF00FFFF00FF13A5FF7FD8
        FF28BAFF4ECBFF72D9FF8EE2FF9CE6FF8BE2FF6DDCFF008100A7F0AAABEFACAC
        EFAD9EEB9F7BDC7D60D36350CE5333BB3718AA1E0AA712008100FF00FFFF00FF
        FF00FF13A5FF91DEFF25BAFF4BCAFF6FD8FF8AE1FF98E5FF87E1FF67D8FF0387
        070081000081000081003FB44096E9977ADE7D28AF2A00810000810000810000
        8100FF00FFFF00FFFF00FF13A5FFA3E3FF23BAFF48CAFF6CD8FF87E1FF95E3FF
        81DEFF60D5FF43CCFF41CCFF41CCFF41CCFF0081009DEA9E82E08600810013A5
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FFB4E9FF4BC9FF45CAFF69
        D8FF83E0FF91E3FF7DDDFF5AD3FF3CC9FF39C9FF39C9FF39C9FF00810097E798
        7FDD8200810013A5FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF43C1
        FF93E1FFBFEEFFC4F0FFC7F2FFCAF3FFC9F2FFC7F2FFC5F0FFC5F0FFC5F0FFC5
        F0FF00810089E68F74DD7900810013A5FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF13A5FF10A0FF12A3FF1FAFFF2DBDFF38C5FF3FC7FF3EC9FF39CAFF35CA
        FF37CCFF3ACFFF39CFFF02860500810000810003870713A5FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF13A5FF19A5FF2BB7FF58CFFF7FDEFF9AE9FFAAEDFF
        9EEBFF89E9FF78E7FF7BEBFF81EDFF80EDFF74E7FF5BDCFF3ECBFF17ABFF13A5
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF42C1FF2EBBFF57CEFF7E
        DDFF99E7FFA9EDFF9CEAFF84E7FF72E5FF74E7FF77E9FF77E9FF6DE3FF57D9FF
        42CEFF16AAFF13A5FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF50C7
        FF2DBBFF55CCFF7BDCFF97E6FFA5EBFF98E9FF80E5FF6BE1FF6CE3FF6EE5FF6E
        E3FF66E0FF51D7FF3FCBFF15A9FF13A5FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF13A5FF5ECCFF2CBBFF53CCFF78DAFF95E5FFA3EAFF95E7FF7AE2FF64DD
        FF63DEFF65E0FF65E0FF5DDCFF4BD3FF3BC9FF13A6FF13A5FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF13A5FF6ED1FF2ABBFF51CCFF75D9FF91E3FF9FE7FF
        90E5FF75E0FF5CD9FF5ADAFF5CDAFF5CDAFF55D8FF45CFFF36C5FF12A4FF13A5
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF7FD8FF28BAFF4FCBFF73
        D9FF8EE2FF9CE6FF8BE3FF6EDCFF54D5FF52D5FF53D7FF53D7FF4DD3FF40CAFF
        31C1FF11A1FF13A5FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF90DD
        FF26BAFF4CCBFF6FD8FF8AE1FF98E5FF87E1FF68D8FF4CD1FF49D1FF4AD1FF4A
        D1FF45CFFF39C6FF2DBFFF0F9EFF13A5FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF13A5FFA1E3FF23BAFF49CAFF6CD8FF87E1FF95E3FF82DEFF60D5FF44CC
        FF41CCFF42CEFF42CEFF3ECAFF33C2FF28BAFF0D9CFF13A5FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF13A5FFB4E9FF32C0FF46CAFF69D8FF83E1FF91E3FF
        7EDEFF5BD3FF3DCAFF3AC9FF3AC9FF3AC9FF36C6FF2DBFFF2BBBFF41BFFF13A5
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5FF62CEFFBAEBFFBFEEFFC7
        F2FFCFF4FFD1F4FFCFF3FFCAF2FFC5F0FFC5F0FFBBEEFF9EE6FFA5E7FFC1EEFF
        BDEDFF64CEFF13A5FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF13A5
        FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13A5FF13
        A5FF13A5FF13A5FF13A5FF13A5FFFF00FFFF00FFFF00FFFF00FF}
      Layout = blGlyphTop
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TBitBtn
      Left = 87
      Top = 4
      Width = 80
      Height = 50
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
  end
  object grdTabelas: TJvDBGrid
    Left = 0
    Top = 57
    Width = 784
    Height = 486
    Align = alClient
    DataSource = dsSysTable
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 18
    TitleRowHeight = 18
    Columns = <
      item
        Expanded = False
        FieldName = 'nome_tabela'
        Title.Caption = 'Nome da tabela'
        Width = 176
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'titulo'
        Title.Caption = 'T'#237'tulo'
        Width = 181
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'order_by'
        Title.Caption = 'Ordenar por'
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'foco_inicial'
        Title.Caption = 'Foco Inicial em'
        Width = 132
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'compartilhada'
        Title.Caption = 'Compartilha?'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'paginacao'
        Title.Caption = 'Pagina'#231#227'o'
        Width = 68
        Visible = True
      end>
  end
  object JvDBGridFooter1: TJvDBGridFooter
    Left = 0
    Top = 543
    Width = 784
    Height = 19
    SimpleText = 'gd'
    SizeGrip = True
    Columns = <>
  end
  object dsSysTable: TDataSource
    DataSet = cdsSysTable
    Left = 104
    Top = 240
  end
  object cdsSysTable: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSys_Table'
    RemoteServer = DM.ProviderConnection
    Left = 112
    Top = 360
    object cdsSysTablenome_tabela: TStringField
      FieldName = 'nome_tabela'
      Origin = 'nome_tabela'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 30
    end
    object cdsSysTabletitulo: TStringField
      FieldName = 'titulo'
      Origin = 'titulo'
      Size = 60
    end
    object cdsSysTableorder_by: TStringField
      FieldName = 'order_by'
      Origin = 'order_by'
      Size = 255
    end
    object cdsSysTablefoco_inicial: TStringField
      FieldName = 'foco_inicial'
      Origin = 'foco_inicial'
      Size = 30
    end
    object cdsSysTablecompartilhada: TBooleanField
      FieldName = 'compartilhada'
      Origin = 'compartilhada'
    end
    object cdsSysTablepaginacao: TIntegerField
      FieldName = 'paginacao'
    end
  end
end
