object fmUpload: TfmUpload
  Left = 0
  Top = 0
  ClientHeight = 410
  ClientWidth = 702
  Caption = 'Upload'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniGroupBox2: TUniGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 696
    Height = 72
    Hint = ''
    Caption = 'Arquivos'
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    DesignSize = (
      696
      72)
    object UniBitBtn2: TUniBitBtn
      AlignWithMargins = True
      Left = 358
      Top = 19
      Width = 98
      Height = 33
      Hint = ''
      Caption = 'Ap'#243's o Login'
      Anchors = [akTop]
      TabOrder = 1
      OnClick = UniBitBtn2Click
    end
    object UniBitBtn1: TUniBitBtn
      AlignWithMargins = True
      Left = 239
      Top = 19
      Width = 114
      Height = 33
      Hint = ''
      Caption = 'Antes do Login'
      Anchors = [akTop]
      TabOrder = 2
      OnClick = UniBitBtn1Click
    end
  end
  object gpLinks: TUniGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 81
    Width = 696
    Height = 326
    Hint = ''
    Caption = 'Links '#218'teis'
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      696
      326)
    object edLinkTitulo: TUniDBEdit
      Left = 6
      Top = 39
      Width = 685
      Height = 22
      Hint = ''
      DataField = 'titulo'
      DataSource = UniMainModule.ds_links_
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object UniLabel4: TUniLabel
      Left = 6
      Top = 20
      Width = 26
      Height = 13
      Hint = ''
      Caption = 'T'#237'tulo'
      TabOrder = 2
    end
    object UniLabel5: TUniLabel
      Left = 6
      Top = 62
      Width = 18
      Height = 13
      Hint = ''
      Caption = 'Link'
      TabOrder = 3
    end
    object chkInterface: TUniDBCheckBox
      Left = 567
      Top = 81
      Width = 112
      Height = 17
      Hint = ''
      DataField = 'interface'
      DataSource = UniMainModule.ds_links_
      Caption = 'Abrir na Interface'
      Anchors = [akTop, akRight]
      TabOrder = 4
    end
    object UniDBGrid1: TUniDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 188
      Width = 690
      Height = 135
      Hint = ''
      DataSource = UniMainModule.ds_links_
      Options = [dgIndicator, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete]
      ReadOnly = True
      WebOptions.Paged = False
      LoadMask.Message = 'Loading data...'
      Align = alBottom
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 5
      Columns = <
        item
          FieldName = 'titulo'
          Title.Caption = 'titulo'
          Width = 250
          CheckBoxField.FieldValues = 'true;false'
        end
        item
          FieldName = 'link'
          Title.Caption = 'link'
          Width = 430
          CheckBoxField.FieldValues = 'true;false'
        end>
    end
    object UniDBNavigator2: TUniDBNavigator
      AlignWithMargins = True
      Left = 3
      Top = 157
      Width = 690
      Height = 25
      Hint = ''
      DataSource = UniMainModule.ds_links_
      VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      Align = alBottom
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 6
    end
    object UniDBMemo1: TUniDBMemo
      Left = 6
      Top = 81
      Width = 537
      Height = 53
      Hint = ''
      DataField = 'link'
      DataSource = UniMainModule.ds_links_
      TabOrder = 7
    end
  end
  object UniFileUpload1: TUniFileUpload
    OnCompleted = UniFileUpload1Completed
    MaxAllowedSize = 10485760
    Title = 'Upload'
    Messages.Uploading = 'Enviando...'
    Messages.PleaseWait = 'Aguarde'
    Messages.Cancel = 'Cancelar'
    Messages.Processing = 'Processando'
    Messages.UploadError = 'Erro ao realizar upload'
    Messages.Upload = 'Upload'
    Messages.NoFileError = 'Selecione um arquivo'
    Messages.BrowseText = 'Localizar'
    Left = 544
    Top = 264
  end
end
