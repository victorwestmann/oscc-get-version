program osccGetVersion;

uses
  System.SysUtils,
  Vcl.Forms,
  uGetVersion in 'uGetVersion.pas' {frmPrincipal},
  uSplash in 'uSplash.pas' {frmSplash},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Auric');
  Application.Title := 'OSCC Get Version';
  frmSplash := TfrmSplash.Create(nil) ;
  frmSplash.Show;
  frmSplash.Update;
  Sleep(7000);                                        {Time in ms that will display the splash screen}
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  frmSplash.Hide;
  frmSplash.Free;
  Application.Run;
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
