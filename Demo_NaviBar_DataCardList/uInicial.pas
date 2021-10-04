unit uInicial;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ISBase, FMX.ISLayouts, FMX.ISBaseScrollLayout,
  FMX.ISNaviBarLayout, FMX.Layouts,

  uPesquisa, FMX.ISCalculator, FMX.Objects, FMX.ISBase.Presented, FMX.ISBaseButtons, FMX.ISButtons,
  FMX.ISNumericEditEx, FMX.Controls.Presentation, FMX.Edit, FMX.ISNumericEdit, FMX.ISPath, FMX.ISObjects, FMX.ISControls;

type
  TForm4 = class(TForm)
    ISParentLayout1: TISParentLayout;
    Main: TISNaviBarLayout;
    ISChildrenLayout1: TISChildrenLayout;
    ISIconTextButton1: TISIconTextButton;
    ISIconTextButton2: TISIconTextButton;
    ISIconTextButton3: TISIconTextButton;
    ISIconButton1: TISIconButton;
    ISIconButton2: TISIconButton;
    ISTextButton1: TISTextButton;
    ISSpeedButton1: TISSpeedButton;
    ISNumericEditEX1: TISNumericEditEX;
    procedure MainClickButton2(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.FormShow(Sender: TObject);
begin
ReportMemoryLeaksOnShutdown := True;
end;

procedure TForm4.MainClickButton2(Sender: TObject);
begin
Application.Terminate;
Close;
end;

end.
