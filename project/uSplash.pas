unit uSplash;

{===============================================================================
Program created by

\   \ /   /|__| _____/  |_  ___________
 \   Y   / |  |/ ___\   __\/  _ \_  __ \
  \     /  |  \  \___|  | (  <_> )  | \/
   \___/   |__|\___  >__|  \____/|__|
                   \/

Free Open Software used in this program:

Program Name                     Website
----------------------------------------------------
- Inkscape 0.48,                [ www.inkscape.org ]
- Gimp 2.8                      [ www.gimp.org     ]
- Green Fish Icon Portable 3.31 [ http://greenfishsoftware.blogspot.hu/2012/07/greenfish-icon-editor-pro.html]

Same software mentioned above can be found in portable versions at:
  http://portableapps.com/apps

===============================================================================}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmSplash = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

end.
