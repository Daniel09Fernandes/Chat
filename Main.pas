unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm,
  uniTimer, uniImage, uniPanel, uniBitBtn, uniLabel, uniTreeView, uniURLFrame,
  uniImageList, uFuncoesUnigui, uniGUIBaseClasses, uniButton,
  Vcl.Imaging.pngimage, System.IniFiles, uniMemo, uniDBMemo, Vcl.Menus,
  uniMainMenu, uniGUIFrame, uniGUIRegClasses, uniEdit, uniDBEdit, uADStanIntf,
  uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf,
  uADDAptIntf, Data.DB, uADCompDataSet, uADCompClient, uniHTMLFrame,
  uniThreadTimer;

type
  TMainForm = class(TUniForm)
    UniTimer1: TUniTimer;
    frmSistema: TUniURLFrame;
    pnMenu: TUniPanel;
    tvMenu: TUniTreeView;
    imgBanner: TUniImage;
    pnTopo: TUniContainerPanel;
    btMenu: TUniImage;
    imgLogoPequeno: TUniImage;
    imgRamais: TUniImage;
    imgLinksUteis: TUniImage;
    imgNotificacoes: TUniImage;
    imgConfig: TUniImage;
    imgMenu: TUniImage;
    lbQtdNotificacoes: TUniLabel;
    pnPostIt: TUniPanel;
    imgNotificacao: TUniImage;
    UniDBMemo1: TUniDBMemo;
    pnFrame: TUniPanel;
    pnClose: TUniContainerPanel;
    btCloseFrame: TUniImage;
    btLembrar: TUniImage;
    btNaoVerNovamente: TUniImage;
    UniImage2: TUniImage;
    UniImage3: TUniImage;
    UniImage4: TUniImage;
    lbLinkNotificacao: TUniLabel;
    UniLabel1: TUniLabel;
    UniDBEdit1: TUniDBEdit;
    lbTituloFrame: TUniLabel;
    imgEntregas: TUniImage;
    mtbNotificacoes: TADMemTable;
    mtbNotificacoesalerta_id: TIntegerField;
    imgCalendario: TUniImage;
    imgChat: TUniImage;
    lblChatNotf: TUniLabel;
    imgPrevisao: TUniImage;
    Html_alerta: TUniHTMLFrame;
    VerificaChat: TUniThreadTimer;
    NotifiChat_Alerta: TUniTimer;
    function TrataNome(Str: string): string;
    procedure AbreImagem(sim: Boolean);
    procedure tvMenuClick(Sender: TObject);
    procedure UniTimer1Timer(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
    procedure IconeTopoClick(Sender: TObject);
    procedure btCloseFrameClick(Sender: TObject);
    procedure UniImage2Click(Sender: TObject);
    procedure UniImage4Click(Sender: TObject);
    procedure UniImage3Click(Sender: TObject);
    procedure btNaoVerNovamenteClick(Sender: TObject);
    procedure lbLinkNotificacaoClick(Sender: TObject);
    procedure btLembrarClick(Sender: TObject);
    procedure UniFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
    procedure lblChatNotfMouseEnter(Sender: TObject);
    procedure lblChatNotfMouseLeave(Sender: TObject);
    procedure lbQtdNotificacoesMouseEnter(Sender: TObject);
    procedure lbQtdNotificacoesMouseLeave(Sender: TObject);
    procedure VerificaChatTimer(Sender: TObject);
    procedure NotificaChat_Alerta(Sender: TObject);
    procedure UniBitBtn1Click(Sender: TObject);
  private
    UserLogado: integer;
    chatRegistros: Integer;
    clicado:Integer;
    var
      noSelecionado: TUniTreeNode;
//    var item_menu      : integer;
      var
      icone: TUniImage;
      var
      FrameComp: TUniFrame;
    procedure TesteUnitEnviaAlerta;
    procedure checaChat;
    procedure geraAlertaJS;
  public
    procedure ChecaNotificacoes;
    procedure MarcaLida;
    procedure AbreFrame(Frame: TUniFrameClass; Parent: TWinControl);
    procedure AbreLinkPortal(link: string);
    procedure IconeClicado(Sender: TObject; click: Boolean);
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, uLembretes, ufrRamais,
  ufrLinksUteis, ufrConfiguracoes, uCronogramaEntrega, ServerModule,
  uClassUsuario, uCalendarioVisitas, uchat, uPrevisaoTempo;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.AbreFrame(Frame: TUniFrameClass; Parent: TWinControl);
begin
  try
    if Assigned(FrameComp) then
    begin
      btCloseFrameClick(btCloseFrame);
      FrameComp.Free;
    end;

    if Parent = nil then
      Parent := Self;

    FrameComp := Frame.Create(Self);
    FrameComp.Name := Frame.ClassName;
    FrameComp.Parent := Parent;
    FrameComp.Align := alClient;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TMainForm.AbreImagem(sim: Boolean);
begin
  if sim = True then
  begin
    imgBanner.Align := alClient;
    imgBanner.Visible := True;
    frmSistema.URL := '';
    frmSistema.Align := alNone;
    frmSistema.Visible := False;
  end
  else
  begin
    imgBanner.Align := alNone;
    imgBanner.Visible := False;
    frmSistema.Align := alClient;
    frmSistema.Visible := True;
  end;
end;

procedure TMainForm.AbreLinkPortal(link: string);
begin
  if Pos('?', link) > 0 then
    link := link + '&HTN=' + Crypt('C', IntToStr(UniMainModule.Usuario.Codigo))
  else
    link := link + '/?HTN=' + Crypt('C', IntToStr(UniMainModule.Usuario.Codigo));

  frmSistema.URL := link;
  AbreImagem(False);

  if pnMenu.Collapsible then
    UniSession.AddJS('Ext.onReady(function () {' + pnMenu.JSName + '.collapse()});');
end;

procedure TMainForm.ChecaNotificacoes;
begin
  if Trim(UniMainModule.x_sql_notificacoes_) = '' then
    UniMainModule.x_sql_notificacoes_ := uFuncoesUnigui.TBSelects(UniMainModule.sql_livre_, 'NOTIFICACOES_INTRANET');

  UniMainModule.sql_notificacoes_.Close;
  UniMainModule.sql_notificacoes_.SQL.Text := UniMainModule.x_sql_notificacoes_;
  UniMainModule.sql_notificacoes_.Params[0].AsInteger := UniMainModule.usuario.Codigo;
  UniMainModule.sql_notificacoes_.Open;

  if mtbNotificacoes.Active = false then
    mtbNotificacoes.Open
  else
    mtbNotificacoes.EmptyDataSet;

  mtbNotificacoes.CopyDataSet(UniMainModule.sql_notificacoes_, [coRestart, coAppend]);

  //ativa ou desativa o label das notificacões
  if mtbNotificacoes.RecordCount > 0 then
  begin
    lbQtdNotificacoes.Caption := IntToStr(mtbNotificacoes.RecordCount);
    lbQtdNotificacoes.Visible := True;
    UniSession.AddJS('document.title="(' + IntToStr(mtbNotificacoes.RecordCount) + ') Portal Intranet"');
  end
  else
  begin
    lbQtdNotificacoes.Caption := '00';
    lbQtdNotificacoes.Visible := False;
    UniSession.AddJS('document.title="Portal Intranet"');
  end;

  IconeClicado(imgNotificacoes, pnPostIt.Visible);
end;

procedure TMainForm.IconeClicado(Sender: TObject; click: Boolean);
const
  //links uteis
  links_uteis_n_ = 'links.png';
  links_uteis_c_ = 'links_clicado.png';
  //ramais
  ramais_n_ = 'ramais.png';
  ramais_c_ = 'ramais_clicado.png';
  //configuracoes
  configuracoes_n_ = 'configuracoes.png';
  configuracoes_c_ = 'configuracoes_clicado.png';
  //notificacoes
  notificacoes_n_ = 'notificacoes.png';
  notificacoes_c_ = 'notificacoes_clicado.png';
  //notificacoes com alerta
  notificacoes_alerta_n_ = 'notificacoes_alerta.png';
  notificacoes_alerta_c_ = 'notificacoes_alerta_clicado.png';
  //cronograma de entregas
  entregas_n_ = 'entrega.png';
  entregas_c_ = 'entrega_clicado.png';
  //previsao
  previsao_n_ = 'previsao.png';
  previsao_c_ = 'previsao_clicado.png';
var
  x: string;
begin

  if click then
  begin
    UniTimer1.Enabled := False;
    UniMainModule.AbreConexao;
  end
  else
  begin
    UniTimer1.Enabled := True;
    UniMainModule.FechaConexao;
  end;

  if Sender = imgConfig then
  begin
    if click then
      x := configuracoes_c_
    else
      x := configuracoes_n_;
  end
  else if Sender = imgRamais then
  begin
    if click then
      x := ramais_c_
    else
      x := ramais_n_;
  end
  else if Sender = imgLinksUteis then
  begin
    if click then
      x := links_uteis_c_
    else
      x := links_uteis_n_;
  end
  else if Sender = imgNotificacoes then
  begin
    if mtbNotificacoes.RecordCount > 0 then
    begin
      if click then
        x := notificacoes_alerta_c_
      else
        x := notificacoes_alerta_n_;
    end
    else
    begin
      if click then
        x := notificacoes_c_
      else
        x := notificacoes_n_;
    end;
  end
  else if Sender = imgEntregas then
  begin
    if click then
      x := entregas_c_
    else
      x := entregas_n_;
  end
  else if Sender = imgPrevisao then
  begin
    if click then
      x := previsao_c_
    else
      x := previsao_n_;
  end
  else
    x := '';

  if x <> '' then
    (Sender as TUniImage).Picture.LoadFromFile(UniServerModule.FilesFolderPath + x);
end;

procedure TMainForm.geraAlertaJS;
begin
  UniSession.AddJS('alert("Voce tem uma nova mensagem!")');
  MessageBeep(MB_ICONHAND);
  Sleep(2000);
  MessageBeep(MB_ICONHAND);
  Sleep(2000);
  MessageBeep(MB_ICONHAND);
end;

procedure TMainForm.IconeTopoClick(Sender: TObject);
var
  direitos: TDireitos;
  chat: TfrmChat;
begin
  Self.icone := (Sender as TUniImage);

   //altera o icone para clicado
  IconeClicado(Sender, True);

  //altera o título da janela
  lbTituloFrame.Caption := Self.icone.Hint;

  //chat
  if Self.icone = imgChat then
  begin

    if clicado = 0 then
    begin
      clicado := 1;
      VerificaChat.Enabled := False;
      direitos := nil;
      direitos := uFuncoesUniGui.ValidaAcesso(IntToStr(UniMainModule.usuario.Codigo), 'TFRMCHAT', UniMainModule.sql_livre_);
      if (direitos = nil) then
      begin
        MessageDlg('Sem permissão de acesso', mtConfirmation, [mbOK]);
        frmchat.Close;
      end
      else
      begin
        if (direitos <> nil) then
        begin
          frmChat.Show(
            procedure(Sender: TComponent; Res: Integer)
            begin
              UniMainModule.FechaConexao;
              VerificaChat.Enabled := true;
              clicado := 0;
            end);
          frmchat.PodeAcessar := true;
        end;
      end;
    end;
  end;

  //Calendario
  if Self.icone = imgCalendario then
  begin
    VerificaChat.Enabled := False;
    UniMainModule.AbreConexao;
    FrmCalendarioVisitas.ShowModal(
      procedure(Sender: TComponent; Res: Integer)
      begin
        if Sender <> nil then
        begin
          UniMainModule.FechaConexao;
          VerificaChat.Enabled := true;
        end;
      end);
  end;

  //CONFIGURACOES
  if Self.icone = imgConfig then
  begin
    Self.AbreFrame(TfrConfiguracoes, pnFrame);
    pnFrame.Visible := True;
  end
  else  //NOTIFICACOES
if Self.icone = imgNotificacoes then
  begin
    pnPostIt.Visible := true;

    try
      UniMainModule.sql_tb_alertas_.Close;
      UniMainModule.sql_tb_alertas_.Params[0].AsInteger := uniMainModule.usuario.Codigo;
      UniMainModule.sql_tb_alertas_.Open;
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
        UniMainModule.FechaConexao;
      end;
    end;

    if mtbNotificacoes.RecordCount > 0 then
    begin
      UniMainModule.sql_tb_alertas_.Locate('alerta_id', mtbNotificacoesalerta_id.AsInteger, []);
      MarcaLida; //se nao tiver visualizada, marca
      ChecaNotificacoes; //atualiza o contador
    end;
  end
  else  //RAMAIS
if Self.icone = imgRamais then
  begin
    try
      UniMainModule.sql_tb_ramal_.Close;

      if UniMainModule.usuario.Filial in [98, 99] then
        UniMainModule.sql_tb_ramal_.Params[0].AsString := '%'
      else
        UniMainModule.sql_tb_ramal_.Params[0].AsString := 'S';

      UniMainModule.sql_tb_ramal_.Open;
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
        UniMainModule.FechaConexao;
      end;
    end;

    Self.AbreFrame(TfrRamais, pnFrame);
    pnFrame.Visible := True;

  end
  else  //LINKS UTEIS
if Self.icone = imgLinksUteis then
  begin
    AbreFrame(TfrLinksUteis, pnFrame);
    //carrega a tabela temporaria dos links
    try
      UniMainModule.CarregaLinksUteis((FrameComp as tfrLinksUteis).tvLinks);
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
        btCloseFrameClick(btCloseFrame);
        Exit;
      end;
    end;
    pnFrame.Visible := True;
    UniMainModule.FechaConexao;
  end
  else if Self.icone = imgEntregas then
  begin
    //se tiver mais alguma janela aberta, fecha
    if FrameComp <> nil then
    begin
      btCloseFrameClick(btCloseFrame);
    end;
    VerificaChat.Enabled := False;

    direitos := nil;
    direitos := uFuncoesUniGui.ValidaAcesso(IntToStr(UniMainModule.usuario.Codigo), 'TFRMCRONOGRAMAENTREGA', UniMainModule.sql_livre_);

    frmCronogramaEntrega.adCon_ := UniMainModule.humanitarian_;
    frmCronogramaEntrega.filial := UniMainModule.usuario.Filial;
    frmCronogramaEntrega.supervisor := ((direitos <> nil) and (direitos.Supervisor = true));

    frmCronogramaEntrega.ShowModal(
      procedure(Sender: TComponent; Res: Integer)
      begin
//      if Res = mrOk then
        IconeClicado(Self.icone, False);
        UniMainModule.FechaConexao;
        VerificaChat.Enabled := true;
      end);
  end
  else if Self.icone = imgPrevisao then
  begin
    VerificaChat.Enabled := False;

    if UniMainModule.usuario.Filial in [98,99] then
    begin
      fmPrevisao.Width       := 900;
      fmPrevisao.Height      := 528;
      fmPrevisao.BorderStyle := bsSizeable;
      fmPrevisao.BorderIcons := [biSystemMenu,biMaximize];
    end
    else
    begin
      fmPrevisao.Width  := 220;
      fmPrevisao.Height := 235;
      fmPrevisao.BorderStyle := bsDialog;
    end;

    fmPrevisao.Show(
      procedure(Sender: TComponent; Res: Integer)
      begin
        Self.IconeClicado(imgPrevisao, false);
        UniMainModule.FechaConexao;
        VerificaChat.Enabled := true;
      end);
  end;

end;

procedure TMainForm.imgMenuClick(Sender: TObject);
begin
  AbreImagem(True);
  if pnMenu.Collapsible then
    UniSession.AddJS('Ext.onReady(function () {' + pnMenu.JSName + '.expand()});');
end;

procedure TMainForm.lblChatNotfMouseEnter(Sender: TObject);
begin
  lblChatNotf.Font.Color := $000D86FF;
end;

procedure TMainForm.lblChatNotfMouseLeave(Sender: TObject);
begin
  lblChatNotf.Font.Color := clWhite;
end;

procedure TMainForm.lbLinkNotificacaoClick(Sender: TObject);
begin
  AbreLinkPortal(UniMainModule.sql_tb_alertas_alerta_link.AsString);
end;

procedure TMainForm.lbQtdNotificacoesMouseEnter(Sender: TObject);
begin
  lbQtdNotificacoes.Font.Color := $000D86FF;
end;

procedure TMainForm.lbQtdNotificacoesMouseLeave(Sender: TObject);
begin
  lbQtdNotificacoes.Font.Color := clWhite;
end;

procedure TMainForm.MarcaLida;
begin
  if not (UniMainModule.sql_tb_alertas_alerta_msg.AsString = '') then
  begin
    try
      UniMainModule.sql_tb_alertas_.Edit;
      UniMainModule.sql_tb_alertas_alerta_visualizacao.AsDateTime := Now;
      UniMainModule.sql_tb_alertas_.Post;
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
        UniMainModule.FechaConexao;
      end;
    end;
  end;
end;

procedure TMainForm.TesteUnitEnviaAlerta;
begin
  //  uFuncoesUnigui.EnviarAlerta(UniMainModule.sql_livre_,1068,'Olá mundo 2','');
end;

function TMainForm.TrataNome(Str: string): string;
var
  i: integer;
  esp: boolean;
begin
  Str := LowerCase(Trim(Str));
  for i := 1 to Length(Str) do
  begin
    if i = 1 then
      Str[i] := UpCase(Str[i])
    else
    begin
      if i <> Length(Str) then
      begin
        esp := (Str[i] = ' ');
        if esp then
          Str[i + 1] := UpCase(Str[i + 1]);
      end;
    end;
  end;
  Result := Str;
end;

procedure TMainForm.tvMenuClick(Sender: TObject);
var
  xLink: string;
  i: integer;
begin
  if tvMenu.Selected.Data <> nil then
    i := Integer(tvMenu.Selected.Data);

  noSelecionado := nil;
  noSelecionado := tvMenu.Selected;

  try
    if not noSelecionado.HasChildren then
    begin
      if UniMainModule.cds_telas_.Locate('telas_id', i, []) then
      begin
        xLink := UniMainModule.cds_telas_telas_link.AsString;

        AbreLinkPortal(xLink);
      end
      else
        ShowMessage('Item não encontrado !');
    end;
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;
end;

procedure TMainForm.btCloseFrameClick(Sender: TObject);
begin
  pnFrame.Visible := false;

  //passa o click como falso para voltar os icones ao normal
  if Self.FrameComp is TfrLinksUteis then
    IconeClicado(imgLinksUteis, false)
  else if Self.FrameComp is TfrRamais then
  begin
    IconeClicado(imgRamais, false);
  end
  else if Self.FrameComp is TfrConfiguracoes then
    IconeClicado(imgConfig, false);

  FreeAndNil(FrameComp);
end;

procedure TMainForm.btLembrarClick(Sender: TObject);
begin
  UniMainModule.sql_tb_alertas_.Edit;
  fmLembrete.ShowModal;
end;

procedure TMainForm.btNaoVerNovamenteClick(Sender: TObject);
begin
  MessageDlg('ATENÇÃO! Você está optando por não visualizar mais esta notificação. Deseja prosseguir?', mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      if Res = mrYes then
      begin
      //nao coloquei pra fechar a conexao pq é fechada qnd sai do postit
        UniMainModule.sql_tb_alertas_.Edit;
        UniMainModule.sql_tb_alertas_alerta_nao_visualizar.AsBoolean := True;
        UniMainModule.sql_tb_alertas_.Post;

        UniMainModule.sql_tb_alertas_.Close;
        UniMainModule.sql_tb_alertas_.Params[0].AsInteger := uniMainModule.usuario.Codigo;
        UniMainModule.sql_tb_alertas_.Open;
      end;
    end);
end;

procedure TMainForm.checaChat;
var
  qry: TADQuery;
  Con: TADConnection;
begin
  try
    Con := TADConnection.Create(nil);
    Con.Params.Add('Database=humanitarian ');
    Con.Params.Add('User_Name=htn ');
    Con.Params.Add('Password=aztrec ');
    Con.Params.Add('Server=10.99.100.5 ');
    Con.Params.Add('CharacterSet=SQL_ASCII ');
    Con.Params.Add('ApplicationName=AppIntranet ');
    Con.Params.Add('DriverID=PG ');

    qry := TADQuery.Create(self);
    qry.Connection := Con;
    qry.SQL.Add('Select Visualizado from tb_chat_msg where para=:id and COALESCE(visualizado,'''')<>''S''  ');
    qry.ParamByName('id').AsInteger := UserLogado;
    qry.Open;
    VerificaChat.Lock;
    chatRegistros := qry.RecordCount;
  finally
    qry.Free;
    Con.free;
    VerificaChat.Release;
  end;
end;

procedure TMainForm.UniBitBtn1Click(Sender: TObject);
begin
  FrmCalendarioVisitas.Show(
    procedure(Sender: TComponent; Res: Integer)
    begin
      if Sender <> nil then
      begin
        UniMainModule.FechaConexao;
        VerificaChat.Enabled := true;
      end;
    end);
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  //intervalo de sincronizacao das notificacoes
  UniTimer1.Interval := UniMainModule.intervalo_sync_notificacoes;
//  imgPrevisao.Visible := UniMainModule.usuario.Filial in [98, 99];
  UserLogado := UniMainModule.usuario.Codigo;
end;

procedure TMainForm.UniFormScreenResize(Sender: TObject; AWidth, AHeight: Integer);
begin
  //alinha a notificacao de acordo com o tamanho da tela
  pnPostIt.Top := pnTopo.Height;
  pnPostIt.Left := imgConfig.Left - pnPostIt.Width;
end;

procedure TMainForm.UniFormShow(Sender: TObject);
begin
//  lbMsg.Caption := 'Bem-vindo(a), ' + TrataNome(UniMainModule.Usuario.Nome);
  clicado := 0;

  if UniMainModule.xml_arquivos_.Active = true then
  begin
    if UniMainModule.xml_arquivos_.Locate('tipo', 'P', []) then
    begin
      if FileExists(UniMainModule.path_imagens + UniMainModule.xml_arquivos_arquivo.AsString) then
        imgBanner.Picture.LoadFromFile(UniMainModule.path_imagens + UniMainModule.xml_arquivos_arquivo.AsString)
    end;
  end;

  try
    UniMainModule.CarregaMenu(tvMenu);
  except
    on e: Exception do
      ShowMessage(e.Message);
  end;

  AbreImagem(True);
  ChecaNotificacoes;

//  se a notificacao tiver linkk, ativa o label
  if Trim(UniMainModule.sql_tb_alertas_alerta_link.AsString) <> '' then
    lbLinkNotificacao.Visible := true
  else
    lbLinkNotificacao.Visible := false;

  if (UniMainModule.usuario.Dep_id = 90) or (UniMainModule.usuario.Dep_id = 53) then
    imgCalendario.Visible := False;

  //alinha a notificacao de acordo com o tamanho da tela
  pnPostIt.Top := pnTopo.Height;
  pnPostIt.Left := imgConfig.Left - pnPostIt.Width;
end;

procedure TMainForm.UniImage2Click(Sender: TObject);
begin
  UniMainModule.sql_tb_alertas_.Prior;

  if UniMainModule.sql_tb_alertas_alerta_visualizacao.AsString = '' then
  begin
    MarcaLida; //se nao tiver visualizada, marca
  end;

  ChecaNotificacoes; //atualiza o contador
  //se a notificacao tiver linkk, ativa o label
  if Trim(UniMainModule.sql_tb_alertas_alerta_link.AsString) <> '' then
    lbLinkNotificacao.Visible := true
  else
    lbLinkNotificacao.Visible := false;
end;

procedure TMainForm.UniImage3Click(Sender: TObject);
begin
  //se ainda tiver alguma notificacao, loca a proxima
  if mtbNotificacoes.RecordCount > 0 then
  begin
    UniMainModule.sql_notificacoes_.Next;
    UniMainModule.sql_tb_alertas_.Locate('alerta_id', UniMainModule.sql_notificacoes_.FieldByName('alerta_id').AsInteger, []);
    MarcaLida; //se nao tiver visualizada, marca
  end
  else
    UniMainModule.sql_tb_alertas_.Next;

  ChecaNotificacoes; //atualiza o contador
  //se a notificacao tiver linkk, ativa o label
  if Trim(UniMainModule.sql_tb_alertas_alerta_link.AsString) <> '' then
    lbLinkNotificacao.Visible := true
  else
    lbLinkNotificacao.Visible := false;
end;

procedure TMainForm.UniImage4Click(Sender: TObject);
begin
  pnPostIt.Visible := false;
  ChecaNotificacoes;
  IconeClicado(imgNotificacoes, false);
end;

procedure TMainForm.VerificaChatTimer(Sender: TObject);
begin
  VerificaChat.Enabled := False;
  if imgChat.Visible then
  begin
    checaChat;
    VerificaChat.Enabled := True;
  end
  else
    VerificaChat.Enabled := False;
end;

procedure TMainForm.UniTimer1Timer(Sender: TObject);
begin
  //timeout infinito
  UniMainModule.AbreConexao;
  ChecaNotificacoes;
end;

procedure TMainForm.NotificaChat_Alerta(Sender: TObject);
begin
  VerificaChat.Enabled := False;
  lblChatNotf.Visible := chatRegistros > 0;
  lblChatNotf.Caption := IntToStr(chatRegistros);
  if lblChatNotf.Visible then
  begin
    geraAlertaJS;
  end;
  VerificaChat.Enabled := True;

  if (pnPostIt.Visible = False) and (pnFrame.Visible = false) then
     // UniMainModule.FechaConexao;

end;

initialization
  RegisterAppFormClass(TMainForm);

end.

