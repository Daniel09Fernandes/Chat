unit uManutencaoImagens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, Vcl.Imaging.pngimage, uniGUIBaseClasses, uniImage,
  uniFileUpload;

type
  TfmManutencaoImagens = class(TUniForm)
    UniImage1: TUniImage;
    UniImage2: TUniImage;
    up_: TUniFileUpload;
    procedure UniImage2Click(Sender: TObject);
    procedure up_Completed(Sender: TObject; AStream: TFileStream);
    procedure UniImage1Click(Sender: TObject);
  private
    { Private declarations }
  public
    tipo : string;
  end;

function fmManutencaoImagens: TfmManutencaoImagens;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uFuncoesUnigui;

function fmManutencaoImagens: TfmManutencaoImagens;
begin
  Result := TfmManutencaoImagens(UniMainModule.GetFormInstance(TfmManutencaoImagens));
end;

procedure TfmManutencaoImagens.UniImage1Click(Sender: TObject);
begin
  tipo := 'E'; // entrada
  up_.Execute;
end;

procedure TfmManutencaoImagens.UniImage2Click(Sender: TObject);
begin
  tipo := 'P'; // portal
  up_.Execute;
end;

procedure TfmManutencaoImagens.up_Completed(Sender: TObject; AStream: TFileStream);
var
  DestName: string;
begin
  if pos('.JPG',AnsiUpperCase(AStream.FileName)) > 0 then
  begin
    DestName := uFuncoesUnigui.GeraNome + '.jpg';

    CopyFile(PChar(AStream.FileName), PChar(UniMainModule.path_imagens + DestName), False);

    if UniMainModule.xml_arquivos_.Active = False then
      UniMainModule.xml_arquivos_.Open;

    UniMainModule.xml_arquivos_.Insert;
    UniMainModule.xml_arquivos_arquivo.AsString := DestName;
    UniMainModule.xml_arquivos_data.AsDateTime  := Now();
    UniMainModule.xml_arquivos_tipo.AsString    := Self.tipo;
    UniMainModule.xml_arquivos_.Post;
    ShowMessage('Upload realizado com sucesso! Reinicie o portal para efetivar as alterações!');
  end
  else
    ShowMessage('Somente arquivos com a extensão ".JPG" são permitidos');
end;
end.
