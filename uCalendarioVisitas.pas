unit uCalendarioVisitas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uniGUITypes, uniGUIAbstractClasses, uniGUIClasses, uniGUIForm, Vcl.Menus,
  uniMainMenu, uniEdit, uniDateTimePicker, uniGroupBox, uniLabel, uniButton,
  uniBitBtn, uniMenuButton, uniGUIBaseClasses, uniPanel, uADStanIntf,
  uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf,
  uADDAptIntf, uADStanAsync, uADDAptManager, Data.DB, uADCompDataSet,
  uADCompClient, uniBasicGrid, uniDBGrid, uniMultiItem, uniComboBox,
  uniRadioGroup, Vcl.Imaging.pngimage, uniImage;

type
  TFrmCalendarioVisitas = class(TUniForm)
    UniContainerPanel1: TUniContainerPanel;
    pop1: TUniPopupMenu;
    Incluir1: TUniMenuItem;
    excluir1: TUniMenuItem;
    Gerarexcel1: TUniMenuItem;
    UniDBGrid1: TUniDBGrid;
    sql_calendario_: TADQuery;
    ds_calendario_: TDataSource;
    sql_calendario_id: TIntegerField;
    sql_calendario_colaborador: TStringField;
    sql_calendario_departamento: TStringField;
    sql_calendario_data_ida: TDateField;
    sql_calendario_data_retorno: TDateField;
    sql_calendario_obs: TStringField;
    sql_calendario_filial: TStringField;
    UniHiddenPanel1: TUniHiddenPanel;
    dtSaida: TUniDateTimePicker;
    dtRetorno: TUniDateTimePicker;
    edFilial: TUniEdit;
    cbColaborador: TUniComboBox;
    edObs: TUniEdit;
    sql_calendario_responsavel: TStringField;
    sql_calendario_placa: TStringField;
    sql_calendario_confirmado: TStringField;
    cbCarro: TUniComboBox;
    cbPlaca: TUniComboBox;
    imgOk: TUniImage;
    imgAlerta: TUniImage;
    ConfirmarReserva1: TUniMenuItem;
    sql_calendario_carro: TStringField;
    UniPanel1: TUniPanel;
    UniLabel4: TUniLabel;
    UniEdit1: TUniEdit;
    btBuscar: TUniMenuButton;
    UniPanel2: TUniPanel;
    rgMostrar: TUniRadioGroup;
    UniImage1: TUniImage;
    sql_: TADQuery;
    procedure UniFormShow(Sender: TObject);
    procedure sql_calendario_BeforePost(DataSet: TDataSet);
    procedure Incluir1Click(Sender: TObject);
    procedure btBuscarClick(Sender: TObject);
    procedure UniDBGrid1ColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
    procedure Gerarexcel1Click(Sender: TObject);
    procedure excluir1Click(Sender: TObject);
    procedure sql_calendario_AfterPost(DataSet: TDataSet);
    procedure UniDBGrid1FieldImage(const Column: TUniDBGridColumn; const AField: TField; var OutImage: TGraphic; var DoNotDispose: Boolean; var ATransparent: TUniTransparentOption);
    procedure ConfirmarReserva1Click(Sender: TObject);
    procedure rgMostrarClick(Sender: TObject);
  private
    procedure EnviarAlerta(mensagem: string);
    { Private declarations }
  public
    { Public declarations }
  end;

function FrmCalendarioVisitas: TFrmCalendarioVisitas;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, uFuncoesUnigui, ServerModule;

function FrmCalendarioVisitas: TFrmCalendarioVisitas;
begin
  Result := TFrmCalendarioVisitas(UniMainModule.GetFormInstance(TFrmCalendarioVisitas));
end;

procedure TFrmCalendarioVisitas.btBuscarClick(Sender: TObject);
begin
//  sql_calendario_.Active := false;
  sql_calendario_.close;

  if UniEdit1.Text <> '' then
    sql_calendario_.Params[0].AsString := UniEdit1.Text
  else
    sql_calendario_.Params[0].AsString := '';

  if rgMostrar.ItemIndex = 1 then
    sql_calendario_.Params[1].AsString := 'Nao Confirmados'
  else
    sql_calendario_.Params[1].AsString := '';

 // sql_calendario_.Active := True;
  sql_calendario_.Open;

end;

procedure TFrmCalendarioVisitas.ConfirmarReserva1Click(Sender: TObject);
begin
  if sql_calendario_placa.asString = '' then
  begin
    ShowMessage('Informe a placa do veículo antes de confirmar a reserva.');
    exit;
  end;

  MessageDlg('Confirma a reserva do veículo para ' + sql_calendario_colaborador.AsString + ', dia ' + datetostr(sql_calendario_data_ida.AsDateTime) + ' para a filial ' + sql_calendario_filial.AsString + ' ?', mtConfirmation, mbYesNo,
    procedure(Sender: TComponent; Res: Integer)
    begin
      if Res = mrYes then
      begin
        try
          sql_calendario_.edit;
          sql_calendario_confirmado.AsString := 'SIM';
          sql_calendario_.post;
        except
          on e: exception do
            ShowMessage('Erro ao confirmar. ' + e.message);
        end;

        uFuncoesUniGui.GeraLogDB(UniMainModule.Usuario.Codigo, 'APPINTRANET', 'TB_CALEND_V', 'A', 'Confirmacao reserva veiculo. ID: ' + IntToStr(sql_calendario_id.AsInteger) + ' do colaborador ' + sql_calendario_colaborador.AsString + ', dia ' + datetostr(sql_calendario_data_ida.AsDateTime) + ' para a filial ' + sql_calendario_filial.AsString, UniMainModule.sql_livre_);

        sql_calendario_.refresh;

      end;
    end);
end;

procedure TFrmCalendarioVisitas.excluir1Click(Sender: TObject);
begin
  if sql_calendario_.RecordCount > 0 then
    MessageDlg('Confirma a exclusão da visita do colaborador ' + sql_calendario_colaborador.AsString + ', dia ' + datetostr(sql_calendario_data_ida.AsDateTime) + ' para a filial ' + sql_calendario_filial.AsString + ' ?', mtConfirmation, mbYesNo,
      procedure(Sender: TComponent; Res: Integer)
      begin
        if Res = mrYes then
        begin
          uFuncoesUniGui.GeraLogDB(UniMainModule.Usuario.Codigo, 'APPINTRANET', 'TB_CALEND_V', 'E', 'Exclusao ID: ' + IntToStr(sql_calendario_id.AsInteger) + ' do colaborador ' + sql_calendario_colaborador.AsString + ', dia ' + datetostr(sql_calendario_data_ida.AsDateTime) + ' para a filial ' + sql_calendario_filial.AsString, UniMainModule.sql_livre_);

          sql_calendario_.Delete;
          btBuscarClick(self);

        end;
      end);
end;

procedure TFrmCalendarioVisitas.Gerarexcel1Click(Sender: TObject);
var
  x_nome: string;
begin
  x_nome := UniServerModule.TempFolderPath + uFuncoesUnigui.GeraNome + '.xls';
  uFuncoesUnigui.GeraXLS(sql_calendario_, x_nome);

  if FileExists(x_nome) then
    UniSession.SendFile(x_nome);
end;

procedure TFrmCalendarioVisitas.Incluir1Click(Sender: TObject);
begin
  sql_calendario_.append;
  sql_calendario_responsavel.AsString := UniMainModule.usuario.Nome;
  sql_calendario_colaborador.AsString := UniMainModule.usuario.Nome;
end;

procedure TFrmCalendarioVisitas.rgMostrarClick(Sender: TObject);
begin
  btBuscarClick(self);
end;

procedure TFrmCalendarioVisitas.sql_calendario_AfterPost(DataSet: TDataSet);
begin
  if sql_calendario_confirmado.AsString = 'NAO' then
    EnviarAlerta('Nova solicitacao de reserva de veiculo registrado no calendario de visitas ');

  sql_calendario_.Refresh;
end;

procedure TFrmCalendarioVisitas.EnviarAlerta(mensagem: string);
const
  sql_txt = ' insert into public.tb_alertas ' + ' ( usuario_codigo, alerta_msg) ' + ' VALUES (:usuario_codigo,:alerta_msg) ';
//const aUser : array[0..2] of Integer = (130,673,729);
var
  i: Integer;
begin
  sql_.Close;
  sql_.SQL.Text := sql_txt;
  //for i := Low(aUser) to High(aUser) do
  //begin
  sql_.ParamByName('usuario_codigo').AsInteger := 94;
  sql_.ParamByName('alerta_msg').AsString := mensagem;
  sql_.ExecSQL;
  //end;
end;

procedure TFrmCalendarioVisitas.sql_calendario_BeforePost(DataSet: TDataSet);
var
  i: Integer;
  dup: string;
begin
  sql_calendario_obs.AsString := AnsiUpperCase(TiraAcentos(sql_calendario_obs.AsString));

  UniMainModule.sql_livre_.close;
  UniMainModule.sql_livre_.sql.Clear;
  UniMainModule.sql_livre_.SQL.Add('select dep_nome from tb_user u join departamento d on d.dep_cod = u.dep_cod where u.filial_cod in (97,98,99) and u.ativo = true and u.nome = :nome');
  UniMainModule.sql_livre_.ParamByName('nome').AsString := sql_calendario_colaborador.asString;
  UniMainModule.sql_livre_.open;

  if not UniMainModule.sql_livre_.isempty then
    sql_calendario_departamento.AsString := UniMainModule.sql_livre_.FieldByName('dep_nome').AsString;

  if sql_calendario_carro.AsString = '' then
    sql_calendario_carro.AsString := 'NAO';

  if (sql_calendario_carro.AsString <> 'SIM') then
    sql_calendario_confirmado.AsString := 'SIM'
  else if (sql_calendario_carro.AsString = 'SIM') and (sql_calendario_placa.AsString = '') then
    sql_calendario_confirmado.AsString := 'NAO';

  if sql_calendario_.State in [dsEdit] then
    uFuncoesUniGui.GeraLogDB(UniMainModule.Usuario.Codigo, 'APPINTRANET', 'TB_CALEND_V', 'A', 'Alteracao de registro id: ' + IntToStr(sql_calendario_id.AsInteger), UniMainModule.sql_livre_);
end;

procedure TFrmCalendarioVisitas.UniDBGrid1ColumnSort(Column: TUniDBGridColumn; Direction: Boolean);
begin
  OrdenaGrid(Column, Direction);
end;

procedure TFrmCalendarioVisitas.UniDBGrid1FieldImage(const Column: TUniDBGridColumn; const AField: TField; var OutImage: TGraphic; var DoNotDispose: Boolean; var ATransparent: TUniTransparentOption);
begin
  DoNotDispose := true;
  if AField.FieldName = 'confirmado' then
  begin
    if sql_calendario_confirmado.asString = 'SIM' then
      OutImage := imgOk.Picture.Graphic
    else if (sql_calendario_confirmado.asString = 'NAO') and (sql_calendario_carro.asString = 'SIM') then
      OutImage := imgAlerta.Picture.Graphic;
  end;
end;

procedure TFrmCalendarioVisitas.UniFormShow(Sender: TObject);
begin
   UniMainModule.AbreConexao;
  dtSaida.DateTime := date;
  dtRetorno.DateTime := date;

  UniMainModule.sql_livre_.close;
  UniMainModule.sql_livre_.sql.Clear;
  UniMainModule.sql_livre_.SQL.Add('select nome from tb_user where filial_cod in (97,98,99) and ativo = true order by nome');
  UniMainModule.sql_livre_.open;

  while not UniMainModule.sql_livre_.eof do
  begin
    cbColaborador.Items.Add(UniMainModule.sql_livre_.FieldByName('nome').AsString);
    UniMainModule.sql_livre_.next;
  end;

  UniMainModule.sql_livre_.close;
  UniMainModule.sql_livre_.sql.Clear;
  UniMainModule.sql_livre_.SQL.Add('select distinct placa from tb_calend_visita order by placa');
  UniMainModule.sql_livre_.open;

  while not UniMainModule.sql_livre_.eof do
  begin
    cbPlaca.Items.Add(UniMainModule.sql_livre_.FieldByName('placa').AsString);
    UniMainModule.sql_livre_.next;
  end;

  if UniMainModule.Usuario.GrupoAcesso in [7, 16, 104, 107] then
  begin
    ConfirmarReserva1.Visible := True;
    uniDBGrid1.Columns.Items[2].ReadOnly := False;
  end;
//  else
//    UniPanel2.Visible := false
        btBuscarClick(self);
end;

end.

