unit ufrRamais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniLabel, uniEdit, uniPanel, uniGUIBaseClasses,
  uniBasicGrid, uniDBGrid, uniButton, uniBitBtn, uFuncoesUnigui, Data.DB,
  Datasnap.DBClient, Vcl.Menus, uniMainMenu, uClassUsuario;

type
  TfrRamais = class(TUniFrame)
    gdRamais: TUniDBGrid;
    UniContainerPanel1: TUniContainerPanel;
    edPesquisar: TUniEdit;
    UniLabel1: TUniLabel;
    btEditarRamais: TUniBitBtn;
    popMenu: TUniPopupMenu;
    Excel1: TUniMenuItem;
    procedure btEditarRamaisClick(Sender: TObject);
    procedure UniFrameCreate(Sender: TObject);
    procedure gdRamaisColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure edPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Excel1Click(Sender: TObject);
    procedure gdRamaisMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
      direitos : TDireitos;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses MainModule, uManutencaoRamais, ServerModule;

procedure TfrRamais.btEditarRamaisClick(Sender: TObject);
begin
  fmManutencaoRamais.ShowModal()
end;

procedure TfrRamais.edPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  texto : string;
  achou : boolean;
begin
  if Key = 13 then
  begin
    texto := AnsiUpperCase( uFuncoesUniGui.TiraAcentos(edPesquisar.Text) );

    if UniMainModule.sql_tb_ramal_.Locate('ramal_ramal',texto,[loPartialKey,loCaseInsensitive]) then
      achou := true
    else
    if UniMainModule.sql_tb_ramal_.Locate('ramal_nome',texto,[loPartialKey,loCaseInsensitive]) then
      achou := true
    else
    if UniMainModule.sql_tb_ramal_.Locate('ramal_setor',texto,[loPartialKey,loCaseInsensitive]) then
      achou := true
  end;
end;

procedure TfrRamais.Excel1Click(Sender: TObject);
var
  xls : string;
begin
  if UniMainModule.sql_tb_ramal_.RecordCount > 0 then
  begin
    xls := UniServerModule.TempFolderPath + uFuncoesUnigui.GeraNome + '.xls';
    uFuncoesUnigui.GeraXLS(UniMainModule.sql_tb_ramal_,xls);
    if FileExists(xls) then
      UniSession.SendFile(xls);
  end
  else
  begin
    MessageDlg('Sem registros para exportar!',mtError,[mbOk],nil);
  end;
end;

procedure TfrRamais.gdRamaisColumnSort(Column: TUniDBGridColumn;
  Direction: Boolean);
begin
  OrdenaGrid(Column,Direction);
end;

procedure TfrRamais.gdRamaisMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
  begin
    if direitos <> nil then
    begin
      popMenu.Popup(x,y,gdRamais);
    end;
  end;
end;

procedure TfrRamais.UniFrameCreate(Sender: TObject);
begin
  //verifica se o usuario tem acesso a alterar as imagens
  direitos := nil;
  direitos := uFuncoesUnigui.ValidaAcesso(IntToStr(UniMainModule.Usuario.Codigo),'INTRANET_RAMAIS', UniMainModule.sql_livre_);
  btEditarRamais.Visible := (direitos <> nil);
  edPesquisar.SetFocus;
end;

end.
