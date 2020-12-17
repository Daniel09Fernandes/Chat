unit ufrConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniButton, uniBitBtn, uniMultiItem, uniListBox,
  uniLabel, uniGUIBaseClasses, uniPanel, uniGUIApplication, uFuncoesUnigui;

type
  TfrConfiguracoes = class(TUniFrame)
    pnUsuario: TUniPanel;
    lbUsuario: TUniLabel;
    lbDepartamento: TUniLabel;
    btSair: TUniBitBtn;
    btEditarImagens: TUniBitBtn;
    procedure UniFrameCreate(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btEditarImagensClick(Sender: TObject);
  private
    function  TrataNome(Str: string): string;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uManutencaoImagens, uManutencaoLinks, uManutencaoRamais, MainModule, uClassUsuario;



procedure TfrConfiguracoes.btEditarImagensClick(Sender: TObject);
begin
  fmManutencaoImagens.ShowModal
end;

procedure TfrConfiguracoes.btSairClick(Sender: TObject);
begin
  UniMainModule.FechaConexao;
  UniApplication.Restart;
end;

function TfrConfiguracoes.TrataNome(Str: string): string;
var
  i: integer;
  esp: boolean;
begin
  str := LowerCase(Trim(str));
  for i := 1 to Length(str) do
  begin
    if i = 1 then
      str[i] := UpCase(str[i])
    else
    begin
      if i <> Length(str) then
      begin
        esp := (str[i] = ' ');
        if esp then
          str[i+1] := UpCase(str[i+1]);
      end;
    end;
  end;
  Result := Str;
end;

procedure TfrConfiguracoes.UniFrameCreate(Sender: TObject);
var
  direitos : TDireitos;
begin
  lbUsuario.Caption         :=  TrataNome(uniMainModule.usuario.Nome);
  lbDepartamento.Caption    :=  TrataNome(uniMainModule.usuario.Dep_nome);

  //verifica se o usuario tem acesso a alterar as imagens
  direitos := uFuncoesUnigui.ValidaAcesso(IntToStr(UniMainModule.Usuario.Codigo),'UPLOAD_HUMANEWS', UniMainModule.sql_livre_);
  btEditarImagens.Visible := (direitos <> nil);
end;

end.
