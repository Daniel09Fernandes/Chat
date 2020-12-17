object fmRamais: TfmRamais
  Left = 0
  Top = 0
  ClientHeight = 460
  ClientWidth = 537
  Caption = 'Ramais'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gdRamais: TUniDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 39
    Width = 531
    Height = 418
    Hint = ''
    TitleFont.Color = clBlack
    TitleFont.Height = -13
    DataSource = UniMainModule.ds_ramais_
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgRowSelect]
    ReadOnly = True
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Color = clBlack
    Font.Height = -13
    ParentFont = False
    TabOrder = 0
    OnColumnSort = gdRamaisColumnSort
    Columns = <
      item
        FieldName = 'Ramal'
        Title.Alignment = taCenter
        Title.Caption = 'Ramal'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 74
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
        CheckBoxField.FieldValues = 'true;false'
      end
      item
        FieldName = 'Nome'
        Title.Alignment = taCenter
        Title.Caption = 'Nome'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 200
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
        CheckBoxField.FieldValues = 'true;false'
      end
      item
        FieldName = 'Setor'
        Title.Alignment = taCenter
        Title.Caption = 'Setor'
        Title.Font.Color = clBlack
        Title.Font.Height = -13
        Width = 230
        Font.Color = clBlack
        Font.Height = -13
        Alignment = taCenter
        Sortable = True
        CheckBoxField.FieldValues = 'true;false'
      end>
  end
  object UniContainerPanel1: TUniContainerPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 531
    Height = 30
    Hint = ''
    ParentColor = False
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object edPesquisar: TUniEdit
      Left = 67
      Top = 4
      Width = 461
      Hint = ''
      Text = 'edPesquisar'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      TabOrder = 1
      OnKeyDown = edPesquisarKeyDown
    end
    object UniLabel1: TUniLabel
      Left = 11
      Top = 4
      Width = 50
      Height = 16
      Hint = ''
      Caption = 'Localizar'
      ParentFont = False
      Font.Color = clBlack
      Font.Height = -13
      TabOrder = 2
    end
  end
end
