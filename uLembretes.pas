unit uLembretes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniDateTimePicker,
  uniGUIBaseClasses, uniLabel, uniDBDateTimePicker, DB;

type
  TfmLembrete = class(TUniForm)
    dt_: TUniDBDateTimePicker;
    btOk: TUniBitBtn;
    procedure btOkClick(Sender: TObject);
    procedure UniFormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Grava(Sender : TComponent; Res : Integer);
  public
    { Public declarations }
  end;

function fmLembrete: TfmLembrete;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function fmLembrete: TfmLembrete;
begin
  Result := TfmLembrete(UniMainModule.GetFormInstance(TfmLembrete));
end;

procedure TfmLembrete.btOkClick(Sender: TObject);
begin
  MessageDlg('Atenção! Você será notificado novamente em ' + DateTimeToStr(dt_.DateTime) + '. Confirma?',mtInformation,mbYesNo,Grava);
end;

procedure TfmLembrete.Grava(Sender: TComponent; Res: Integer);
begin
  if Res = mrYes then
  begin
    UniMainModule.sql_tb_alertas_.Post;
    Self.ModalResult := mrOk;
  end;
end;

procedure TfmLembrete.UniFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if UniMainModule.sql_tb_alertas_.State = dsEdit then
    UniMainModule.sql_tb_alertas_.Cancel;
  ModalResult := mrCancel;
end;

end.
