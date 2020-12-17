object frRamais: TfrRamais
  Left = 0
  Top = 0
  Width = 552
  Height = 397
  OnCreate = UniFrameCreate
  Color = clWhite
  TabOrder = 0
  ParentColor = False
  ParentBackground = False
  object gdRamais: TUniDBGrid
    Left = 0
    Top = 34
    Width = 552
    Height = 363
    Hint = ''
    TitleFont.Color = clBlack
    TitleFont.Height = -13
    DataSource = UniMainModule.ds_tb_ramal_
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect]
    ReadOnly = True
    WebOptions.Paged = False
    LoadMask.Message = 'Carregando...'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Color = clBlack
    Font.Height = -13
    ParentFont = False
    TabOrder = 0
    OnMouseDown = gdRamaisMouseDown
    OnColumnSort = gdRamaisColumnSort
    Columns = <
      item
        FieldName = 'ramal_ramal'
        Title.Alignment = taCenter
        Title.Caption = 'Ramal'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 74
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
      end
      item
        FieldName = 'ramal_nome'
        Title.Alignment = taCenter
        Title.Caption = 'Nome'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 200
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
      end
      item
        FieldName = 'ramal_setor'
        Title.Alignment = taCenter
        Title.Caption = 'Setor'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 230
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
      end>
  end
  object UniContainerPanel1: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 552
    Height = 34
    Hint = ''
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ParentColor = False
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    DesignSize = (
      552
      34)
    object edPesquisar: TUniEdit
      AlignWithMargins = True
      Left = 68
      Top = 7
      Width = 428
      Hint = ''
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Text = ''
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      EmptyText = 'Informe o Ramal, Nome ou Setor para pesquisar'
      OnKeyDown = edPesquisarKeyDown
    end
    object UniLabel1: TUniLabel
      AlignWithMargins = True
      Left = 10
      Top = 7
      Width = 50
      Height = 16
      Hint = ''
      Caption = 'Localizar'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      TabOrder = 2
    end
    object btEditarRamais: TUniBitBtn
      AlignWithMargins = True
      Left = 504
      Top = 3
      Width = 45
      Height = 28
      Hint = ''
      Caption = ''
      Align = alRight
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 3
      Images = UniMainModule.imgList_
      ImageIndex = 72
      OnClick = btEditarRamaisClick
    end
  end
  object popMenu: TUniPopupMenu
    Images = UniMainModule.imgList_
    Left = 296
    Top = 192
    object Excel1: TUniMenuItem
      Caption = 'Exportar'
      ImageIndex = 79
      OnClick = Excel1Click
    end
  end
end
