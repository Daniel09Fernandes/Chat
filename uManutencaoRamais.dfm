object fmManutencaoRamais: TfmManutencaoRamais
  Left = 0
  Top = 0
  ClientHeight = 300
  ClientWidth = 744
  Caption = 'Manuten'#231#227'o de Ramais'
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Height = -13
  PixelsPerInch = 96
  TextHeight = 16
  object cp1_: TUniContainerPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 300
    Hint = ''
    ParentColor = False
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object gdRamais: TUniDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 399
      Height = 294
      Hint = ''
      ClientEvents.ExtEvents.Strings = (
        
          'store.load=function store.load(sender, records, successful, eOpt' +
          's)'#13#10'{'#13#10'  sender.grid.columnManager.columns.forEach(function(col)' +
          '{col.autoSize()})'#13#10'}')
      DataSource = UniMainModule.ds_tb_ramal_
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      WebOptions.Paged = False
      WebOptions.FetchAll = True
      LoadMask.Message = 'Loading data...'
      Align = alClient
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
    end
  end
  object cp2_: TUniContainerPanel
    AlignWithMargins = True
    Left = 408
    Top = 3
    Width = 333
    Height = 294
    Hint = ''
    ParentColor = False
    Align = alRight
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      333
      294)
    object lbRamal: TUniLabel
      Left = 6
      Top = 34
      Width = 36
      Height = 16
      Hint = ''
      Caption = 'Ramal'
      TabOrder = 1
    end
    object edNome: TUniDBEdit
      Left = 102
      Top = 56
      Width = 226
      Height = 22
      Hint = ''
      DataField = 'ramal_nome'
      DataSource = UniMainModule.ds_tb_ramal_
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object edRamal: TUniDBEdit
      Left = 6
      Top = 56
      Width = 90
      Height = 22
      Hint = ''
      DataField = 'ramal_ramal'
      DataSource = UniMainModule.ds_tb_ramal_
      TabOrder = 3
    end
    object UniDBEdit3: TUniDBEdit
      Left = 6
      Top = 106
      Width = 322
      Height = 22
      Hint = ''
      DataField = 'ramal_setor'
      DataSource = UniMainModule.ds_tb_ramal_
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object lbNome: TUniLabel
      Left = 102
      Top = 34
      Width = 33
      Height = 16
      Hint = ''
      Caption = 'Nome'
      TabOrder = 5
    end
    object lbDep: TUniLabel
      Left = 6
      Top = 84
      Width = 81
      Height = 16
      Hint = ''
      Caption = 'Departamento'
      TabOrder = 6
    end
    object nav1_: TUniDBNavigator
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 327
      Height = 25
      Hint = ''
      DataSource = UniMainModule.ds_tb_ramal_
      VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      Align = alTop
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 7
    end
    object chkAtivo: TUniDBCheckBox
      Left = 6
      Top = 134
      Width = 59
      Height = 17
      Hint = ''
      DataField = 'ramal_ativo'
      DataSource = UniMainModule.ds_tb_ramal_
      Caption = 'Ativo'
      TabOrder = 8
    end
    object chPublico: TUniDBCheckBox
      Left = 69
      Top = 134
      Width = 84
      Height = 17
      Hint = ''
      DataField = 'ramal_publico'
      DataSource = UniMainModule.ds_tb_ramal_
      Caption = 'P'#250'blico'
      TabOrder = 9
    end
    object UniMemo1: TUniMemo
      AlignWithMargins = True
      Left = 3
      Top = 232
      Width = 327
      Height = 59
      Hint = ''
      Lines.Strings = (
        'Aten'#231#227'o!'
        
          'Somente os ramais P'#250'blicos ser'#227'o listados para as Unidades de Ne' +
          'g'#243'cio')
      Align = alBottom
      Anchors = [akLeft, akRight, akBottom]
      ReadOnly = True
      Color = clBtnFace
      TabOrder = 10
    end
  end
end
