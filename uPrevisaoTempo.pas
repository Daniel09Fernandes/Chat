unit uPrevisaoTempo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  uADStanIntf, uADStanOption, uADStanParam, uADStanError, uADDatSManager,
  uADPhysIntf, uADDAptIntf, Data.DB, uADCompDataSet, uADCompClient;

type
  TfmPrevisao = class(TUniForm)
    UniHTMLFrame1: TUniHTMLFrame;
    mtb_cidades_: TADMemTable;
    mtb_cidades_cidade_cod: TIntegerField;
    mtb_cidades_cidade_nome: TStringField;
    mtb_cidades_cod_cptec: TIntegerField;
    procedure UniFormShow(Sender: TObject);
  private
    procedure CarregaCidades;
    function CodCidadeCptec(AFilial : integer) : integer;
  public
    { Public declarations }
  end;

function fmPrevisao: TfmPrevisao;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, ServerModule;

function fmPrevisao: TfmPrevisao;
begin
  Result := TfmPrevisao(UniMainModule.GetFormInstance(TfmPrevisao));
end;

function TfmPrevisao.CodCidadeCptec(AFilial: integer): integer;
begin
  try
    UniMainModule.sql_livre_.Close;
    UniMainModule.sql_livre_.SQL.Clear;
    UniMainModule.sql_livre_.SQL.Add('select f.cidade_cod from filial f where f.filial_cod = :filial_cod');
    UniMainModule.sql_livre_.ParamByName('filial_cod').AsInteger := AFilial;
    UniMainModule.sql_livre_.Open;
    if UniMainModule.sql_livre_.RecordCount > 0 then
    begin
      if mtb_cidades_.Locate('cidade_cod',UniMainModule.sql_livre_.Fields[0].AsInteger,[]) then
        result := mtb_cidades_cod_cptec.AsInteger
      else
        result := -1;
    end
    else
      result := -1;
  finally
    UniMainModule.sql_livre_.Close;
  end;
end;

procedure TfmPrevisao.UniFormShow(Sender: TObject);
begin
  CarregaCidades;

  UniHTMLFrame1.HTML.Clear;

  mtb_cidades_.Last;
  mtb_cidades_.First;

  // ua ve todas as cidades - Unidade só vê a sua
  if UniMainModule.usuario.Filial in [98,99] then
  begin
    while not mtb_cidades_.Eof do
    begin
      UniHTMLFrame1.HTML.Add(' <iframe allowtransparency="true" marginwidth="0" marginheight="0" ');
      UniHTMLFrame1.HTML.Add('hspace="0" vspace="0" frameborder="0" scrolling="no" height="200px" width="215px"');
      UniHTMLFrame1.HTML.Add('src="https://www.cptec.inpe.br/widget/widget.php?p='+ IntToStr(mtb_cidades_cod_cptec.AsInteger) +'&w=h&c=607065&f=ffffff" ></iframe>');
      mtb_cidades_.Next;
    end;
  end
  else
  begin
    UniHTMLFrame1.HTML.Add(' <iframe allowtransparency="true" marginwidth="0" marginheight="0" ');
    UniHTMLFrame1.HTML.Add('hspace="0" vspace="0" frameborder="0" scrolling="no" height="200px" width="215px"');
    UniHTMLFrame1.HTML.Add('src="https://www.cptec.inpe.br/widget/widget.php?p='+ IntToStr(CodCidadeCptec(UniMainModule.usuario.Filial)) +'&w=h&c=607065&f=ffffff" ></iframe>');
  end;
  UniHTMLFrame1.Refresh;
end;

procedure TfmPrevisao.CarregaCidades;
var
  l,l2 : TStringList;
  I    : Integer;
begin
  try
    l  := TStringList.Create;
    l2 := TStringList.Create;

    if not FileExists( UniServerModule.FilesFolderPath + 'cidades_previsao.csv' ) then
    begin
      MessageDlg('Arquivo de Configurações não encontrado',mtError,[mbOk],nil);
      Exit;
    end;

    l.Clear;
    l.LoadFromFile( UniServerModule.FilesFolderPath + 'cidades_previsao.csv' );

    mtb_cidades_.Open;
    mtb_cidades_.EmptyDataSet;
    for I := 0 to l.Count - 1 do
    begin
      l2.Clear;
      ExtractStrings([';'],[' '],PChar(l[i]),l2);
      if i > 0 then
      begin
        mtb_cidades_.Append;
        mtb_cidades_cidade_cod.AsInteger  := StrToInt( l2[0] );
        mtb_cidades_cidade_nome.AsString  := l2[1];
        mtb_cidades_cod_cptec.AsInteger   := StrToInt( l2[2] );
        mtb_cidades_.Post;
      end;
    end;
  finally
    l.Free;
    l2.Free;
  end;
end;

end.
