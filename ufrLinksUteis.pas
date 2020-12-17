unit ufrLinksUteis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGUIBaseClasses, uniTreeView, uniButton,
  uniBitBtn, uniPanel, uClassUsuario;

type
  TfrLinksUteis = class(TUniFrame)
    tvLinks: TUniTreeView;
    UniContainerPanel1: TUniContainerPanel;
    btEditarLinksUteis: TUniBitBtn;
    procedure tvLinksDblClick(Sender: TObject);
    procedure tvLinksChange(Sender: TObject; Node: TUniTreeNode);
    procedure btEditarLinksUteisClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
  private
    var direitos : TDireitos;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule, Main, uManutencaoLinks, uFuncoesUnigui ;

var
  noSelecionado : TUniTreeNode;

procedure TfrLinksUteis.btEditarLinksUteisClick(Sender: TObject);
begin
//  carrega a tabela temporaria dos links
  try
    UniMainModule.CarregaLinksUteis(nil);
  except
    on e:Exception do
    begin
      ShowMessage(e.Message);
      Exit;
    end;
  end;
  fmManutencaoLinks.ShowModal
end;


procedure TfrLinksUteis.tvLinksChange(Sender: TObject; Node: TUniTreeNode);
begin
  noSelecionado := Node;
end;

procedure TfrLinksUteis.tvLinksDblClick(Sender: TObject);
begin
  UniMainModule.xml_links_uteis_.Locate('titulo',noSelecionado.Text,[]);

  if UniMainModule.xml_links_uteis_interface.AsBoolean = True then
    begin
      MainForm.imgBanner.Visible := False;

      MainForm.frmSistema.URL := UniMainModule.xml_links_uteis_link.AsString;
      MainForm.frmSistema.Align := alClient;
      MainForm.frmSistema.Visible :=  True;

      if MainForm.pnMenu.Collapsible then
        UniSession.AddJS('Ext.onReady(function () {' + MainForm.pnMenu.JSName + '.collapse()});');
    end
  else
    UniSession.AddJS('window.open("' + UniMainModule.xml_links_uteis_link.AsString + '");' );
end;

procedure TfrLinksUteis.UniFrameCreate(Sender: TObject);
begin
  //verifica se o usuario tem acesso a alterar as imagens
  direitos := uFuncoesUnigui.ValidaAcesso(IntToStr(UniMainModule.Usuario.Codigo),'INTRANET_LINKS', UniMainModule.sql_livre_);
  UniContainerPanel1.Visible := (direitos <> nil);
end;

end.
