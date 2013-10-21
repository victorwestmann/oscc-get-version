unit uFileInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TfrFileInfo = class(TForm)
    lblFile: TLabel;
    lblName: TLabel;
    lblSize: TLabel;
    BitBtn1: TBitBtn;
    lblModified: TLabel;
    lblShortName: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frFileInfo: TfrFileInfo;

implementation

{$R *.DFM}

procedure TfrFileInfo.BitBtn1Click(Sender: TObject);
begin
  Close;
end;


end.
