unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes,
  uADCompClient, uADCompGUIx, Data.DB, uADPhysPG,
  Datasnap.DBClient, uADStanParam, uADCompDataSet, uClassUsuario,
  Data.SqlExpr, uFuncoesUnigui, uADStanIntf, uADStanOption, uADStanError,
  uADGUIxIntf, uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync,
  uADPhysManager, uADDatSManager, uADDAptIntf, uADDAptManager, uADGUIxFormsWait,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, uniGUIBaseClasses,
  uniGUIClasses, uniImageList, uniTreeView, uniGUIAbstractClasses, System.IniFiles;

type
  TUniMainModule = class(TUniGUIMainModule)
    xml_links_uteis_: TClientDataSet;
    xml_links_uteis_titulo: TStringField;
    xml_links_uteis_interface: TBooleanField;
    xml_links_uteis_link: TMemoField;
    ds_links_uteis_: TDataSource;
    humanitarian_: TADConnection;
    PGLink: TADPhysPgDriverLink;
    sql_carrega_menu_: TADQuery;
    sql_carrega_menu_telas_nome: TStringField;
    sql_carrega_menu_telas_descricao: TStringField;
    sql_carrega_menu_telas_link: TStringField;
    sql_carrega_menu_grupo: TStringField;
    sql_carrega_menu_telas_grupo: TStringField;
    cds_carrossel_: TClientDataSet;
    cds_carrossel_arquivo: TStringField;
    cds_carrossel_data: TDateField;
    cds_telas_: TClientDataSet;
    cds_telas_telas_id: TIntegerField;
    cds_telas_telas_nome: TStringField;
    cds_telas_telas_descricao: TStringField;
    cds_telas_telas_link: TStringField;
    cds_telas_telas_grupo: TStringField;
    cds_telas_grupo: TStringField;
    ADTransaction1: TADTransaction;
    sql_tb_alertas_: TADQuery;
    ds_tb_alertas_: TDataSource;
    sql_tb_alertas_alerta_id: TIntegerField;
    sql_tb_alertas_usuario_codigo: TIntegerField;
    sql_tb_alertas_alerta_msg: TStringField;
    sql_tb_alertas_alerta_link: TMemoField;
    sql_tb_alertas_alerta_visualizacao: TSQLTimeStampField;
    sql_tb_alertas_alerta_ativo: TStringField;
    sql_livre_: TADQuery;
    sql_tb_alertas_alerta_envio: TSQLTimeStampField;
    sql_notificacoes_: TADQuery;
    xml_arquivos_: TClientDataSet;
    xml_arquivos_arquivo: TStringField;
    xml_arquivos_data: TDateTimeField;
    xml_arquivos_tipo: TStringField;
    imgList_: TUniImageList;
    sql_tb_alertas_alerta_lembrar: TSQLTimeStampField;
    sql_tb_alertas_alerta_inicio_alerta: TSQLTimeStampField;
    sql_tb_alertas_calc_data: TDateField;
    sql_tb_alertas_alerta_nao_visualizar: TBooleanField;
    sql_tb_ramal_: TADQuery;
    sql_tb_ramal_ramal_id: TIntegerField;
    sql_tb_ramal_ramal_ramal: TStringField;
    sql_tb_ramal_ramal_nome: TStringField;
    sql_tb_ramal_ramal_setor: TStringField;
    sql_tb_ramal_ramal_ativo: TBooleanField;
    ds_tb_ramal_: TDataSource;
    mtb_ramal_: TADMemTable;
    mtb_ramal_ramal_id: TIntegerField;
    mtb_ramal_ramal_ramal: TStringField;
    mtb_ramal_ramal_nome: TStringField;
    mtb_ramal_ramal_setor: TStringField;
    mtb_ramal_ramal_ativo: TBooleanField;
    xml_ramais_: TClientDataSet;
    xml_ramais_ramal: TIntegerField;
    xml_ramais_nome: TStringField;
    xml_ramais_setor: TStringField;
    sql_tb_ramal_ramal_publico: TBooleanField;
    procedure CarregaTelas;
    procedure post(DataSet: TDataSet);
    procedure xml_arquivos_AfterPost(DataSet: TDataSet);
    procedure sql_tb_ramal_BeforePost(DataSet: TDataSet);
  private
  public
    usuario : TUsuario;
//    direitos : TDireitos;
    //configuracoes importadas do ini
    var   path_imagens : string;
    var   qtd_carrossel : integer;
    var   intervalo_sync_notificacoes : Integer;
    var   x_sql_notificacoes_ : string;
    procedure CarregaLinksUteis(tv_ : TUniTreeView);
    procedure CarregaMenu(tv_ : TUniTreeView);
    procedure ConfiguracoesIni;
    procedure AbreConexao;
    procedure FechaConexao;
  end;

  //utilizado no menu
  type
    TNodeData = class
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

procedure TUniMainModule.post(DataSet: TDataSet);
var x : string;
begin
  x := UniServerModule.FilesFolderPath;

  if (DataSet is TClientDataSet) then
  begin
    if DataSet.Name = 'cds_arquivo_' then
      (DataSet as TClientDataSet).SaveToFile(x + 'arquivo.xml')
    else
    if DataSet.Name = 'cds_links_' then
      (DataSet as TClientDataSet).SaveToFile( x + 'links.xml')
  end;

  DataSet.Close;
  DataSet.Open;
end;

procedure TUniMainModule.sql_tb_ramal_BeforePost(DataSet: TDataSet);
var
  I: Integer;
begin
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    if (DataSet.Fields[i] is TStringField) then
      DataSet.Fields[i].Value := uFuncoesUnigui.TiraAcentos(DataSet.Fields[i].Value);
  end;
end;

procedure TUniMainModule.xml_arquivos_AfterPost(DataSet: TDataSet);
begin
  if (DataSet is TClientDataSet) then
    (DataSet as TClientDataSet).SaveToFile(UniServerModule.FilesFolderPath + 'imagens.xml');
end;

procedure TUniMainModule.AbreConexao;
begin
  if humanitarian_.Connected = False then
    humanitarian_.Connected := True;
end;

procedure TUniMainModule.CarregaLinksUteis(tv_ : TUniTreeView);
var
  xml : string;
begin
  xml := UniServerModule.FilesFolderPath + 'links.xml';

  if not FileExists(xml) then
  begin
    raise Exception.Create('Erro ao obter lista de Links! Arquivo de dados(XML) não encontrado');
  end;

  try
    if xml_links_uteis_.Active = false then
    begin
      xml_links_uteis_.CreateDataSet;
      xml_links_uteis_.LoadFromFile(xml);
      xml_links_uteis_.Open;
    end;

    if tv_ <> nil then
    begin
      tv_.BeginUpdate;

      tv_.Items.Clear;

      UniMainModule.xml_links_uteis_.First;

      while not xml_links_uteis_.Eof do
      begin
        tv_.Items.Add(nil,UniMainModule.xml_links_uteis_titulo.AsString);
        UniMainModule.xml_links_uteis_.Next;
      end;

      tv_.EndUpdate;
    end;
  except
    on e:Exception do
      raise Exception.Create('Erro ao obter lista de Links! ' + e.Message);
  end;
end;

procedure TUniMainModule.CarregaMenu(tv_: TUniTreeView);
var
  noPai, noFilho, noLimpar : TUniTreeNode;
  i : Integer;
begin
  tv_.BeginUpdate;

  for I := 0 to tv_.Items.Count - 1 do
  begin
    noLimpar := tv_.Items[I];
    if noLimpar.Data <> nil then
      noLimpar.Data := nil;
    noLimpar.Free;
  end;

  noPai   := nil;
  noFilho := nil;

  UniMainModule.CarregaTelas;
  UniMainModule.cds_telas_.First;

  while not UniMainModule.cds_telas_.Eof do
  begin
    if (noPai = nil) or (noPai.Text <> UniMainModule.cds_telas_telas_grupo.AsString) then
    begin
      noPai := tv_.Items.Add(nil,UniMainModule.cds_telas_telas_grupo.AsString);
      noPai.Font.Name  := 'Verdana';
      noPai.Font.Size  := 10;
      noPai.ImageIndex := 0;
    end;
    noFilho := tv_.Items.Add(noPai,UniMainModule.cds_telas_telas_descricao.AsString);
    noFilho.Font.Size  := 9;
    noFilho.Font.Name  := 'Verdana';
    noFilho.Font.Style := [];
    noFilho.ImageIndex := 1;
    try
      noFilho.Data := TNodeData.Create;
      noFilho.Data := Pointer(UniMainModule.cds_telas_telas_id.AsInteger);
    except
      on e:exception do
        raise Exception.Create('Erro ao carregar Menu !'+ sLineBreak + e.Message);
    end;
    UniMainModule.cds_telas_.Next;
  end;
  tv_.EndUpdate;
end;

procedure TUniMainModule.CarregaTelas;
var i : integer;
begin
  if cds_telas_.Active = false then
    cds_telas_.CreateDataSet
  else
    cds_telas_.EmptyDataSet;

  sql_carrega_menu_.Active := False;
  sql_carrega_menu_.Params[0].AsInteger := UniMainModule.Usuario.Codigo;
  sql_carrega_menu_.Active := True;
  sql_carrega_menu_.First;
  i := 0;

  while not sql_carrega_menu_.Eof do
  begin
    inc(i);
    cds_telas_.Insert;
    cds_telas_telas_id.AsInteger       := i;
    cds_telas_telas_nome.AsString      := sql_carrega_menu_telas_nome.AsString;
    cds_telas_telas_descricao.AsString := sql_carrega_menu_telas_descricao.AsString;
    cds_telas_telas_link.AsString      := sql_carrega_menu_telas_link.AsString;
    cds_telas_telas_grupo.AsString     := sql_carrega_menu_telas_grupo.AsString;
    cds_telas_grupo.AsString           := sql_carrega_menu_grupo.AsString;
    cds_telas_.Post;

    sql_carrega_menu_.Next;
  end;
end;

procedure TUniMainModule.ConfiguracoesIni;
var
  ini : TIniFile;
begin
  if not FileExists(UniServerModule.FilesFolderPath + 'config.ini') then
  begin
    raise Exception.Create('Arquivo de configuração(ini) não encontrado');
  end;

  ini := TIniFile.Create(UniServerModule.FilesFolderPath +'config.ini');

  //intervalo de sincronizacao das notificacoes
  Self.intervalo_sync_notificacoes := ini.ReadInteger('alerta','intervalo',1000);
  //caminho da imagem
  Self.path_imagens := ini.ReadString('imagens','path','C:\Apps\AppIntranet\Imagens');
  //quantidade de humanews para aparecer no carrossel
  Self.qtd_carrossel := ini.ReadInteger('carrossel','quantidade',3);
end;

procedure TUniMainModule.FechaConexao;
begin
  if humanitarian_.Connected = True then
    humanitarian_.Connected := False;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
