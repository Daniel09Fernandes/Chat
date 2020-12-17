unit uManutencaoLinks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniMemo, uniDBMemo, uniDBNavigator, uniBasicGrid,
  uniDBGrid, uniCheckBox, uniDBCheckBox, uniLabel, uniGUIBaseClasses, uniEdit,
  uniDBEdit, uniPanel;

type
  TfmManutencaoLinks = class(TUniForm)
    edLinkTitulo: TUniDBEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    chkInterface: TUniDBCheckBox;
    UniDBGrid1: TUniDBGrid;
    UniDBNavigator2: TUniDBNavigator;
    UniDBMemo1: TUniDBMemo;
    UniPanel1: TUniPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fmManutencaoLinks: TfmManutencaoLinks;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function fmManutencaoLinks: TfmManutencaoLinks;
begin
  Result := TfmManutencaoLinks(UniMainModule.GetFormInstance(TfmManutencaoLinks));
end;

end.
