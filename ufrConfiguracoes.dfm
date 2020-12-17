object frConfiguracoes: TfrConfiguracoes
  Left = 0
  Top = 0
  Width = 552
  Height = 343
  OnCreate = UniFrameCreate
  Font.Height = -13
  TabOrder = 0
  ParentFont = False
  object pnUsuario: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 546
    Height = 70
    Hint = ''
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Title = 'Usu'#225'rio'
    Caption = ''
    Color = clWhite
    object lbUsuario: TUniLabel
      Left = 13
      Top = 6
      Width = 107
      Height = 24
      Hint = ''
      Caption = '<usuario>'
      ParentFont = False
      Font.Height = -20
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object lbDepartamento: TUniLabel
      Left = 13
      Top = 38
      Width = 122
      Height = 19
      Hint = ''
      Caption = '<departamento>'
      ParentFont = False
      Font.Height = -16
      TabOrder = 2
    end
    object btEditarImagens: TUniBitBtn
      AlignWithMargins = True
      Left = 512
      Top = 3
      Width = 31
      Height = 27
      Hint = ''
      Caption = ''
      TabOrder = 3
      Images = UniMainModule.imgList_
      ImageIndex = 72
      OnClick = btEditarImagensClick
    end
  end
  object btSair: TUniBitBtn
    AlignWithMargins = True
    Left = 90
    Top = 280
    Width = 372
    Height = 43
    Hint = ''
    Margins.Left = 90
    Margins.Right = 90
    Margins.Bottom = 20
    Caption = 'Sair'
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    ParentFont = False
    Font.Height = -16
    TabOrder = 1
    OnClick = btSairClick
  end
end
