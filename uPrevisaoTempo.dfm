object fmPrevisao: TfmPrevisao
  Left = 0
  Top = 0
  Width = 900
  Height = 528
  Caption = 'Previs'#227'o do Tempo'
  OnShow = UniFormShow
  OldCreateOrder = False
  BorderIcons = [biSystemMenu, biMaximize]
  AutoScroll = True
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object UniHTMLFrame1: TUniHTMLFrame
    Left = 0
    Top = 0
    Width = 884
    Height = 489
    Hint = ''
    AutoScroll = True
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollHeight = 489
    ScrollWidth = 884
  end
  object mtb_cidades_: TADMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 312
    Top = 320
    object mtb_cidades_cidade_cod: TIntegerField
      FieldName = 'cidade_cod'
    end
    object mtb_cidades_cidade_nome: TStringField
      FieldName = 'cidade_nome'
      Size = 40
    end
    object mtb_cidades_cod_cptec: TIntegerField
      FieldName = 'cod_cptec'
    end
  end
end
