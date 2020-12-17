unit uManutencaoRamais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniButton, uniBitBtn,
  uniBasicGrid, uniDBGrid, uniLabel, uniDBNavigator, uniPanel, uniEdit,
  uniDBEdit, uniCheckBox, uniDBCheckBox, uniMemo;

type
  TfmManutencaoRamais = class(TUniForm)
    lbNome: TUniLabel;
    lbRamal: TUniLabel;
    lbDep: TUniLabel;
    edNome: TUniDBEdit;
    edRamal: TUniDBEdit;
    UniDBEdit3: TUniDBEdit;
    cp1_: TUniContainerPanel;
    cp2_: TUniContainerPanel;
    gdRamais: TUniDBGrid;
    nav1_: TUniDBNavigator;
    chkAtivo: TUniDBCheckBox;
    chPublico: TUniDBCheckBox;
    UniMemo1: TUniMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fmManutencaoRamais: TfmManutencaoRamais;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function fmManutencaoRamais: TfmManutencaoRamais;
begin
  Result := TfmManutencaoRamais(UniMainModule.GetFormInstance(TfmManutencaoRamais));
end;

end.
