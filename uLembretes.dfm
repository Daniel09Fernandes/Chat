object fmLembrete: TfmLembrete
  Left = 0
  Top = 0
  ClientHeight = 39
  ClientWidth = 366
  Caption = 'Lembrete'
  BorderStyle = bsDialog
  OldCreateOrder = False
  OnClose = UniFormClose
  MonitoredKeys.Keys = <>
  Font.Height = -13
  PixelsPerInch = 96
  TextHeight = 16
  object dt_: TUniDBDateTimePicker
    Left = 8
    Top = 8
    Width = 273
    Hint = ''
    DataField = 'alerta_lembrar'
    DataSource = UniMainModule.ds_tb_alertas_
    DateTime = 42716.387073321760000000
    DateFormat = 'dd/MM/yyyy'
    TimeFormat = 'HH:mm:ss'
    Kind = tUniDateTime
    TabOrder = 0
  end
  object btOk: TUniBitBtn
    AlignWithMargins = True
    Left = 286
    Top = 8
    Width = 75
    Height = 22
    Hint = ''
    Margins.Left = 12
    Margins.Top = 8
    Margins.Right = 5
    Margins.Bottom = 9
    Caption = 'OK'
    Align = alRight
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 1
    Images = UniMainModule.imgList_
    ImageIndex = 50
    OnClick = btOkClick
  end
end
