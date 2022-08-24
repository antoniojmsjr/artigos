object frmMain: TfrmMain
  Left = 0
  Top = 0
  CustomHint = blhMain
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '.:: Recebendo arquivos/dados usando multipart/form-data ::.'
  ClientHeight = 386
  ClientWidth = 829
  Color = clBtnFace
  Constraints.MaxHeight = 425
  Constraints.MaxWidth = 845
  Constraints.MinHeight = 425
  Constraints.MinWidth = 845
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bvlDivisao: TBevel
    AlignWithMargins = True
    Left = 263
    Top = 3
    Width = 5
    Height = 380
    CustomHint = blhMain
    Align = alLeft
    Shape = bsLeftLine
    ExplicitLeft = 344
    ExplicitTop = 144
    ExplicitHeight = 50
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 260
    Height = 386
    CustomHint = blhMain
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlLeft'
    ShowCaption = False
    TabOrder = 0
    object lblPort: TLabel
      Left = 8
      Top = 19
      Width = 24
      Height = 13
      CustomHint = blhMain
      Caption = 'Port:'
    end
    object btnStop: TBitBtn
      Left = 104
      Top = 50
      Width = 90
      Height = 25
      CustomHint = blhMain
      Caption = 'Stop'
      Enabled = False
      TabOrder = 0
      OnClick = btnStopClick
    end
    object btnStart: TBitBtn
      Left = 8
      Top = 50
      Width = 90
      Height = 25
      CustomHint = blhMain
      Caption = 'Start'
      TabOrder = 1
      OnClick = btnStartClick
    end
    object edtPort: TEdit
      Left = 38
      Top = 16
      Width = 156
      Height = 21
      CustomHint = blhMain
      NumbersOnly = True
      TabOrder = 2
      Text = '9000'
    end
    object mmoLog: TMemo
      Left = 8
      Top = 81
      Width = 246
      Height = 257
      CustomHint = blhMain
      ScrollBars = ssVertical
      TabOrder = 3
    end
  end
  object pnlClient: TPanel
    Left = 271
    Top = 0
    Width = 558
    Height = 386
    CustomHint = blhMain
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlClient'
    ShowCaption = False
    TabOrder = 1
    object imgFoto: TImage
      Left = 8
      Top = 3
      Width = 145
      Height = 150
      CustomHint = blhMain
      Center = True
      Stretch = True
    end
    object lblNome: TLabel
      Left = 170
      Top = 3
      Width = 32
      Height = 13
      CustomHint = blhMain
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSobrenome: TLabel
      Left = 350
      Top = 3
      Width = 65
      Height = 13
      CustomHint = blhMain
      Caption = 'Sobrenome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataNascimento: TLabel
      Left = 170
      Top = 57
      Width = 113
      Height = 13
      CustomHint = blhMain
      Caption = 'Data de Nascimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCelular: TLabel
      Left = 350
      Top = 57
      Width = 39
      Height = 13
      CustomHint = blhMain
      Caption = 'Celular'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblGithub: TLabel
      Left = 170
      Top = 112
      Width = 37
      Height = 13
      CustomHint = blhMain
      Caption = 'Github'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPerfilTitulo: TLabel
      Left = 8
      Top = 365
      Width = 35
      Height = 13
      CustomHint = blhMain
      Caption = 'Perfil: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPerfil: TLabel
      Left = 50
      Top = 364
      Width = 12
      Height = 13
      Cursor = crHandPoint
      Hint = 'Visualizar documento|Click aqui para visualizar o documento'
      CustomHint = blhMain
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      OnClick = lblPerfilClick
    end
    object edtNome: TEdit
      Left = 170
      Top = 22
      Width = 150
      Height = 21
      CustomHint = blhMain
      Enabled = False
      TabOrder = 0
    end
    object edtSobrenome: TEdit
      Left = 350
      Top = 22
      Width = 200
      Height = 21
      CustomHint = blhMain
      Enabled = False
      TabOrder = 1
    end
    object dtDataNascimento: TDateTimePicker
      Left = 170
      Top = 76
      Width = 150
      Height = 22
      CustomHint = blhMain
      Date = 44788.000000000000000000
      Time = 0.646374745367211300
      Enabled = False
      TabOrder = 2
    end
    object medtCelular: TMaskEdit
      Left = 350
      Top = 76
      Width = 196
      Height = 21
      CustomHint = blhMain
      Enabled = False
      EditMask = '!\(00\)0 00-000000;0;_'
      MaxLength = 15
      TabOrder = 3
      Text = ''
    end
    object edtGithub: TEdit
      Left = 170
      Top = 131
      Width = 380
      Height = 21
      CustomHint = blhMain
      Enabled = False
      TabOrder = 4
    end
    object grpEndereco: TGroupBox
      Left = 8
      Top = 165
      Width = 542
      Height = 180
      CustomHint = blhMain
      Caption = ' Endere'#231'o '
      TabOrder = 5
      object lblEnderecoLogradouro: TLabel
        Left = 10
        Top = 27
        Width = 52
        Height = 13
        CustomHint = blhMain
        Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoNumero: TLabel
        Left = 275
        Top = 27
        Width = 44
        Height = 13
        CustomHint = blhMain
        Caption = 'N'#250'mero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoComplemento: TLabel
        Left = 360
        Top = 27
        Width = 79
        Height = 13
        CustomHint = blhMain
        Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoBairro: TLabel
        Left = 10
        Top = 80
        Width = 34
        Height = 13
        CustomHint = blhMain
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoCidade: TLabel
        Left = 275
        Top = 80
        Width = 38
        Height = 13
        CustomHint = blhMain
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoEstado: TLabel
        Left = 465
        Top = 80
        Width = 38
        Height = 13
        CustomHint = blhMain
        Caption = 'Estado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblEnderecoCEP: TLabel
        Left = 10
        Top = 133
        Width = 20
        Height = 13
        CustomHint = blhMain
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtEnderecoLogradouro: TEdit
        Left = 10
        Top = 46
        Width = 250
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 0
      end
      object edtEnderecoNumero: TEdit
        Left = 275
        Top = 46
        Width = 70
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 1
      end
      object edtEnderecoComplemento: TEdit
        Left = 360
        Top = 46
        Width = 165
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 2
      end
      object edtEnderecoBairro: TEdit
        Left = 10
        Top = 99
        Width = 250
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 3
      end
      object edtEnderecoCidade: TEdit
        Left = 275
        Top = 99
        Width = 175
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 4
      end
      object edtEnderecoEstado: TEdit
        Left = 465
        Top = 99
        Width = 60
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 5
      end
      object edtEnderecoCEP: TEdit
        Left = 10
        Top = 152
        Width = 75
        Height = 21
        CustomHint = blhMain
        Enabled = False
        TabOrder = 6
      end
    end
  end
  object blhMain: TBalloonHint
    Left = 792
  end
end
