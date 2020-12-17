object frLinksUteis: TfrLinksUteis
  Left = 0
  Top = 0
  Width = 552
  Height = 343
  OnCreate = UniFrameCreate
  TabOrder = 0
  object tvLinks: TUniTreeView
    Left = 0
    Top = 44
    Width = 552
    Height = 299
    Hint = ''
    Items.FontData = {0100000000}
    Align = alClient
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    Color = clWindow
    OnChange = tvLinksChange
    OnDblClick = tvLinksDblClick
  end
  object UniContainerPanel1: TUniContainerPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 546
    Height = 38
    Hint = ''
    ParentColor = False
    Align = alTop
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object btEditarLinksUteis: TUniBitBtn
      AlignWithMargins = True
      Left = 504
      Top = 3
      Width = 39
      Height = 32
      Hint = ''
      Caption = ''
      Align = alRight
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 1
      Images = UniMainModule.imgList_
      ImageIndex = 72
      OnClick = btEditarLinksUteisClick
    end
  end
end
