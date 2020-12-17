object fmLinksUteis: TfmLinksUteis
  Left = 0
  Top = 0
  ClientHeight = 233
  ClientWidth = 537
  Caption = 'Links '#218'teis'
  OnShow = UniFormShow
  BorderStyle = bsDialog
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  PixelsPerInch = 96
  TextHeight = 13
  object tvLinks: TUniTreeView
    Left = 0
    Top = 0
    Width = 537
    Height = 233
    Hint = ''
    Items.FontData = {0100000000}
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnChange = tvLinksChange
    OnDblClick = tvLinksDblClick
  end
end
