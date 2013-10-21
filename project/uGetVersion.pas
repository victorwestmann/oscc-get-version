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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls;

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
    mmLicense: TMemo;
    btnClose: TButton;
    lblTitle: TLabel;
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
    lblUpperTittle: TLabel;
    lblSoftwaresUsed: TLabel;
    lblWorksWith: TLabel;
    imgTugmain: TImage;
    imgManager: TImage;
    imgClientDesktop: TImage;
    imgOperatingSystem: TImage;
    Button1: TButton;
    ListBox1: TListBox;
    lblNumberFound: TLabel;
    ListBox2: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnCopiarSOClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCopiarTugmainClick(Sender: TObject);
    procedure btnCopiarManagerClick(Sender: TObject);
    procedure btnCopiarClientDesktopClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    {Importado do projeto de Busca Recursiva}
    procedure ListBox1DblClick(Sender: TObject);

  private
    { Private declarations }
    procedure FileSearch(const PathName, FileName : string);
  public
    { Public declarations }
  ListDir      : TStringList;
  ListPath     : TStringList;
  ListPrograms : TStringList;
  end;

var
  frmPrincipal: TfrmPrincipal;

const
  paths : array[0..3] of string = (
      'D:\Program Files (x86)\',
      'D:\Program Files\',
      'C:\Program Files (x86)\',
      'C:\Program Files\');

  apps  : array[0..2] of string = (
      'tmcmain.exe',
      'tacmain.exe',
      'tugmain.exe');

implementation

{$R *.dfm}

uses
  uSplash,
  uFileInfo;

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

{http://stackoverflow.com/questions/1717844/how-to-determine-delphi-application-version}
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
  lbeManager.SelectAll;         {Copy all text from the 'Labeled Edit'}
  lbeManager.CopyToClipboard;   {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCopiarSOClick(Sender: TObject);
begin
  lbeSO.SelectAll;              {Copy all text from the 'Labeled Edit'}
  lbeSO.CopyToClipboard;        {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCopiarTugmainClick(Sender: TObject);
begin
  lbeTugmain.SelectAll;         {Copy all text from the 'Labeled Edit'}
  lbeTugmain.CopyToClipboard;   {Copy everything to the Clipboard}
end;

procedure TfrmPrincipal.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.FileSearch(const PathName, FileName : string);
var
    Rec  : TSearchRec;
    Path : string;
begin
Path := IncludeTrailingBackslash(PathName);
if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
 try
   repeat
     ListBox1.Items.Add(Path + Rec.Name);
     ListBox2.Items.Add(GetVersion(Path + Rec.Name));
   until FindNext(Rec) <> 0;
 finally
   FindClose(Rec);
 end;

if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
 try
   repeat
    if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name<>'.') and (Rec.Name<>'..') then
     FileSearch(Path + Rec.Name, FileName);
   until FindNext(Rec) <> 0;
 finally
   FindClose(Rec);
 end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  j             : Integer;
  i             : Integer;
  Manager       : String;
  ClientDesktop : String;
  Tugmain       : String;
begin
  Manager       := 'tmcmain.exe';
  ClientDesktop := 'tacmain.exe';
  Tugmain       := 'tugmain.exe';

  {Gets the current Operating System info and displays it}
  lbeSO.Text := TOSVersion.ToString;
  lbeSO.Text := TOSVersion.ToString;
//  recursive := True;
  ListBox1.Clear;
  lblNumberFound.Caption:=Inttostr(ListBox1.Items.Count) + ' files found.';

  {Começo do laço para procurar caminhos}
  for i := 0 to 3 do
  begin
    {Laço para procurar arquivos do OSCC}
    for j := 0 to 2 do
    begin
      FileSearch(paths[i],apps[j]);
      if (fileExists(paths[i]+apps[j])) then
      begin
        lbeTugmain.Text := GetVersion(apps[j]);
//        lbeManager.Text := GetVersion(apps[j]);
//        lbeClientDesktop.Text := GetVersion(apps[j]);
      end
    end;
  end;
  lblNumberFound.Caption := Inttostr(ListBox1.Items.Count) + ' files found.';
end;

//procedure FileSearch

{Quando clica 2x no arquivo encontrado para ver as propriedades}
procedure TfrmPrincipal.ListBox1DblClick(Sender: TObject);
var
  SelectedFile : string;
  Rec          : TSearchRec;
  frInfo       : TfrFileInfo;
begin
SelectedFile := ListBox1.Items.Strings[ListBox1.ItemIndex];

if FindFirst(SelectedFile, faAnyFile, Rec) = 0 then
 begin
  frInfo := TfrFileInfo.Create(Self);
  try
    frInfo.lblFile.Caption       := SelectedFile;
    frInfo.lblname.Caption       := Rec.name;
    frInfo.lblSize.Caption       := Format('%d bytes',[Rec.Size]);
    frInfo.lblModified.Caption   := DateToStr(FileDateToDateTime(Rec.Time));
    frInfo.lblShortName.Caption  := Rec.FindData.cAlternateFileName;
    frInfo.ShowModal;
  finally
    frInfo.Free;
  end;
  FindClose(Rec)
 end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  FileSearch(ListDir[0], ListPrograms[0] );
  {Get software version here}
  lblVersion.Caption := lblVersion.Caption + ' - v' + GetBuildInfoAsString;
end;


end.
