unit uLinksUteis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniTreeView;

type
  TfmLinksUteis = class(TUniForm)
    tvLinks: TUniTreeView;
    procedure tvLinksDblClick(Sender: TObject);
    procedure tvLinksChange(Sender: TObject; Node: TUniTreeNode);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fmLinksUteis: TfmLinksUteis;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;


var
  noSelecionado : TUniTreeNode;


function fmLinksUteis: TfmLinksUteis;
begin
  Result := TfmLinksUteis(UniMainModule.GetFormInstance(TfmLinksUteis));
end;

procedure TfmLinksUteis.tvLinksChange(Sender: TObject; Node: TUniTreeNode);
begin
  noSelecionado := Node;
end;

procedure TfmLinksUteis.tvLinksDblClick(Sender: TObject);
begin
  UniMainModule.cds_links_.Locate('titulo',noSelecionado.Text,[]);

  if UniMainModule.cds_links_interface.AsBoolean = True then
    begin

      MainForm.imgBanner.Visible := False;

      MainForm.frmSistema.URL := UniMainModule.cds_links_link.AsString;
      MainForm.frmSistema.Align := alClient;
      MainForm.frmSistema.Visible :=  True;

      if MainForm.pnMenu.Collapsible then
        UniSession.AddJS('Ext.onReady(function () {' + MainForm.pnMenu.JSName + '.collapse()});');

      Self.Close
    end
  else
    UniSession.AddJS('window.open("' + UniMainModule.cds_links_link.AsString + '");' );
end;

procedure TfmLinksUteis.UniFormShow(Sender: TObject);
begin
  tvLinks.Visible := False;
  tvLinks.Items.Clear;

  if UniMainModule.cds_links_.Active = False then
    UniMainModule.cds_links_.Open;

  UniMainModule.cds_links_.First;

  while not UniMainModule.cds_links_.Eof do
    begin
      tvLinks.Items.Add(nil,UniMainModule.cds_links_titulo.AsString);
      UniMainModule.cds_links_.Next;
    end;

  tvLinks.Visible := True;
end;

end.
