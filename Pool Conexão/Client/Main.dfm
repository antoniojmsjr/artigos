object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Pool de Conex'#227'o :: Cliente'
  ClientHeight = 661
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TGridPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 661
    Align = alClient
    Caption = 'pnlMain'
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAbsolute
        Value = 2.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlConsoleHeader
        Row = 0
      end
      item
        Column = 2
        Control = pnlIISHeader
        Row = 0
      end
      item
        Column = 1
        Control = pnlDivisionHeader
        Row = 0
      end
      item
        Column = 0
        Control = pnlConsoleHeaderMain
        Row = 1
      end
      item
        Column = 1
        Control = Panel2
        Row = 1
      end
      item
        Column = 2
        Control = pnlIISHeaderMain
        Row = 1
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 40.000000000000000000
      end
      item
        Value = 100.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      784
      661)
    object pnlConsoleHeader: TPanel
      Left = 1
      Top = 1
      Width = 390
      Height = 40
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlConsoleHeader'
      ShowCaption = False
      TabOrder = 0
      object bvlConsoleHeader: TBevel
        Left = 0
        Top = 35
        Width = 390
        Height = 5
        Align = alBottom
        Shape = bsBottomLine
        ExplicitTop = 32
        ExplicitWidth = 368
      end
      object pnlConsoleHeaderTitle: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 35
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Teste Console'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object pnlIISHeader: TPanel
      Left = 393
      Top = 1
      Width = 390
      Height = 40
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlIISHeader'
      ShowCaption = False
      TabOrder = 1
      object bvlIISHeader: TBevel
        Left = 0
        Top = 35
        Width = 390
        Height = 5
        Align = alBottom
        Shape = bsBottomLine
        ExplicitTop = -10
        ExplicitWidth = 353
      end
      object pnlIISHeaderTitle: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 35
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Teste IIS'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
    end
    object pnlDivisionHeader: TPanel
      Left = 391
      Top = 1
      Width = 2
      Height = 40
      Anchors = []
      BevelOuter = bvNone
      Caption = 'pnlDivisionHeader'
      ShowCaption = False
      TabOrder = 2
    end
    object pnlConsoleHeaderMain: TPanel
      Left = 1
      Top = 41
      Width = 390
      Height = 619
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlConsoleHeaderMain'
      ShowCaption = False
      TabOrder = 3
      object pnlConsoleOptions: TPanel
        Left = 0
        Top = 0
        Width = 390
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlConsoleOptions'
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          390
          55)
        object bvlConsoleOptions: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 47
          Width = 384
          Height = 5
          Align = alBottom
          Shape = bsBottomLine
          ExplicitLeft = 1
          ExplicitTop = 30
          ExplicitWidth = 352
        end
        object Label1: TLabel
          Left = 8
          Top = 3
          Width = 112
          Height = 13
          Caption = 'Quantidade requisi'#231#245'es'
        end
        object speConsoleQuantidadeRequisicao: TSpinEdit
          Left = 8
          Top = 24
          Width = 50
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object btnConsoleExecutar: TBitBtn
          Left = 270
          Top = 22
          Width = 100
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Executar'
          TabOrder = 1
          OnClick = btnConsoleExecutarClick
        end
      end
      object mmoConsoleLog: TMemo
        Left = 0
        Top = 55
        Width = 390
        Height = 564
        Align = alClient
        BorderStyle = bsNone
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 391
      Top = 41
      Width = 2
      Height = 619
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 4
    end
    object pnlIISHeaderMain: TPanel
      Left = 393
      Top = 41
      Width = 390
      Height = 619
      Align = alClient
      Caption = 'pnlIISHeaderMain'
      ShowCaption = False
      TabOrder = 5
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 388
        Height = 55
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlConsoleOptions'
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          388
          55)
        object Bevel1: TBevel
          AlignWithMargins = True
          Left = 3
          Top = 47
          Width = 382
          Height = 5
          Align = alBottom
          Shape = bsBottomLine
          ExplicitLeft = 1
          ExplicitTop = 30
          ExplicitWidth = 352
        end
        object Label2: TLabel
          Left = 8
          Top = 3
          Width = 112
          Height = 13
          Caption = 'Quantidade requisi'#231#245'es'
        end
        object speIISQuantidadeRequisicao: TSpinEdit
          Left = 5
          Top = 22
          Width = 50
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object btnIISExecutar: TBitBtn
          Left = 265
          Top = 20
          Width = 100
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Executar'
          TabOrder = 1
          OnClick = btnIISExecutarClick
        end
      end
      object mmoIISLog: TMemo
        Left = 1
        Top = 56
        Width = 388
        Height = 562
        Align = alClient
        BorderStyle = bsNone
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
      end
    end
  end
end
