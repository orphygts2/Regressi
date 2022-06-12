unit FloatEdit;

interface

uses Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils,
  Forms, Graphics, Menus, Buttons, spin;

type
  CoeffUnite = (zero,yocto,zepto,atto,femto,pico,nano,micro,milli,
             nulle,kilo,mega,giga,tera,peta,exa,zetta,yotta,infini);
  strUnite = string[5];
  TcharSet = set of char;

{ TFloatEdit }

  TFloatEdit = class(TCustomEdit)
  private
    FMinValue: extended;
    FMaxValue: extended;
    FButton: TSpinButton;
    FEditorEnabled: Boolean;
    FnomUnite : strUnite;
    Fvalue : extended;
    function GetMinHeight: Integer;
    function CheckValue(NewValue: extended): extended;
    procedure SetValue(NewValue: extended);
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit);   message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste);   message WM_PASTE;
    procedure WMCut(var Message: TWMCut);   message WM_CUT;
  protected
    function valeur125(valeur : extended) : extended;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick (Sender: TObject); virtual;
    procedure DownClick (Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpinButton read FButton;
  published
    property AutoSelect;
    property AutoSize;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property MaxLength;
    property MaxValue: extended read FMaxValue write FMaxValue;
    property MinValue: extended read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: extended read Fvalue write SetValue;
    property NomUnite: strUnite read FnomUnite write FnomUnite;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

const
   prefixeUnite : array[coeffUnite] of char =
          ('0','y','z','a','f','p','n','µ','m',
           ' ','k','M','G','T','P','E','Z','Y','ì');
   valUnite : array[coeffUnite] of single =
           (1E-27,1E-24,1E-21,1E-18,1E-15,1E-12,1E-9,1E-6,1E-3,
            1,1E+3,1E+6,1E+9,1E+12,1E+15,1E+18,1E+21,1E+24,1E+27);

{ TFloatEdit }

constructor TFloatEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpinButton.Create (Self);
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  Text := '0.1';
  FMinValue := 0.01;
  FMaxValue := 100;
  ControlStyle := ControlStyle - [csSetCaption];
  FEditorEnabled := True;
end;

destructor TFloatEdit.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TFloatEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then UpClick (Self)
  else if Key = VK_DOWN then DownClick (Self);
  inherited KeyDown(Key, Shift);
end;

procedure TFloatEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TFloatEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := (Key in [DecimalSeparator, '+', '-', '0'..'9']) or
    ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or
      (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TFloatEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
{  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TFloatEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TFloatEdit.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;

procedure TFloatEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    FButton.SetBounds (Width - FButton.Width, 0, FButton.Width, Height);
    SetEditRect;
  end;
end;

function TFloatEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

procedure TFloatEdit.UpClick(Sender: TObject);
begin
  if ReadOnly
     then MessageBeep(0)
     else Value := Valeur125(FValue*2.15)
end;

procedure TFloatEdit.DownClick(Sender: TObject);
begin
  if ReadOnly
     then MessageBeep(0)
     else Value := Valeur125(FValue/2.15)
end;

procedure TFloatEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TFloatEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TFloatEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value)<>Value then SetValue(Value);
end;

procedure TFloatEdit.SetValue(NewValue: extended);
var unite : coeffUnite;

Function AjoutePrefixe : strUnite;
const
    lettreUnite : TcharSet = ['A'..'Z','a'..'z',#157];
    caracPrefixe : TcharSet = ['p','n','µ','m','k','M','G'];
var nom : strUnite;
begin
     if (length(FnomUnite)>1) and
        (FnomUnite[1] in caracPrefixe) and
        (FnomUnite[2] in lettreUnite) then begin
     	 case nomUnite[1] of
		  'p' : dec(unite,4);
		  'n' : dec(unite,3);
		  'µ' : dec(unite,2);
		  'm' : dec(unite,1);
		  'k' : inc(unite,1);
		  'M' : inc(unite,2);
		  'G' : inc(unite,3);
         end;
         nom := Copy(FnomUnite,2,length(FnomUnite));
     end
     else nom := FnomUnite;
     result := prefixeUnite[unite]+nom;
end;

begin
      NewValue := checkValue(NewValue);
      if NewValue=Fvalue then exit;
      unite := nulle;
      Fvalue := newValue;
      while ( newValue>=999 ) and (unite<infini) do begin
          newValue := newValue/1000;
          inc(unite)
      end; { newValue<1000 ou infini }
      while ( newValue<0.999 ) and (unite>zero) do begin
          newValue := newValue*1000;
          Dec(unite)
      end; { newValue>=1 ou zero }
      if unite=infini
         then text := '???'
         else if unite=zero
           then text := '0 '+FnomUnite
           else begin
               text := FloatToStrF(newValue,ffGeneral,4,0)+
                  ' '+AjoutePrefixe;
           end;
end;

function TFloatEdit.CheckValue(NewValue: extended): extended;
begin
  Result := NewValue;
  if NewValue<FMinValue
       then Result := FMinValue
       else if NewValue>FMaxValue then
            Result := FMaxValue;
end;

procedure TFloatEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

function TFloatEdit.valeur125(valeur : extended) : extended;
const Loge = 0.434294481903251828;
      Ln10 = 2.302585092994045680;
var mantisse,exposant,coeff : extended;
begin
     exposant := ln(valeur)*loge;
     coeff := Int(exposant);
     if (exposant<0) and (coeff<>exposant) then coeff := coeff-1;
     coeff := exp(coeff*ln10);
     mantisse := Int(valeur/coeff);
     if mantisse>2 then if mantisse<6
           then mantisse := 5
           else mantisse := 10;
     result := mantisse*coeff;
end;

procedure Register;
begin
  RegisterComponents('Exemples', [TFloatEdit]);
end;

end.
