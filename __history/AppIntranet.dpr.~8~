{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module'

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  AppIntranet;

uses
  uniGUIISAPI,
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  uLogin in 'uLogin.pas' {fmLogin: TUniLoginForm},
  uClassUsuario in '..\Publico\uClassUsuario.pas',
  uManutencaoRamais in 'uManutencaoRamais.pas' {fmManutencaoRamais: TUniForm},
  uManutencaoImagens in 'uManutencaoImagens.pas' {fmManutencaoImagens: TUniForm},
  uManutencaoLinks in 'uManutencaoLinks.pas' {fmManutencaoLinks: TUniForm},
  uLembretes in 'uLembretes.pas' {fmLembrete: TUniForm},
  ufrRamais in 'ufrRamais.pas' {frRamais: TUniFrame},
  ufrLinksUteis in 'ufrLinksUteis.pas' {frLinksUteis: TUniFrame},
  ufrConfiguracoes in 'ufrConfiguracoes.pas' {frConfiguracoes: TUniFrame},
  uCronogramaEntrega in '..\Circulacao_new\uCronogramaEntrega.pas' {frmCronogramaEntrega: TUniForm},
  uFuncoesUnigui in '..\Publico\uFuncoesUnigui.pas',
  ActiveDs_TLB in '..\Publico\ActiveDs_TLB.pas',
  adshlp in '..\Publico\adshlp.pas',
  uCalendarioVisitas in 'uCalendarioVisitas.pas' {FrmCalendarioVisitas: TUniForm},
  UChat in 'UChat.pas' {frmChat: TUniFrame},
  uPrevisaoTempo in 'uPrevisaoTempo.pas' {fmPrevisao: TUniForm};

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
