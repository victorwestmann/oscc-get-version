unit uGetVersion;

{===============================================================================
Program created by

\   \ /   /|__| _____/  |_  ___________
 \   Y   / |  |/ ___\   __\/  _ \_  __ \
  \     /  |  \  \___|  | (  <_> )  | \/
   \___/   |__|\___  >__|  \____/|__|
                   \/
Date: 2013-09-07
Purpose: Get file version from OSCC (OpenScape ContatCenter) programs:

  Executable name     Program Name
  --------------------------------
  - Tugmain.exe       (Tugmain)
  - Tmcmain.exe       (Manager)
  - Tacmain.exe       (Client Desktop)

  (When installed) is generally found at:
  C:\Program Files (x86)\Siemens\HiPath Procenter\
===============================================================================}



interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls, Vcl.XPMan;

type
  TfrmPrincipal = class(TForm)
    pgcOpcoesPrograma: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    lbeSO: TLabeledEdit;
    btnCopiarSO: TButton;
    lbeClientDesktop: TLabeledEdit;
    lbeManager: TLabeledEdit;
    lbeTugmain: TLabeledEdit;
    imgIcone: TImage;
    mmLicense: TMemo;
    btnClose: TButton;
    Label1: TLabel;
    btnCopiarTugmain: TButton;
    btnCopiarManager: TButton;
    btnCopiarClientDesktop: TButton;
    imgProgram: TImage;
    lblProgram: TLabel;
    lblAuthor: TLabel;
    lblNote: TLabel;
    lblVersion: TLabel;
    imgBrazil: TImage;
    lblMadeInBrazil: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCopiarSOClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCopiarTugmainClick(Sender: TObject);
    procedure btnCopiarManagerClick(Sender: TObject);
    procedure btnCopiarClientDesktopClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uSplash;

{===============================================================================
Function extracted from:
http://www.delphitricks.com/source-code/files/get_the_version_of_a_file.html
===============================================================================}

function GetVersion(sFileName:string): string;
var
  VerInfoSize   : DWORD;
  VerInfo       : Pointer;
  VerValueSize  : DWORD;
  VerValue      : PVSFixedFileInfo;
  Dummy         : DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(sFileName), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(sFileName), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    Result := IntToStr(dwFileVersionMS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
    Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
    Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
end;
{==============================================================================}

{ Function to read environment variable========================================}
function GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(
    PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName),
      PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;
{==============================================================================}

{Function to expand environment variables======================================}
function ExpandEnvVars(const Str: string): string;
var
  BufSize: Integer; // size of expanded string
begin
  // Get required buffer size
  BufSize := ExpandEnvironmentStrings(
    PChar(Str), nil, 0);
  if BufSize > 0 then
  begin
    // Read expanded string into result string
    SetLength(Result, BufSize - 1);
    ExpandEnvironmentStrings(PChar(Str),
      PChar(Result), BufSize);
  end
  else
    // Trying to expand empty string
    Result := '';
end;
{==============================================================================}


{==============================================================================}
{
http://stackoverflow.com/questions/1717844/how-to-determine-delphi-application-version
}
procedure GetBuildInfo(var V1, V2, V3, V4: word);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  if VerInfoSize > 0 then
  begin
      GetMem(VerInfo, VerInfoSize);
      try
        if GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo) then
        begin
          VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
          with VerValue^ do
          begin
            V1 := dwFileVersionMS shr 16;
            V2 := dwFileVersionMS and $FFFF;
            V3 := dwFileVersionLS shr 16;
            V4 := dwFileVersionLS and $FFFF;
          end;
        end;
      finally
        FreeMem(VerInfo, VerInfoSize);
      end;
  end;
end;

function GetBuildInfoAsString: string;
var
  V1, V2, V3, V4: word;
begin
  GetBuildInfo(V1, V2, V3, V4);
  Result := IntToStr(V1) + '.' + IntToStr(V2) + '.' +
    IntToStr(V3) + '.' + IntToStr(V4);
end;
{==============================================================================}


procedure TfrmPrincipal.btnCopiarClientDesktopClick(Sender: TObject);
begin
  lbeClientDesktop.SelectAll;        {Copy all text from the 'Labeled Edit'}
  lbeClientDesktop.CopyToClipboard;  {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCopiarManagerClick(Sender: TObject);
begin
  lbeManager.SelectAll;        {Copy all text from the 'Labeled Edit'}
  lbeManager.CopyToClipboard;  {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCopiarSOClick(Sender: TObject);
begin
  lbeSO.SelectAll;        {Copy all text from the 'Labeled Edit'}
  lbeSO.CopyToClipboard;  {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCopiarTugmainClick(Sender: TObject);
begin
  lbeTugmain.SelectAll;        {Copy all text from the 'Labeled Edit'}
  lbeTugmain.CopyToClipboard;  {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  hppcdir   : string; //Executable Path!
begin
  {Enable progrtam to be blosed with ESC key}
  KeyPreview := True;

  lbeSO.Text := TOSVersion.ToString;
  hppcdir := GetEnvVarValue(hppcdir);

  {Search for the TUGMAIN.EXE version file}
  if not (fileExists('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tugmain.exe') = TRUE
       or fileExists('D:\Program Files (x86)\Enterprise\HiPath ProCenter\tugmain.exe') = TRUE) then
  begin
    lbeTugmain.Text := 'Not found!';
  end
  else
  begin
    lbeTugmain.Text := GetVersion('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tugmain.exe');
  end;

  {Search for the TMCMAIN.EXE (Manager) version file}
  if not (fileExists('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tmcmain.exe') = TRUE
      or  fileExists('D:\Program Files (x86)\Enterprise\HiPath ProCenter\tmcmain.exe') = TRUE ) then
  begin
    lbeManager.Text := 'Not found!';
  end
  else
  begin
    lbeManager.Text := GetVersion('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tmcmain.exe');
  end;

  {Search for the TACMAIN.EXE (Client Desktop) version file}
  if not (fileExists('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tacmain.exe') = TRUE
      or  fileExists('D:\Program Files (x86)\Enterprise\HiPath ProCenter\tacmain.exe') = TRUE) then
  begin
    lbeClientDesktop.Text := 'Not found!';
  end
  else
  begin
    lbeClientDesktop.Text := GetVersion('C:\Program Files (x86)\Enterprise\HiPath ProCenter\tacmain.exe');
  end;

  {Get software version here}
  lblVersion.Caption := lblVersion.Caption + ' - v' + GetBuildInfoAsString;
end;

{This is how to enable your application to be closed by pressing ESC}
procedure TfrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #27 then Close;
end;



end.
