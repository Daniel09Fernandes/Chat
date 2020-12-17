unit uRamais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, data.db,
  Controls, Forms, Dialogs,
  uniGUIClasses, uniGUIForm, uniDBGrid,
  uniLabel, uniEdit, uniPanel, uFuncoesUnigui, uniGUIBaseClasses, uniBasicGrid;

type
  TfmRamais = class(TUniForm)
    gdRamais: TUniDBGrid;
    UniContainerPanel1: TUniContainerPanel;
    edPesquisar: TUniEdit;
    UniLabel1: TUniLabel;
    procedure UniFormCreate(Sender: TObject);
    procedure gdRamaisColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fmRamais: TfmRamais;

implementation

{$R *.dfm}

uses
  MainModule;

function fmRamais: TfmRamais;
begin
  Result := TfmRamais(UniMainModule.GetFormInstance(TfmRamais));
end;

procedure TfmRamais.edPesquisarKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
var x : string;
begin
  if edPesquisar.Text <> '' then
  begin
    x := trim(edPesquisar.Text);
    UniMainModule.cds_ramais_.Locate('Nome',x, ([loCaseInsensitive, loPartialKey]));
  end;
end;

procedure TfmRamais.gdRamaisColumnSort(Column: TUniDBGridColumn;Direction: Boolean);
begin
  OrdenaGrid(Column,Direction);
end;

procedure TfmRamais.UniFormCreate(Sender: TObject);
begin
  edPesquisar.Text := '';
  edPesquisar.SetFocus;
end;

end.
