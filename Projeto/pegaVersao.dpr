program pegaVersao;

uses
  Vcl.Forms,
  uPegaVersoes in 'uPegaVersoes.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
