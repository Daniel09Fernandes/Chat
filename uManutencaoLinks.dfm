object fmManutencaoLinks: TfmManutencaoLinks
  Left = 0
  Top = 0
  ClientHeight = 325
  ClientWidth = 604
  Caption = 'Manuten'#231#227'o de Links '#218'teis'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Height = -13
  PixelsPerInch = 96
  TextHeight = 16
  object UniDBGrid1: TUniDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 598
    Height = 159
    Hint = ''
    ClientEvents.ExtEvents.Strings = (
      
        'store.load=function store.load(sender, records, successful, eOpt' +
        's)'#13#10'{'#13#10'sender.grid.columnManager.columns.forEach(function(col){c' +
        'ol.autoSize()})'#13#10'}')
    DataSource = UniMainModule.ds_links_uteis_
    Options = [dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete]
    ReadOnly = True
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    Columns = <
      item
        FieldName = 'titulo'
        Title.Caption = 'titulo'
        Width = 250
        Font.Height = -13
        CheckBoxField.FieldValues = 'true;false'
      end>
  end
  object UniPanel1: TUniPanel
    AlignWithMargins = True
    Left = 3
    Top = 168
    Width = 598
    Height = 154
    Hint = ''
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    Caption = 'UniPanel1'
    DesignSize = (
      598
      154)
    object chkInterface: TUniDBCheckBox
      Left = 455
      Top = 88
      Width = 131
      Height = 16
      Hint = ''
      DataField = 'interface'
      DataSource = UniMainModule.ds_links_uteis_
      Caption = 'Abrir na Interface'
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object edLinkTitulo: TUniDBEdit
      AlignWithMargins = True
      Left = 13
      Top = 37
      Width = 418
      Height = 22
      Hint = ''
      DataField = 'titulo'
      DataSource = UniMainModule.ds_links_uteis_
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object UniDBMemo1: TUniDBMemo
      AlignWithMargins = True
      Left = 13
      Top = 87
      Width = 418
      Height = 53
      Hint = ''
      DataField = 'link'
      DataSource = UniMainModule.ds_links_uteis_
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object UniDBNavigator2: TUniDBNavigator
      AlignWithMargins = True
      Left = 455
      Top = 37
      Width = 131
      Height = 22
      Hint = ''
      DataSource = UniMainModule.ds_links_uteis_
      VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object UniLabel4: TUniLabel
      AlignWithMargins = True
      Left = 13
      Top = 15
      Width = 32
      Height = 16
      Hint = ''
      Caption = 'T'#237'tulo'
      TabOrder = 5
    end
    object UniLabel5: TUniLabel
      AlignWithMargins = True
      Left = 13
      Top = 65
      Width = 22
      Height = 16
      Hint = ''
      Caption = 'Link'
      TabOrder = 6
    end
  end
end
