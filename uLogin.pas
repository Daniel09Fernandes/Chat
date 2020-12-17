unit uLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs,
  uniGUIClasses, uniGUIForm, uniImage,
  uniBitBtn, uniEdit, uniLabel, uniPanel,
  uniHTMLFrame, Vcl.Imaging.pngimage, uniButton, uniGUIBaseClasses, uniMemo,
  uniHTMLMemo, uFuncoesUnigui, uniTimer;

type
  TfmLogin = class(TUniLoginForm)
    UniContainerPanel2: TUniContainerPanel;
    UniImage2: TUniImage;
    UniImage3: TUniImage;
    lbLogin: TUniLabel;
    edLogin: TUniEdit;
    lbSenha: TUniLabel;
    edSenha: TUniEdit;
    btLogin: TUniBitBtn;
    frmInicial: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    tmLoginParam: TUniTimer;
    procedure ListarArquivos;
    function FileTimeToDTime(FTime: TFileTime): TDateTime;
    procedure CarregaFrames;
    procedure edLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btLoginClick(Sender: TObject);
    procedure UniLoginFormShow(Sender: TObject);
    procedure UniTimer1Timer(Sender: TObject);
    procedure tmLoginParamTimer(Sender: TObject);

  private
  public
  end;

function fmLogin: TfmLogin;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, ServerModule;

function fmLogin: TfmLogin;
begin
  Result := TfmLogin(UniMainModule.GetFormInstance(TfmLogin));
end;

procedure TfmLogin.edLoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edSenha.SetFocus;
end;

procedure TfmLogin.edSenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btLogin.OnClick(sender);
end;

function TfmLogin.FileTimeToDTime(FTime: TFileTime): TDateTime;
var
  LocalFTime: TFileTime;
  STime: TSystemTime;
begin
  FileTimeToLocalFileTime(FTime, LocalFTime);
  FileTimeToSystemTime(LocalFTime, STime);
  Result := SystemTimeToDateTime(STime);
end;

procedure TfmLogin.ListarArquivos;
var
  b: Integer;
  xImagem: string;
  lArquivos, l : TStringList;
begin
  try
    lArquivos := TStringList.Create;

    l := TStringList.Create;

    UniMainModule.xml_arquivos_.First;

    while not UniMainModule.xml_arquivos_.Eof do
    begin
      if (l.Count < UniMainModule.qtd_carrossel) and (UniMainModule.xml_arquivos_tipo.AsString = 'E') then
      begin
        l.Add(UniMainModule.xml_arquivos_arquivo.AsString);
      end;

      UniMainModule.xml_arquivos_.Next;
    end;

    l.Count;

    for b := 0 to l.Count-1 do
    begin
      xImagem := 'imagens/' + l[b];

      if b = 0 then
      begin
        frmInicial.HTML.Add(' <div class="item active"> ');
        frmInicial.HTML.Add('   <div class="item"> ');
        frmInicial.HTML.Add('			<center><img style="width: 100%; height: 100%;" src="' + xImagem + '"></center>');
        frmInicial.HTML.Add('		</div> ');
        frmInicial.HTML.Add('	</div>   ');
      end
      else
      begin
        frmInicial.HTML.Add('	<div class="item"> ');
        frmInicial.HTML.Add('	  <center><img style="width: 100%; height: 100%;" src="' + xImagem + '"></center> ');
        frmInicial.HTML.Add('	</div> ');
      end;
    end;
  finally
    FreeAndNil(lArquivos);
    FreeAndNil(l);
  end;
end;

procedure TfmLogin.UniLoginFormShow(Sender: TObject);
var
  usu : string;
begin
  try
    UniMainModule.ConfiguracoesIni;
  except
    on e:Exception do
    begin
      UniApplication.Terminate(e.Message);
      Exit;
    end;
  end;

//  tenta carregar as imagens do carrossel
  try
    if UniMainModule.xml_arquivos_.Active = false then
      UniMainModule.xml_arquivos_.CreateDataSet
    else
      UniMainModule.xml_arquivos_.Open;

    UniMainModule.xml_arquivos_.LoadFromFile(UniServerModule.FilesFolderPath + 'imagens.xml');
  except
    on e:Exception do
      ShowMessage('Erro ao carregar imagens');
  end;

  if UniMainModule.xml_arquivos_.Active = true then
    CarregaFrames;

  edLogin.SetFocus;
end;

procedure TfmLogin.UniTimer1Timer(Sender: TObject);
begin
  //timeout infinito
end;

procedure TfmLogin.tmLoginParamTimer(Sender: TObject);
var
  usu       : string;
  ip_acesso : string;
  lIP       : TStringList;
begin
  try
    tmLoginParam.Enabled := False;

    //captura o ip do usuario que esta acessando
    ip_acesso := UniSession.RemoteHost;


    //quebra para pegar o primeiro octeto
    lIP       := TStringList.Create;
    ExtractStrings(['.'],[' '],Pchar(ip_acesso),lIP);

    if (lIP[0] = '10') or (lIP[0] = '127') then
    begin
      usu := UniApplication.Parameters.Values['HTN'];

      if Trim(usu) <> '' then
      begin
        UniMainModule.AbreConexao;
        try
          UniMainModule.usuario := uFuncoesUnigui.ValidaUsuario(usu,'','',UniMainModule.sql_livre_);
        except
          begin
            MessageDlg('Nome de Usuário ou Senha incorretos.',mtError,[mbOk],nil);
            Exit;
          end;
        end;

        if UniMainModule.usuario <> nil then
          ModalResult := mrOk
        else
          ShowMessage('Nome de Usuário ou Senha incorretos.');


        UniMainModule.FechaConexao;
      end;
    end;
  finally
    lIP.Free;
  end;
end;

procedure TfmLogin.btLoginClick(Sender: TObject);
var
  ip_acesso : string;
  lIP       : TStringList;
  dtAcesso  : TDateTime;
begin
  if Trim(edLogin.Text) = '' then
  begin
    MessageDlg('Usuário não informado.',mtError,[mbOk],nil);
    Exit;
  end;

  if Trim(edSenha.Text) = '' then
  begin
    MessageDlg('Senha não informada.',mtError,[mbOk],nil);
    Exit;
  end;

  try
    UniMainModule.AbreConexao;

    try
      UniMainModule.usuario := ValidaUsuario('', edLogin.Text, Crypt('C',edSenha.Text), UniMainModule.sql_livre_);
    except
      begin
        MessageDlg('Nome de Usuário ou Senha incorretos.',mtError,[mbOk],nil);
        Exit;
      end;
    end;

    if UniMainModule.usuario <> nil then
    begin
      //captura o ip do usuario que esta acessando
      ip_acesso := UniSession.RemoteHost;


      //quebra para pegar o primeiro octeto
      lIP       := TStringList.Create;
      ExtractStrings(['.'],[' '],Pchar(ip_acesso),lIP);

      if (lIP[0] = '10') or (lIP[0] = '127') then
      begin
        //se estiver dentro da empresa ou localhost, loga normalmente
        ModalResult := mrOk;
      end
      else
      begin
        dtAcesso := now;

        //verifica se o usuario possui permissao para acessar externamente
        UniMainModule.sql_livre_.Close;
        UniMainModule.sql_livre_.SQL.Clear;
        UniMainModule.sql_livre_.SQL.Text :=
          ' select                                        '+
          '  t.acesso_externo_de,                         '+
          '  t.acesso_externo_ate                         '+
          ' from tb_user t                                '+
          ' where coalesce(t.acesso_externo,false) = true '+
          ' and t.id = :id                                ';
        UniMainModule.sql_livre_.ParamByName('id').AsInteger := UniMainModule.usuario.Codigo;
        UniMainModule.sql_livre_.Open;

        if UniMainModule.sql_livre_.IsEmpty then
        begin
          MessageDlg('Usuário sem permissão para acesso externo',mtError,[mbOK],nil);
          Exit;
        end;

        if ( UniMainModule.sql_livre_.FieldByName('acesso_externo_de').AsDateTime = StrToDate('30/12/1899') ) or
           ( UniMainModule.sql_livre_.FieldByName('acesso_externo_ate').AsDateTime = StrToDate('30/12/1899') )
        then
        begin
          MessageDlg('Usuário sem permissão para acesso externo',mtError,[mbOK],nil);
          Exit;
        end;

        if ( dtAcesso < UniMainModule.sql_livre_.FieldByName('acesso_externo_de').AsDateTime  ) or
           ( dtAcesso > UniMainModule.sql_livre_.FieldByName('acesso_externo_ate').AsDateTime )
        then
        begin
          MessageDlg('Usuário sem permissão para acesso externo',mtError,[mbOK],nil);
          Exit;
        end;

        uFuncoesUnigui.GeraLogDB(UniMainModule.usuario.Codigo,'INTRANET','TB_USER','C','ACESSO EXTERNO IP ' + ip_acesso,UniMainModule.sql_livre_);

        ModalResult := mrOk;
      end;
    end
    else
      ShowMessage('Nome de Usuário ou Senha incorretos.');
  finally
    UniMainModule.FechaConexao;
    lIP.Free;
  end;
end;

procedure TfmLogin.CarregaFrames;
begin
  frmInicial.HTML.Add(' <!DOCTYPE html> ');
  frmInicial.HTML.Add(' <html lang="en"> ');
  frmInicial.HTML.Add(' <head> ');
  frmInicial.HTML.Add('   <title>Bootstrap Example</title> ');
  frmInicial.HTML.Add('   <meta charset="utf-8"> ');
  frmInicial.HTML.Add('   <meta name="viewport" content="width=device-width, initial-scale=1"> ');
  frmInicial.HTML.Add('   <link rel="stylesheet" href="http://intranet.humanitarian.com.br/files/bootstrap.min.css"> ');
  frmInicial.HTML.Add('   <script src="http://intranet.humanitarian.com.br/files/jquery.min.js"></script> ');
  frmInicial.HTML.Add('   <script src="http://intranet.humanitarian.com.br/files/bootstrap.min.js"></script> ');
  frmInicial.HTML.Add(' </head> ');
  frmInicial.HTML.Add(' <body> ');
  frmInicial.HTML.Add(' <div class="container"> ');
  frmInicial.HTML.Add('   <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="200000" data-wrap="false"> ');
  frmInicial.HTML.Add('        <div class="carousel-inner" role="listbox"> ');

  ListarArquivos;

  frmInicial.HTML.Add('                  <!-- controles para ir para proxima foto--> ');
  frmInicial.HTML.Add('                  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev"> ');
  frmInicial.HTML.Add('                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> ');
  frmInicial.HTML.Add('                    <span class="sr-only">Previous</span> ');
  frmInicial.HTML.Add('                  </a> ');
  frmInicial.HTML.Add('                  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next"> ');
  frmInicial.HTML.Add('                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> ');
  frmInicial.HTML.Add('                    <span class="sr-only">Next</span> ');
  frmInicial.HTML.Add('                  </a> ');
  frmInicial.HTML.Add('                </div> ');
  frmInicial.HTML.Add('              </div> ');
  frmInicial.HTML.Add('              </body> ');
  frmInicial.HTML.Add('              </html> ');

end;

initialization
  RegisterAppFormClass(TfmLogin);

end.
