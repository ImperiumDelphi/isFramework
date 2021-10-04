unit uPokedex;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.ISBase, FMX.ISBaseButtons, FMX.ISCircleIcon, FMX.ISLayouts, FMX.Layouts, FMX.Ani,
  FMX.ISButtons, FMX.ISSendMail, FMX.ISLabel, FMX.ISCards, FMX.ISCardList,
  FMX.ISDownload, FMX.ISWait, FMX.ISExecute, FMX.Controls.Presentation,
  FMX.Edit, FMX.ISEditEx, FMX.StdCtrls, FMX.ISBitmapList,
  FMX.Effects, FMX.ISSearchEdit, FMX.ISBase.Presented, FMX.ISDataCardBase, FMX.ISDataCard,
  FMX.ISDataCardImageField, FMX.ISDataCardFields, FMX.ISText, FMX.ISDataCardList, FMX.ISDataCardImageFieldEx,

  System.Json.Types,
  System.Json.Readers,
  System.Json,
  FMX.ISIcon,
  FMX.ISControls, FMX.ISPath, FMX.ISObjects;

type
  TPokeForm = class(TForm)
    Principal: TISParentLayout;
    MainPokedex: TISChildrenLayout;
    Ball: TISIconButton;
    LayUp: TLayout;
    ISControl2: TISControl;
    LayDown: TLayout;
    ISControl3: TISControl;
    LayList: TISChildrenLayout;
    List: TISDataCardList;
    PokeCard: TISDataCard;
    Name: TISTextField;
    Down: TISDownload;
    Tipo1: TISTextField;
    Tipo2: TISTextField;
    Tipo3: TISTextField;
    ISWaitLayout1: TISWaitLayout;
    ISBitmapList1: TISBitmapList;
    ISBitmap1: TISBitmap;
    GlowEffect1: TGlowEffect;
    AniGlow: TFloatAnimation;
    Image1: TImage;
    ISSearchEdit1: TISSearchEdit;
    ISWorkField1: TISWorkField;
    ISWorkField2: TISWorkField;
    ImgDefault: TImage;
    ISImageFieldEx2: TISImageFieldEx;
    ISTextField6: TISTextField;
    ISCircleControl1: TISCircleControl;
    procedure MainPokedexShow(Sender: TObject);
    procedure BallClicked(Sender: TObject);
    procedure LayListShow(Sender: TObject);
    procedure MainPokedexActivate(Sender: TObject);
    procedure PokeCardLoadRecord(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FTipos : TStringList;
    Procedure OpenPokedex;
    Procedure ClosePokedex;
  public
    { Public declarations }
  end;

var
  Pokeform: TPokeForm;

implementation

{$R *.fmx}


procedure TPokeForm.OpenPokedex;
begin
Log.d('Open Pokedex');
MainPokedex.BackgroundColor := $FFAF272A;
TAnimator.AnimateFloat(LayUp,   'Position.Y', -Layup.Height,      0.6, TAnimationType.&in, TInterpolationType.Exponential);
TAnimator.AnimateFloat(LayDown, 'Position.Y', MainPokedex.Height, 0.6, TAnimationType.&in, TInterpolationType.Exponential);
TAnimator.AnimateFloat(Ball,    'Opacity',    0,                  0.6);
TISExecute.StartExecute(600,
   procedure
   Begin
   TAnimator.AnimateColor(MainPokedex, 'BackgroundColor', TAlphaColorRec.White, 0.4);
   End);
end;

procedure TPokeForm.ClosePokedex;
begin
Log.d('Close Pokedex');
TAnimator.AnimateColor(MainPokedex, 'BackgroundColor', $FFAF272A, 0.4);
TISExecute.StartExecute(400,
   procedure
   Begin
   TAnimator.AnimateFloat(LayUp,   'Position.Y', MainPokeDex.Height/2 - LayUp.Height+1, 0.3, TAnimationType.Out, TInterpolationType.Exponential);
   TAnimator.AnimateFloat(LayDown, 'Position.Y', MainPokeDex.Height/2,                  0.3, TAnimationType.Out, TInterpolationType.Exponential);
   TAnimator.AnimateFloat(Ball,    'Opacity',    1,                                     0.3);
   End);
end;

procedure TPokeForm.FormCreate(Sender: TObject);
begin
FTipos := TStringList.Create;
end;

procedure TPokeForm.FormDestroy(Sender: TObject);
begin
FTipos.DisposeOf;
end;

procedure TPokeForm.MainPokedexShow(Sender: TObject);
begin
Log.d('Main Pokedex Show');
TISImageFieldEX.DefaultImage.Assign(ImgDefault.Bitmap);
TISImageFieldEx.DefaultImageColor := TAlphaColors.Lightgray;
LayUp  .Position.X := -1000;
LayDown.Position.X := -1000;
Ball   .Opacity    := 0;
TISExecute.StartExecute(20,
   Procedure
   Begin
   Ball   .Opacity    := 1;
   LayUp  .Position.X := (Principal.Width - LayUp.Width)/2;
   LayUp  .Position.Y := -LayUp.Height;
   LayDown.Position.X := (Principal.Width - LayUp.Width)/2;
   LayDown.Position.Y := Principal.Height;
   Ball   .Opacity    := 0;
   End);
end;

procedure TPokeForm.MainPokedexActivate(Sender: TObject);
begin
Log.d('Main Pokedex Activation');
AniGlow.Enabled := True;
List.Clear;
TISExecute.StartExecute(1000,
   Procedure
   Begin
   ClosePokedex;
   End);
end;

procedure TPokeForm.BallClicked(Sender: TObject);
begin
Log.d('Clicou início');
AniGlow.Enabled := False;
OpenPokedex;
TISExecute.StartExecute(1000,
   Procedure
   Begin
   LayList.ShowLayout;
   end);
end;

procedure TPokeForm.PokeCardLoadRecord(Sender: TObject);
Var
   ID_   : Integer;
begin
ID_         := PokeCard.FieldByName('pokemon_id').AsInteger;
FTipos.Text := PokeCard.FieldByName('type').AsString+#13#10+#13#10+#13#10+#13#10;
PokeCard.FieldByName('Type1').AsString  := FTipos[0].Trim;
PokeCard.FieldByName('Type2').AsString  := FTipos[1].Trim;
PokeCard.FieldByName('Type3').AsString  := FTipos[2].Trim;
PokeCard.FieldByName('Photo').AsString  := 'https://www.serebii.net/pokemongo/pokemon/'+FormatFloat('000',PokeCard.FieldByName('Pokemon_id').AsInteger)+'.png';
case Id_ mod 8 of
   0 : PokeCard.Color := TAlphaColorRec.Crimson;
   1 : PokeCard.Color := TAlphaColorRec.SkyBlue;
   2 : PokeCard.Color := TAlphaColorRec.Blueviolet;
   3 : PokeCard.Color := TAlphaColorRec.Teal;
   4 : PokeCard.Color := TAlphaColorRec.Brown;
   5 : PokeCard.Color := TAlphaColorRec.Cadetblue;
   6 : PokeCard.Color := TAlphaColorRec.Cornflowerblue;
   7 : PokeCard.Color := TAlphaColorRec.Mediumorchid;
   end;
end;

procedure TPokeForm.LayListShow(Sender: TObject);
begin
Log.d('Entrou ListShow');
List.Clear;
TThread.CreateAnonymousThread(
   Procedure
   Begin
   List.BeginUpdate;
   Log.d('Carregou Json Thread');
   List.LoadFromJsonArray(PokeCard, 'https://app.jusimperium.com.br/curso/pokemon/Pokemon.json');
   List.EndUpdate;
   End).Start;
end;

end.
