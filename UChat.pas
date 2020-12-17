﻿unit UChat;
{ ** Desenvolvido por Daniel Fernandes - inicio projeto: 20/12/2019 **  }
{ ** para compilar: é nescessario adequar as units externas e criar as tabelas no banco de dados **  }
{ ** exclusivo para unigui **  }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIFrame,
  uniGUIBaseClasses, uniPanel, uniImage, Vcl.Imaging.pngimage, uniLabel,
  uniMultiItem, uniComboBox, uniEdit, uniMemo, uniButton, uniBitBtn, uADStanIntf,
  uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf,
  uADDAptIntf, uADStanAsync, uADDAptManager, Data.DB, uADCompDataSet,
  uADCompClient, uniTreeView, uniListBox, uniScrollBox, uniHTMLMemo, uniTimer,
  uniGUIForm, uniDBMemo, uniBasicGrid, uniDBGrid, Vcl.Menus, uniMainMenu,
  uniHTMLFrame, uniTabControl, uniPageControl, Vcl.AppEvnts;

type
  TfrmChat = class(TUniForm)
    pnlUsersAtivos: TUniPanel;
    pnlHeader: TUniPanel;
    pnlUserLogado: TUniPanel;
    imgUserOwner: TUniImage;
    lbUserOwner: TUniLabel;
    CbStatus: TUniComboBox;
    lbStatus: TUniLabel;
    pnlSendMsg: TUniPanel;
    lbSend: TUniLabel;
    btnSend: TUniBitBtn;
    sql_chat_cliente: TADQuery;
    lbDep: TUniLabel;
    SBUserAtivos: TUniScrollBox;
    sql_msg: TADQuery;
    MemoMSG: TUniHTMLMemo;
    VerificaMsg: TUniTimer;
    pnl_Conv: TUniPanel;
    VerificaNovasMsg_ladocliente: TUniTimer;
    pnlEmoj: TUniPanel;
    pnlContEmoj: TUniPanel;
    lbSmyle: TUniLabel;
    lbkkk: TUniLabel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    UniLabel7: TUniLabel;
    UniLabel8: TUniLabel;
    UniLabel9: TUniLabel;
    UniLabel10: TUniLabel;
    UniLabel11: TUniLabel;
    UniLabel12: TUniLabel;
    UniLabel13: TUniLabel;
    UniLabel14: TUniLabel;
    UniLabel15: TUniLabel;
    UniLabel16: TUniLabel;
    UniLabel17: TUniLabel;
    UniLabel18: TUniLabel;
    UniLabel19: TUniLabel;
    UniLabel20: TUniLabel;
    UniLabel21: TUniLabel;
    lbP_dr: TUniLabel;
    edtMsg: TUniHTMLMemo;
    pg_control: TUniPageControl;
    tab_contatos: TUniTabSheet;
    tab_Grupos: TUniTabSheet;
    SBGrupos: TUniScrollBox;
    sql_MeusGrupos: TADQuery;
    sql_MeusGruposNome: TStringField;
    sql_MeusGruposid_grupo: TIntegerField;
    sql_MeusGruposid_participante: TIntegerField;
    sql_MsgGrupo: TADQuery;
    sql_MsgGruponome: TStringField;
    sql_MsgGrupoid_msg_enviada: TIntegerField;
    sql_postGrupMsg: TADQuery;
    sql_MsgGrupomsg: TBlobField;
    sql_MsgGrupoid: TIntegerField;
    ApplicationEvents1: TApplicationEvents;
    sql_postGrupMsgid_grupo: TIntegerField;
    sql_postGrupMsgmsg: TBlobField;
    sql_postGrupMsgid_msg_enviada: TIntegerField;
    sql_postGrupMsgid: TIntegerField;
    procedure CbStatusChange(Sender: TObject);
    procedure pnlOnMouseEnter(Sender: TObject);
    procedure pnlOnMouseLeave(Sender: TObject);
    procedure pnlDbClick(Sender: TObject);
    procedure pnlDbClick_grupo(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure VerificaMsgTimer(Sender: TObject);
    procedure edtMsgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UniFormShow(Sender: TObject);
    procedure VerificaNovasMsg_ladoclienteTimer(Sender: TObject);
    procedure pnlEmojClick(Sender: TObject);
    procedure lbSmyleClick(Sender: TObject);
    procedure lbkkkClick(Sender: TObject);
    procedure UniLabel3Click(Sender: TObject);
    procedure UniLabel4Click(Sender: TObject);
    procedure UniLabel5Click(Sender: TObject);
    procedure UniLabel6Click(Sender: TObject);
    procedure UniLabel7Click(Sender: TObject);
    procedure UniLabel8Click(Sender: TObject);
    procedure UniLabel10Click(Sender: TObject);
    procedure UniLabel12Click(Sender: TObject);
    procedure UniLabel9Click(Sender: TObject);
    procedure UniLabel11Click(Sender: TObject);
    procedure UniLabel13Click(Sender: TObject);
    procedure UniLabel14Click(Sender: TObject);
    procedure UniLabel15Click(Sender: TObject);
    procedure UniLabel16Click(Sender: TObject);
    procedure UniLabel17Click(Sender: TObject);
    procedure UniLabel18Click(Sender: TObject);
    procedure UniLabel19Click(Sender: TObject);
    procedure UniLabel20Click(Sender: TObject);
    procedure UniLabel21Click(Sender: TObject);
    procedure lbP_drClick(Sender: TObject);
    procedure tab_GruposBeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
  private
    qry_msg: TADQuery;
    pnl: TUniPanel;
    lbUser, lblDep, lbSt, lbCorStatus, lbNaoLidas: TUniLabel;
    FUsuarioOwner: Integer;
    FGidOwner: string;
    FUser: string;
    FGIDUser: string;
    FIDuser: Integer;
    FDep: string;
    Fpara: string;
    hash: string;
    FAlteraVisualizado: Boolean;
    alteraSQL: Boolean;
    FPodeAcessar: Boolean;
    FPanelName: string;
    FMoveScrolMemo: Boolean;
    FGrupo_id:integer;
    FGrupoNome:String;
    function AlterarStatus: TColor;
    procedure CarregaUsuarios;
    procedure criaGrupos;
    procedure MontaUsuarios(id: integer);
    procedure controlEnable(value: Boolean);
    procedure CarregaMsgS(sender: TObject);
    procedure SetAlteraVisualizado(const Value: Boolean);
    procedure SetPodeAcessar(const Value: Boolean);
    function naoLidas: string;
    procedure lastPositionScrollMemo;
    procedure verificaNovasMsg;
    procedure MarcaComoLida;
    procedure BuscaUsuarioschat(prm: string);
    procedure sendEmotion(aEmo: string);
    procedure CbStatusOnMouseEnter(Sender: TObject);
    procedure CbStatusOnMouseLeave(Sender: TObject);
    function validaUsuarioAtivo(id:integer):boolean;
  public
    property AlteraVisualizado: Boolean read FAlteraVisualizado write SetAlteraVisualizado;
    property PodeAcessar: Boolean read FPodeAcessar write SetPodeAcessar;
    procedure modificaLabel;
  end;

function frmchat: TfrmChat;

implementation

{$R *.dfm}
uses
  uFuncoesUnigui, MainModule, ServerModule;

{ TfrmChat }

function frmchat: TfrmChat;
begin
  Result := TfrmChat(UniMainModule.GetFormInstance(Tfrmchat, True));
end;

function TfrmChat.AlterarStatus: TColor;
begin
  Result := iif(CbStatus.Text = 'On-line', clLime, clRed);
  BuscaUsuarioschat(' = ');
  sql_chat_cliente.Locate('id_usuario', FUsuarioOwner);

  if CbStatus.Text <> sql_chat_cliente.FieldByName('Status').AsString then
  begin
    if not (sql_chat_cliente.State in [dsEdit]) then
    begin
      sql_chat_cliente.Edit;
      sql_chat_cliente.FieldByName('Status').AsString := CbStatus.Text;
      sql_chat_cliente.Post;
    end;
  end;
  BuscaUsuarioschat(' <> ');
end;

procedure TfrmChat.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//
end;

procedure TfrmChat.btnSendClick(Sender: TObject);
const seq ='tb_chat_grupo_msg_id_seq';
begin
  try

    if pg_control.TabIndex = tab_contatos.TabIndex then
    begin

      with TADQuery.Create(self) do
      begin
        Connection := UniMainModule.humanitarian_;
        SQL.Add('Select de, para, gid_msg, msg,data, visualizado,hora from tb_chat_msg where data>=:data');
        ParamByName('data').AsDate := Now; // Limita o select para performace;
        Open;
        Append;
        FieldByName('de').AsInteger := FUsuarioOwner;
        FieldByName('para').AsInteger := StrToInt(Fpara);
        FieldByName('gid_msg').AsString := hash;
        FieldByName('msg').AsString := edtMsg.Text;
        FieldByName('data').AsDateTime := Now;
        FieldByName('Visualizado').AsString := 'N';
        FieldByName('hora').AsDateTime := Now;
        if edtMsg.Text = '' then
        begin
          MessageDlg('Escreva a menssagem antes de enviar!', mtWarning, [mbOK]);
          Cancel;
           exit;
        end
        else
        begin
          Post;
          edtMsg.Text := '';
          CarregaMsgS(self);
          try
            SQL.Clear;
            sql.Add('update tb_chat_client set msg_lida = :lida where id_usuario = :id ');
            ParamByName('id').AsInteger := StrToInt(Fpara);
            ParamByName('lida').AsString := 'N';
            ExecSQL;
          finally
            Free;
          end;
        end;
      end;
     lastPositionScrollMemo;
     edtMsg.Text := '';
    end
    else
    begin

      if edtMsg.Text = '' then
      begin
        MessageDlg('Escreva a menssagem antes de enviar!', mtWarning, [mbOK]);
        exit;
      end;
      sql_postGrupMsg.Close;
      sql_postGrupMsg.Open;
      sql_postGrupMsg.Append;

      sql_postGrupMsgid_grupo.AsInteger := FGrupo_id;
      sql_postGrupMsgmsg.AsString := edtMsg.Text;
      sql_postGrupMsgid_msg_enviada.AsInteger := FUsuarioOwner;
      sql_postGrupMsgid.AsInteger := GeraCodigo(UniMainModule.sql_livre_,seq);
      sql_postGrupMsg.Post;
      CarregaMsgS(self);
      lastPositionScrollMemo;
      edtMsg.Text := '';
    end;
  except
      on E: Exception do
      ShowMessage( e.Message);
  end;
end;

procedure TfrmChat.CarregaMsgS(sender: TObject);
var
  nMsg: Integer;
begin
  if pg_control.TabIndex = tab_contatos.TabIndex then
  begin

    nMsg := sql_msg.RecordCount;
    if sql_msg.Active then
      sql_msg.Close;
   try
    //decodifica a hash, garente o registro unico
    sql_msg.ParamByName('gidDe').AsString := Copy(FGidOwner, 0, 19) + Copy(FGIDUser, 0, 19);
    sql_msg.ParamByName('gidPara').AsString := Copy(FGIDUser, 0, 19) + Copy(FGidOwner, 0, 19);
    sql_msg.ParamByName('data').AsDate := (now - 7);
    sql_msg.Open;
    MemoMsg.Lines.Clear;
    sql_msg.First;

    while sql_msg.Eof = false do
    begin
      MemoMSG.Lines.Add(iif(sql_msg.FieldByName('de').AsInteger <> FUsuarioOwner, '<div style=" text-align: left;  margin: auto;  width: 85%; background-color:#c4ffe2";  > <FONT size=1 COLOR=#349465 > <b> De: ' + sql_msg.FieldByName('denome').AsString + ' - ' + ' Para: ' + sql_msg.FieldByName('paraNome').AsString + ' - ' + sql_msg.FieldByName('data').AsString + ' - ' + sql_msg.FieldByName('hora').AsString + '</b></br></br>' + ' </FONT> </br></br>' + '<FONT size=2 COLOR="#5c6363" >' + sql_msg.FieldByName('msg').AsString
        + '</br></br> </font> </div>', '<div style=" text-align: right;  margin: auto;  width: 90%; background-color:#c4ffff";  > <FONT size=1 COLOR=#0082b5 ><b> De: ' + sql_msg.FieldByName('denome').AsString + ' - ' + ' Para: ' + sql_msg.FieldByName('paraNome').AsString + ' - ' + sql_msg.FieldByName('data').AsString + ' - ' + sql_msg.FieldByName('hora').AsString + '</b></br></br></FONT>' + '<FONT size=2 COLOR="#5c6363" >' + sql_msg.FieldByName('msg').AsString + ' </br></br> </font> </div>'));

      MemoMsg.Lines.Add('</br>');
      MemoMSG.Lines.LineBreak;
      MarcaComoLida;
      sql_msg.Next;
    end;
    MontaUsuarios(StrToIntDef(Fpara, 0));
    pnl_Conv.Caption := 'Conversando com: ' + FUser;
    FMoveScrolMemo := nMsg < sql_msg.RecordCount;
   except
      // erro de parametro ao carregar a tabela de chat por ter registro vazio na primeira vez que o usuario loga, apos isso não ocorre mais erros
      UniSession.AddJS('alert("Procedimento para o primeiro login:  Saia do chat e entre novamente para carregar as mensagem")');
   end;
  end
  else
  begin
    sql_MsgGrupo.Close;
    sql_MsgGrupo.ParamByName('ID_GRUPO').AsInteger := FGrupo_id;
    sql_MsgGrupo.Open;
    MemoMsg.Lines.Clear;
    sql_MsgGrupo.First;

    pnl_Conv.Caption := 'Conversando com grupo: '+ FGrupoNome;

    while sql_MsgGrupo.Eof = false do
    begin
      MemoMSG.Lines.Add(
        '<div style=" text-align: left;  margin: auto;  width: 85%; background-color:#c4ffe2";  > <FONT size=1 COLOR=#349465 > <b> De: ' + sql_MsgGruponome.AsString + ' - ' + ' Para: ' + FGrupoNome +
             '</b></br></br>' + ' </FONT> </br></br>' + '<FONT size=2 COLOR="#5c6363" >' +  sql_MsgGrupomsg.AsString
        + '</br></br> </font> </div>');

      MemoMsg.Lines.Add('</br>');
      MemoMSG.Lines.LineBreak;
      sql_MsgGrupo.Next;
    end;
     FMoveScrolMemo := nMsg < sql_msg.RecordCount;

  end;
end;

procedure TfrmChat.CarregaUsuarios;
var
  i, tp: Integer;
  oldPara: string;
begin
 try
  //Altera o select para não carregar o Usuario Owner na tela
  if alteraSQL then // para não ficar carregando a todo momento
  begin
    BuscaUsuarioschat(' <> ');
    alteraSQL := False;
  end;

  if sql_chat_cliente.Active = false then
    sql_chat_cliente.open;

  sql_chat_cliente.First;
  i := 0;
  tp := 0;
  oldPara := Fpara;
  Fpara := '0';
  while sql_chat_cliente.Eof = false do
  begin
    if sql_chat_cliente.FieldByName('desativado').AsBoolean = false then
    begin
      MontaUsuarios(sql_chat_cliente.FieldByName('id_usuario').AsInteger);

     if  validaUsuarioAtivo(sql_chat_cliente.FieldByName('id_usuario').AsInteger) then
     begin

      //Cria os panels para cada usuario
        pnl := TUniPanel.Create(self);
        pnl.Parent := SBUserAtivos;
        pnl.Cursor := crHandPoint;
        pnl.Color := $00615856;
        pnl.Width := 215;
        pnl.Height := 57;
        pnl.Align := alTop;
        pnl.Top := tp;
        pnl.Visible := True;
        pnl.ShowCaption := False;
        Pnl.ShowHint := False;
        pnl.Caption := sql_chat_cliente.FieldByName('gid_msg').AsString;
        pnl.Hint := sql_chat_cliente.FieldByName('id_usuario').AsString;
        pnl.Name := 'pnl_' + IntToStr(i);
        pnl.Tag := 999;
        pnl.OnClick := pnlDbClick;
        pnl.OnMouseEnter := pnlOnMouseEnter;
        pnl.OnMouseLeave := pnlOnMouseLeave;

      //Label carrega o nome dos usuarios;
        lbUser := TUniLabel.Create(self);
        lbUser.Parent := pnl;
        lbUser.Cursor := crHandPoint;
        lbUser.Top := 1;
        lbUser.Left := 1;
        lbUser.Caption := FUser;
        lbUser.Name := 'lbUser' + IntToStr(i);

      //Label do departamento usuario
        lblDep := TUniLabel.Create(self);
        lblDep.Parent := pnl;
        lblDep.Cursor := crHandPoint;
        lblDep.Top := 14;
        lblDep.Left := 4;
        lblDep.Caption := FDep;
        lblDep.Name := 'lbDep' + IntToStr(i);


      //Label do Status
        lbSt := TUniLabel.Create(self);
        lbSt.Parent := pnl;
        lbSt.Cursor := crHandPoint;
        lbSt.Top := 26;
        lbSt.Left := 4;
        lbSt.Caption := sql_chat_cliente.FieldByName('status').AsString;

      //Cor do Status online verde ofline vermelho
        lbCorStatus := TUniLabel.Create(self);
        lbCorStatus.Parent := pnl;
        lbCorStatus.Cursor := crHandPoint;
        lbCorStatus.Top := 22;
        lbCorStatus.Left := (47);
        lbCorStatus.Font.Size := 13;
        lbCorStatus.Caption := '°';
        lbCorStatus.Font.Color := iif((sql_chat_cliente.FieldByName('status').AsString = 'On-line'), clLime, clRed);
        lbCorStatus.Name := 'lbCor' + IntToStr(i);

      //Controle de visualização
        lbNaoLidas := TUniLabel.Create(self);
        lbNaoLidas.Parent := pnl;
        lbNaoLidas.Font.Size := 8;
        lbNaoLidas.Top := 29;
        lbNaoLidas.Left := 160;
        lbNaoLidas.Caption := iif(naoLidas = '', '✓✓', naoLidas);
        lbNaoLidas.Name := 'lbNl' + IntToStr(i);
        lbNaoLidas.ShowHint := False;
        lbNaoLidas.Hint := pnl.Hint;

        if lbNaoLidas.Caption <> '✓✓' then
        begin
          pnl.Top := i;
          pnl.Color := $00C47D28;
          lbNaoLidas.Font.Color := clWhite;
        end
        else
        begin
         lbNaoLidas.Font.Color := clLime;
         lbNaoLidas.Font.Style := [fsBold];
        end;

        tp := tp + 60;
        inc(i);
     end;
   end;
    sql_chat_cliente.Next;
    Application.ProcessMessages;
  end;
  Fpara := oldPara;
  VerificaMsg.Enabled := True;
 except

 end;
end;

procedure TfrmChat.CbStatusChange(Sender: TObject);
begin
  lbStatus.Font.Color := AlterarStatus;
end;

procedure TfrmChat.CbStatusOnMouseEnter(Sender: TObject);
begin

end;

procedure TfrmChat.CbStatusOnMouseLeave(Sender: TObject);
begin
  //
end;

procedure TfrmChat.controlEnable(value: Boolean);
begin
  btnSend.Enabled := value;
  edtMsg.Enabled := value;
  pnlEmoj.Enabled := value;
end;

procedure TfrmChat.criaGrupos;
begin
  sql_MeusGrupos.Close;
  sql_MeusGrupos.ParamByName('user').AsInteger := FUsuarioOwner;
  sql_MeusGrupos.Open;

  sql_MeusGrupos.First;
  //Cria os panels para cada usuario
  while not sql_MeusGrupos.Eof do
  begin

    pnl := TUniPanel.Create(self);
    pnl.Parent := SBGrupos;
    pnl.Cursor := crHandPoint;
    pnl.Color := $0044393D;
    pnl.Font.Color := clWhite;
    pnl.Width := 215;
    pnl.Height := 57;
    pnl.Align := alTop;
    pnl.Visible := True;
    pnl.ShowCaption := True;
    Pnl.ShowHint := False;
    pnl.Caption := sql_MeusGruposNome.AsString;
    pnl.Hint := sql_MeusGruposid_grupo.AsString;
    pnl.Name := 'pnl' + copy( sql_MeusGruposNome.AsString,0,3)+'_'+sql_MeusGruposid_grupo.AsString;
    pnl.Tag := 999;
    pnl.OnClick := pnlDbClick_grupo;
    pnl.OnMouseEnter := pnlOnMouseEnter;
    pnl.OnMouseLeave := pnlOnMouseLeave;
    sql_MeusGrupos.Next;
  end;
end;

procedure TfrmChat.edtMsgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    btnSend.Click;
  end;
end;

procedure TfrmChat.lastPositionScrollMemo;
var
  HTMLMemoJSName: string;
begin

  HTMLMemoJSName := MemoMSG.JSName;
  UniSession.AddJS('setTimeout(function(){' + HTMLMemoJSName + '.iframeEl.dom.contentWindow.scrollTo(0, ' + HTMLMemoJSName + '.iframeEl.dom.contentWindow.document.body.scrollHeight)}, 50)');
end;

procedure TfrmChat.lbkkkClick(Sender: TObject);
begin
  sendEmotion('128514');
end;

procedure TfrmChat.lbP_drClick(Sender: TObject);
begin
  sendEmotion('129326');
end;

procedure TfrmChat.lbSmyleClick(Sender: TObject);
begin
  sendEmotion('128512');
end;

procedure TfrmChat.modificaLabel;
var
  i: Integer;
begin
   //modifica label visialização da conversa
  for i := 0 to ComponentCount - 1 do // navega por todos os componentes
  begin
    if (Components[i] is TuniLabel) and (TuniLabel(Components[i]).Name = 'lbNl' + FPanelName) then
      TuniLabel(Components[i]).Caption := iif(naoLidas = '', '✓✓', naoLidas);  //muda o label em tempo de execução para lido ou não lido
  end;
end;

procedure TfrmChat.BuscaUsuarioschat(prm: string);
begin
  sql_chat_cliente.Close;
  sql_chat_cliente.SQL.Clear;
  sql_chat_cliente.SQL.Add('  Select  cl.id_usuario , cl.gid_msg , cl.departamento, cl.status, max(msg.hora) as hora, max(msg.data) as data, min(msg.visualizado) as lido, cl.desativado ' +

   ' from tb_chat_client cl left join tb_chat_msg msg on ( msg.de = id_usuario)' +
    '  where   msg.de ' + prm + '  :user group by  cl.gid_msg , cl.id_usuario ,   cl.departamento, cl.status  ' +
     '  order by   lido, data DESC, hora desc,departamento ');
  sql_chat_cliente.ParamByName('user').AsInteger := FUsuarioOwner;
  sql_chat_cliente.Open;
end;

procedure TfrmChat.MarcaComoLida;
begin
  if (frmChat.sql_msg.FieldByName('visualizado').AsString <> 'S') and (AlteraVisualizado) then
  begin
    sql_msg.Edit;
    sql_msg.FieldByName('visualizado').AsString := 'S';
    sql_msg.Post;
    modificaLabel;
  end;
end;

procedure TfrmChat.MontaUsuarios(id: integer);
var
  qry: TADQuery;
begin
  qry := TADQuery.Create(self);
  try
    qry.Connection := UniMainModule.humanitarian_;
    qry.SQL.Text := 'Select id, n.nome,dp.dep_nome from tb_user n join departamento dp on ( dp.dep_cod=n.dep_Cod ) where id = :id ';
    qry.ParamByName('id').AsInteger := id;
    qry.Open;
  finally
    FIDuser := qry.FieldByName('id').AsInteger;
    FUser :=  copy( qry.FieldByName('Nome').AsString,0,25);
    FDep := qry.FieldByName('dep_nome').AsString;
    qry.Free;
  end;
end;

function TfrmChat.naoLidas: string;
var
  qry: TADQuery;
begin
  try
    qry := TADQuery.Create(self);
    qry.Connection := UniMainModule.humanitarian_;
    qry.SQL.Add('Select Visualizado from tb_chat_msg where de=:para and para=:de and COALESCE(visualizado,'''')<>''S''  ');
    qry.ParamByName('para').AsString := iif(Fpara = '0', pnl.Hint, Fpara);
    qry.ParamByName('de').AsString := IntToStr(FUsuarioOwner);
    qry.Open;
    result := iif(qry.RecordCount >= 1, IntToStr(qry.RecordCount), '');
  finally
    qry.Free;
  end;
end;

procedure TfrmChat.pnlDbClick(Sender: TObject);
var
  i: Integer;
  v1, v2: string;
begin
  try
   //Cria a sessão
    FGIDUser := (Sender as TUniPanel).Caption; //Guardei a GID do cliente no caption
    Fpara := (Sender as TUniPanel).Hint; //Guardei o id do cliente no hint
   //Monta a hash da sessão
    v1 := Copy(FGidOwner, 0, 19);
    v2 := Copy(FGIDUser, 0, 19);
    hash := v1 + v2;

    FPanelName := (Sender as TUniPanel).Name; // guarda o nome do panel que foi clicado
    FPanelName := Copy(FPanelName, 5, 2);       //pega a parte numerica do panel, para modificar o label referente a ele no evento ModificaLabel

    MemoMsg.Lines.Clear;
    controlEnable(true);
    FAlteraVisualizado := True;
    CarregaMsgs(self);
    (Sender as TUniPanel).Color := $00615856;
    lastPositionScrollMemo;
    FAlteraVisualizado := False;
  except

  end;

end;

procedure TfrmChat.pnlDbClick_grupo(Sender: TObject);
begin
  controlEnable(true);
  FGrupo_id := StrToInt((Sender as TUniPanel).Hint); // id do grupo no hint
  FGrupoNome := (Sender as TUniPanel).Caption;
  CarregaMsgs(self);
  lastPositionScrollMemo;
end;

procedure TfrmChat.pnlEmojClick(Sender: TObject);
begin
  if pnlContEmoj.Visible then
    pnlContEmoj.Visible := False
  else
    pnlContEmoj.Visible := True;

end;

procedure TfrmChat.pnlOnMouseEnter(Sender: TObject);
begin
 VerificaNovasMsg_ladocliente.Enabled := False;
end;

procedure TfrmChat.pnlOnMouseLeave(Sender: TObject);
begin
  VerificaNovasMsg_ladocliente.Enabled := True;
end;

procedure TfrmChat.sendEmotion(aEmo: string);
begin
  // link onde está os emoj https://www.w3schools.com/charsets/ref_emoji_smileys.asp
  // usar apenas os numeros da coluna Dec
  // copiar as carinhas e colar no label, no onclick passar o evendo sendEmotion('123456') com a numeração
  edtMsg.Text := edtMsg.Text + '&#' + aEmo + ';'; //caracters decodifica para enviar os emoj
end;

procedure TfrmChat.SetAlteraVisualizado(const Value: Boolean);
begin
  FAlteraVisualizado := Value;
end;

procedure TfrmChat.SetPodeAcessar(const Value: Boolean);
begin
  FPodeAcessar := Value;
end;

procedure TfrmChat.tab_GruposBeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
   if sql_MeusGrupos.RecordCount = 0 then
     ShowMessage('Não há grupo vinculado ao seu departamento!');
end;

procedure TfrmChat.UniFormShow(Sender: TObject);
var
  gid: TGUID;
begin
  if PodeAcessar then
  begin
    lbUserOwner.Caption := Copy(UniMainModule.Usuario.Nome,0,20);
    FUsuarioOwner := UniMainModule.Usuario.Codigo;
    lbDep.Caption := UniMainModule.Usuario.Dep_nome;
    with sql_chat_cliente do
    begin
      Connection := UniMainModule.humanitarian_;
      SQL.Add('Select id_usuario, gid_msg, departamento, msg_lida, status from tb_chat_client' + ' where id_usuario =:user order by msg_lida  ');
      ParamByName('user').AsInteger := FUsuarioOwner;
      Open;

      if RecordCount <= 0 then
      begin
       //Cadastro automatico
        CreateGuid(gid);
        Append;
        FieldByName('id_usuario').AsInteger := FUsuarioOwner;
        FieldByName('gid_msg').AsString := GUIDToString(gid);  //Garante o registro unico
        FieldByName('departamento').AsString := UniMainModule.Usuario.Dep_nome;
        FieldByName('status').AsString := CbStatus.Text;
        Post;
        //precisa gerar um registro na tabela de msg por causa de um join
        sql_msg.ParamByName('gidDe').AsInteger := 0;
        sql_msg.ParamByName('gidPara').AsInteger := 0;
        sql_msg.ParamByName('data').AsDate := Now;
        sql_msg.Open();
        sql_msg.Append;
        sql_msg.FieldByName('de').AsInteger := FUsuarioOwner;
        sql_msg.FieldByName('para').AsInteger := 0;
        sql_msg.FieldByName('msg').AsString := 'Voce se juntou ao time do chat Humanitarian, bem vindo!';
        sql_msg.FieldByName('gid_msg').AsString := '0';
        sql_msg.Post;
        sql_msg.Close;

      end;
      FGidOwner := FieldByName('gid_msg').AsString;

      //Carrega grupos do usuario logado
      criaGrupos;

      CbStatus.Text := iif((sql_chat_cliente.FieldByName('status').asString = 'On-line'), 'On-line', 'Of-line');
      CbStatusChange(nil);
      alteraSQL := True;
      CarregaUsuarios;
    end;
  end;
end;

procedure TfrmChat.UniLabel10Click(Sender: TObject);
begin
  sendEmotion('128536');
end;

procedure TfrmChat.UniLabel11Click(Sender: TObject);
begin
  sendEmotion('128531');
end;

procedure TfrmChat.UniLabel12Click(Sender: TObject);
begin
  sendEmotion('128528');
end;

procedure TfrmChat.UniLabel13Click(Sender: TObject);
begin
  sendEmotion('128532');
end;

procedure TfrmChat.UniLabel14Click(Sender: TObject);
begin
  sendEmotion('128540');
end;

procedure TfrmChat.UniLabel15Click(Sender: TObject);
begin
  sendEmotion('128548');
end;

procedure TfrmChat.UniLabel16Click(Sender: TObject);
begin
  sendEmotion('128552');
end;

procedure TfrmChat.UniLabel17Click(Sender: TObject);
begin
  sendEmotion('128556');
end;

procedure TfrmChat.UniLabel18Click(Sender: TObject);
begin
  sendEmotion('128557');
end;

procedure TfrmChat.UniLabel19Click(Sender: TObject);
begin
  sendEmotion('128561');
end;

procedure TfrmChat.UniLabel20Click(Sender: TObject);
begin
  sendEmotion('128564');
end;

procedure TfrmChat.UniLabel21Click(Sender: TObject);
begin
  sendEmotion('129299');
end;

procedure TfrmChat.UniLabel3Click(Sender: TObject);
begin
  sendEmotion('128517');
end;

procedure TfrmChat.UniLabel4Click(Sender: TObject);
begin
  sendEmotion('128521');
end;

procedure TfrmChat.UniLabel5Click(Sender: TObject);
begin
  sendEmotion('128523');
end;

procedure TfrmChat.UniLabel6Click(Sender: TObject);
begin
  sendEmotion('128557');
end;

procedure TfrmChat.UniLabel7Click(Sender: TObject);
begin
  sendEmotion('128525');
end;

procedure TfrmChat.UniLabel8Click(Sender: TObject);
begin
  sendEmotion('128527');
end;

procedure TfrmChat.UniLabel9Click(Sender: TObject);
begin
  sendEmotion('128530');
end;

function TfrmChat.validaUsuarioAtivo(id: integer): boolean;
begin
  UniMainModule.sql_livre_.Close;
  UniMainModule.sql_livre_.SQL.Clear;
  UniMainModule.sql_livre_.SQL.Add('select u.ativo from tb_user u where u.id = :id ');
  UniMainModule.sql_livre_.ParamByName('id').AsInteger := id;
  UniMainModule.sql_livre_.Open();

  Result := UniMainModule.sql_livre_.FieldByName('ativo').AsBoolean;

  sql_chat_cliente.Edit;
  sql_chat_cliente.FieldByName('desativado').AsBoolean := not result;
  sql_chat_cliente.Post;
end;

procedure TfrmChat.VerificaMsgTimer(Sender: TObject);
begin
  CarregaMsgS(self);
  if FMoveScrolMemo then
    lastPositionScrollMemo;
end;

procedure TfrmChat.verificaNovasMsg;
var
  i, j: Integer;
begin
  j := 0;
  try

    for i := 0 to ComponentCount - 1 do // navega por todos os componentes
    begin
      if (Components[i] is TUniPanel) and (TUniPanel(Components[i]).Name = 'pnl_' + IntToStr(j)) then
      begin
        TUniPanel(Components[i]).free;
        Inc(j);
        while (TUniPanel(Components[i]).Name = 'pnl_' + IntToStr(j)) do
        begin
          TUniPanel(Components[i]).free;
          Inc(j);
          Application.ProcessMessages;
        end;
      end;
    end;
  except
    CarregaUsuarios;
  end;
end;

procedure TfrmChat.VerificaNovasMsg_ladoclienteTimer(Sender: TObject);
begin
  try
    verificaNovasMsg;
  except

  end;
end;

end.

