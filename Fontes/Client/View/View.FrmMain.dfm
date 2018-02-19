object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Menu'
  ClientHeight = 446
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 80
    Top = 144
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        Hint = 'cliente'
        OnClick = MenuItemClick
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        Hint = 'produto'
        OnClick = MenuItemClick
      end
      object Unidade1: TMenuItem
        Caption = 'Unidades'
        Hint = 'unidade'
        ImageIndex = 0
        OnClick = MenuItemClick
      end
      object Marcas1: TMenuItem
        Caption = 'Marcas'
        Hint = 'marca'
        OnClick = MenuItemClick
      end
      object Gruposdeproduto1: TMenuItem
        Caption = 'Grupos de produto'
        Hint = 'grupoproduto'
        OnClick = MenuItemClick
      end
      object Ncms1: TMenuItem
        Caption = 'Ncms'
        Hint = 'ncm'
        OnClick = MenuItemClick
      end
      object Pases1: TMenuItem
        Caption = 'Pa'#237'ses'
        Hint = 'pais'
        OnClick = MenuItemClick
      end
      object Estados1: TMenuItem
        Caption = 'Estados'
        Hint = 'estado'
        OnClick = MenuItemClick
      end
      object Municpios1: TMenuItem
        Caption = 'Munic'#237'pios'
        Hint = 'municipio'
        OnClick = MenuItemClick
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
      object CompProduto1: TMenuItem
        Caption = 'Comp. Produto'
        Hint = 'produto_composicao'
        OnClick = MenuItemClick
      end
    end
    object Sistema1: TMenuItem
      Caption = 'Sistema'
      object abelasdosistema1: TMenuItem
        Caption = 'Tabelas do sistema'
        OnClick = abelasdosistema1Click
      end
      object GrupodeUsurios1: TMenuItem
        Caption = 'Grupo de Usu'#225'rios'
        Hint = 'grupousuario'
        OnClick = MenuItemClick
      end
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
        Hint = 'usuario'
        OnClick = MenuItemClick
      end
      object Menus1: TMenuItem
        Caption = 'Menus'
        Hint = 'menu'
        OnClick = MenuItemClick
      end
    end
  end
  object SqlServerMethod1: TSqlServerMethod
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'value'
        ParamType = ptInput
      end>
    SQLConnection = DM.SnapserverConnection
    ServerMethodName = 'TSM.OpenDicionario'
    Left = 80
    Top = 48
  end
end
