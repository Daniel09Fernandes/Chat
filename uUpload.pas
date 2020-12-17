unit uUpload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs,
  uniGUIForm, uniFileUpload,
  uniBitBtn, uniDBGrid, uniLabel, uniDBNavigator,
  uniDBEdit, uniGroupBox,
  uniDBCheckBox, uniDBMemo, uniGUIBaseClasses, uniGUIClasses, uniMemo,
  uniBasicGrid, uniCheckBox, uniEdit, uniButton;

type
  TfmUpload = class(TUniForm)
    UniGroupBox2: TUniGroupBox;
    UniBitBtn2: TUniBitBtn;
    UniBitBtn1: TUniBitBtn;
    UniFileUpload1: TUniFileUpload;
    gpLinks: TUniGroupBox;
    edLinkTitulo: TUniDBEdit;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    chkInterface: TUniDBCheckBox;
    UniDBGrid1: TUniDBGrid;
    UniDBNavigator2: TUniDBNavigator;
    UniDBMemo1: TUniDBMemo;
    procedure UniBitBtn1Click(Sender: TObject);
    procedure UniBitBtn2Click(Sender: TObject);
    procedure UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fmUpload: TfmUpload;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

var
  i_imagem : Integer;

function fmUpload: TfmUpload;
begin
  Result := TfmUpload(UniMainModule.GetFormInstance(TfmUpload));
end;

procedure TfmUpload.UniBitBtn1Click(Sender: TObject);
begin
  i_imagem := 1;
  UniFileUpload1.Execute;
end;

procedure TfmUpload.UniBitBtn2Click(Sender: TObject);
begin
  i_imagem := 2;
  UniFileUpload1.Execute;
end;

procedure TfmUpload.UniFileUpload1Completed(Sender: TObject; AStream: TFileStream);
var
  DestName: string;
const
  DestFolder = 'C:\Apps\AppIntranet\imagens\';
begin

  if pos('.JPG',AnsiUpperCase(AStream.FileName)) > 0 then
    begin
      if i_imagem = 1 then
        DestName := DestFolder +  'imagemh_' + IntToStr(i_imagem) + FormatDateTime('dd-MM-yy-hh-mm-ss',Now()) +'.jpg'
      else
      if i_imagem = 2 then
        DestName := DestFolder +  'imagemb_' + IntToStr(i_imagem) + FormatDateTime('dd-MM-yy-hh-mm-ss',Now()) +'.jpg';

      CopyFile(PChar(AStream.FileName), PChar(DestName), False);

      if UniMainModule.cds_arquivo_.Active = False then
        UniMainModule.cds_arquivo_.Active := True;

      if UniMainModule.cds_arquivo_.RecordCount > 0 then
        UniMainModule.cds_arquivo_.Edit
      else
        UniMainModule.cds_arquivo_.Insert;
//
      if i_imagem = 1 then
        UniMainModule.cds_arquivo_arquivo1.AsString := DestName
      else
      if i_imagem = 2 then
        begin
          if UniMainModule.cds_arquivo_.RecordCount = 0 then
            UniMainModule.cds_arquivo_.Insert
          else
            UniMainModule.cds_arquivo_.Edit;

          UniMainModule.cds_arquivo_arquivo2.AsString := DestName;
        end;

      UniMainModule.cds_arquivo_.Post;
      ShowMessage('Upload realizado com sucesso');
      UniSession.AddJS('window.location.reload(true)');
    end
  else
    ShowMessage('Somente arquivos com a extensão ".JPG" são permitidos');

end;

end.
