unit GripSplitter;

interface

uses
  Windows, Messages, Graphics,
  vcl.controls,
  system.Types, system.UITypes, system.Classes,
  ExtCtrls, TypInfo, Forms, Math;

type
  TGripSplitter=class(TCustomControl)
  private
    FOldAssociateWindowProc:TWndMethod; 
    FMouseOnSplitter,FMouseSplitterDown,FMouseOnSplitterButton,
    FMouseSplitterButtonDown,FSnapped:Boolean;
    FLastSplitterSize:Integer;
    FAssociate: TControl;
    FSize: Integer;
    FTransparent: Boolean;             
    FSizingCursor: TCursor;
    FHSizingCursor:HCursor;
    FMinSplitSize,FMaxSplitSize: Integer;
    FUseThemes: Boolean;
    FUpdatingState:Boolean;
    FBeveled: Boolean;
    FOnResize: TNotifyEvent;
    Fcaption: string;

    procedure SetAssociate(const Value: TControl);
    function GetVertical: Boolean;
    procedure SetSize(Value: Integer);

    procedure SetTransparent(const Value: Boolean);
    procedure SetMouseOnSplitter(const Value: Boolean);
    procedure SetMouseOnSplitterButton(const Value: Boolean);
    procedure SetMouseSplitterButtonDown(const Value: Boolean);
    procedure SetMouseSplitterDown(const Value: Boolean);
    procedure SetSnapped(const Value: Boolean);
    procedure SetSizingCursor(const Value: TCursor);
    procedure SetMinSplitSize(Value: Integer);
    procedure SetMaxSplitSize(Value: Integer);
    procedure SetUseThemes(const Value: Boolean);
    procedure SetBeveled(const Value: Boolean);
    procedure SetOnResize(const Value: TNotifyEvent);
    procedure setCaption(const value : string);

    procedure WMMouseLeave(var Message:TMessage);message WM_MOUSELEAVE;
    procedure WMSetCursor(var Message:TMessage);message WM_SETCURSOR;
    procedure WMWindowPosChanged(var Message:TMessage);message WM_WINDOWPOSCHANGED;
  protected
    function IsStateValid:Boolean;

    property MouseOnSplitter:Boolean read FMouseOnSplitter write SetMouseOnSplitter;
    property MouseOnSplitterButton:Boolean read FMouseOnSplitterButton
                                           write SetMouseOnSplitterButton;
    property MouseSplitterDown:Boolean read FMouseSplitterDown
                                       write SetMouseSplitterDown;
    property MouseSplitterButtonDown:Boolean read FMouseSplitterButtonDown
                                             write SetMouseSplitterButtonDown;
    function GripRect:TRect;virtual;

    procedure Notification(AComponent:TComponent;Operation:TOperation);override;

    procedure NewAssociateWindowProc(var Message:TMessage);

    procedure Paint;override;

    procedure doResize;

    procedure MouseMove(Shift:TShiftState;X,Y:Integer);override;
    procedure MouseDown(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);override;
    procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);override;

    procedure UpdateAssociateState;
  public
    constructor Create(AOwner:TComponent);override;

    property Vertical:Boolean read GetVertical;
   //Vertical or not (read-only, the associate align determines it)

    destructor Destroy;override;
  published
    property caption: string read Fcaption write setCaption;
    property Associate:TControl read FAssociate write SetAssociate;
  //Associate control
    property Size:Integer read FSize write SetSize default 16;
  //Width if vertical, Height if horizontal
    property MinSplitSize:Integer read FMinSplitSize write SetMinSplitSize default 50;
  //Min associate size
    property MaxSplitSize:Integer read FMaxSplitSize write SetMaxSplitSize default 0;
 //Max associate size
    property Snapped:Boolean read FSnapped write SetSnapped;
 //Associate is "snapped" against parent border
    property Transparent:Boolean read FTransparent write SetTransparent;
  //Transparent or not
    property SizingCursor:TCursor read FSizingCursor write SetSizingCursor default crHSplit;
  //Sizing mouse cursor
    property UseThemes:Boolean read FUseThemes write SetUseThemes default True;
  //Use Windows themes
    property Beveled:Boolean read FBeveled write SetBeveled;
  //Draw a frame rect
    property OnResize:TNotifyEvent read FOnResize write SetOnResize;
  //When resize occurs
    property Color;    // Standard published properties
    property ParentColor;
    property Enabled;
  end;

procedure Register;

implementation

{$R GripSPlitter.dcr}

{ TGripSplitter }

constructor TGripSplitter.Create(AOwner: TComponent);
begin
  inherited;
  FUpdatingState:=True;
  ControlStyle:=[csSetCaption,csCaptureMouse,csClickEvents,csDesignInteractive];
  Size:=16;
  SizingCursor:=crHSplit;
  MinSplitSize:=50;
  FUseThemes:=True;
  FUpdatingState:=False;
end;

destructor TGripSplitter.Destroy;
begin
  Associate:=nil;
  inherited;
end;

procedure TGripSplitter.doResize;
begin
  if Assigned(FOnResize) then FOnResize(Self)
end;

function TGripSplitter.GetVertical: Boolean;
begin
  Result:=Align in [alLeft,alRight]
end;

function TGripSplitter.GripRect: TRect;
var
  a:Integer;
begin
  case Align of
    alLeft,alRight:begin
      a:=Height div 6;
      if a<3*FSize then a:=3*FSize;
      if a>Height div 3 then a:=Height div 3;
      Result:=Rect(0,Height div 2-a,Width,Height div 2+a);
    end;
    alTop,alBottom:begin
      a:=Width div 6;
      if a<3*FSize then a:=3*FSize;
      if a>Width div 3 then a:=Width div 3;
      Result:=Rect(Width div 2-a,0,Width div 2+a,Height);
    end;
  else Result:=Rect(0,0,0,0);
  end;
end;

function TGripSplitter.IsStateValid: Boolean;
begin
  Result:=Assigned(FAssociate) and (Align in [alLeft,alTop,alBottom,alRight])
end;

procedure TGripSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  MouseMove(Shift,X,Y);
  if FMouseOnSplitterButton
     then MouseSplitterButtonDown:=True
  else if FMouseOnSplitter then
      MouseSplitterDown:=True;
end;

procedure TGripSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p:TPoint;
begin
  inherited;
  if FMouseSplitterDown then begin
    p:=ClientToParent(Point(X,Y));
    case Align of
      alLeft:begin
        if p.X<FAssociate.Left+FMinSplitSize div 2 then
          Snapped:=True
        else begin
          Snapped:=False;
          if p.X<FAssociate.Left+FMinSplitSize+FSize div 2
          then  FAssociate.Width:=FMinSplitSize
          else begin
            if FMaxSplitSize>0
               then FAssociate.Width:=Min(p.X-FSize div 2-FAssociate.Left,FMaxSplitSize)
               else FAssociate.Width:=p.X-FSize div 2-FAssociate.Left;
          end;
        end;
        doResize;
      end;
      alRight:begin
        if p.X>FAssociate.Left+FAssociate.Width-FMinSplitSize div 2 then
          Snapped:=True
        else begin
          Snapped:=False;
          if p.X>FAssociate.Left+FAssociate.Width-FMinSplitSize-FSize div 2
          then  FAssociate.Width:=FMinSplitSize
          else begin
            if FMaxSplitSize>0
               then FAssociate.Width:=Min(-p.X+FAssociate.Left+FAssociate.Width-FSize div 2,FMaxSplitSize)
               else FAssociate.Width:=-p.X+FAssociate.Left+FAssociate.Width-FSize div 2;
          end;
        end;
        doResize;
      end;
      alTop:begin
        if p.Y<FAssociate.Top+FMinSplitSize div 2 then
          Snapped:=True
        else begin
          Snapped:=False;
          if p.Y<FAssociate.Top+FMinSplitSize+FSize div 2 then
            FAssociate.Height:=FMinSplitSize
          else begin
            if FMaxSplitSize>0
               then FAssociate.Height:=Min(p.Y-FSize div 2-FAssociate.Top,FMaxSplitSize)
               else FAssociate.Height:=p.Y-FSize div 2-FAssociate.Top;
          end;
        end;
        doResize;
      end;
      alBottom:begin
        if p.Y>FAssociate.Top+FAssociate.Height-FMinSplitSize div 2 then
          Snapped:=True
        else begin
          Snapped:=False;
          if p.Y>FAssociate.Top+FAssociate.Height-FMinSplitSize-FSize div 2 then
            FAssociate.Height:=FMinSplitSize
          else begin
            if FMaxSplitSize>0 then
              FAssociate.Height:=Min(-p.Y+FAssociate.Top+FAssociate.Height-FSize div 2,FMaxSplitSize)
            else
              FAssociate.Height:=-p.Y+FAssociate.Top+FAssociate.Height-FSize div 2;
          end;
        end;
        doResize;
      end;
    end;
  end else begin
    MouseOnSplitterButton:=PtInRect(GripRect,Point(X,Y));
    MouseOnSplitter:=PtInRect(ClientRect,Point(X,Y));
  end;
end;

procedure TGripSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if FMouseOnSplitterButton and FMouseSPlitterButtonDown then begin
    doResize;
    Snapped:=not Snapped;
  end;
  MouseSplitterDown:=False;
  MouseSplitterButtonDown:=False;
end;

procedure TGripSplitter.NewAssociateWindowProc(var Message: TMessage);
begin
  FOldAssociateWindowProc(Message);
  case Message.Msg of
    WM_WINDOWPOSCHANGED:UpdateAssociateState;
  end;
end;

procedure TGripSplitter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if AComponent=FAssociate then
    Associate:=nil;
  inherited;
end;

procedure TGripSplitter.Paint;
var
  r:TRect;
  e:Cardinal;

  function FrameRect:TRect;
  begin
    Result:=ClientRect;
    case Align of
      alLeft,alRight:begin
        Inc(Result.Left,1);
        Dec(Result.Right,1);
      end;
      alTop,alBottom:begin
        Inc(Result.Top,1);
        Dec(Result.Bottom,1);
      end;
    end;
  end;

  procedure PaintCaption;
  var X,Y : integer;
      texte : string;
      widthMax,largeur : integer;
  begin
     Canvas.Font.Name:='Segoe UI';
     Canvas.Font.Color := clBlack;
     widthMax := (gripRect.Bottom-gripRect.Top);
     Canvas.Font.Style:=[];//[fsBold];
     texte := Fcaption;
     Canvas.Brush.Style := bsClear;
     if vertical
        then begin
          Canvas.Font.Height := Width;
          Canvas.Font.Orientation := 900;
          X := -2;
          largeur := Canvas.TextWidth(texte);
          while largeur>widthMax do begin
                texte := copy(texte,1,length(texte)-1);
                largeur := Canvas.TextWidth(texte);
          end;
          texte := ' '+texte+' ';
          largeur := Canvas.TextWidth(texte);
          Y := (height+largeur) div 2;
        end
        else begin
          Canvas.Font.Height := Height;
          Canvas.Font.Orientation := 0;
          Y := 1;
          X := (width-Canvas.TextWidth(texte)) div 2;
        end;
     Canvas.TextOut(X,Y,texte);
     Canvas.Brush.Style := bsSolid;
  end;

  procedure PaintGripper;
  const
    U:array[False..True,alTop..alRight] of Cardinal=
      ((DFCS_SCROLLUP,DFCS_SCROLLDOWN,DFCS_SCROLLLEFT,DFCS_SCROLLRIGHT),
       (DFCS_SCROLLDOWN,DFCS_SCROLLUP,DFCS_SCROLLRIGHT,DFCS_SCROLLLEFT));
  begin
      r:=GripRect;
      e:=DFCS_PUSHED or DFCS_TRANSPARENT;
      if MouseOnSplitter then begin
        if MouseSplitterButtonDown
           then e:=e or DFCS_PUSHED
           else e:=e or DFCS_MONO
      end else e:=e or DFCS_FLAT;
      if not Enabled then e:=e or DFCS_INACTIVE;
      DrawFrameControl(Canvas.Handle,r,DFC_SCROLL,e or U[Snapped,Align]);
  end;

begin
  if not Transparent then begin
    Canvas.Brush.Color:=Color;
    Canvas.FillRect(FrameRect);
  end;
  if IsStateValid then begin
    PaintGripper;
    if Fcaption<>'' then PaintCaption;
  end;
end;

procedure TGripSplitter.SetAssociate(const Value: TControl);
begin
  if Assigned(FAssociate) then
    FAssociate.WindowProc:=FOldAssociateWindowProc;
  FAssociate := Value;
  if Assigned(FAssociate) then begin
    FAssociate.FreeNotification(Self);
    FOldAssociateWindowProc:=FAssociate.WindowProc;
    FAssociate.WindowProc:=NewAssociateWindowProc;
  end;
  UpdateAssociateState;
end;

procedure TGripSplitter.SetBeveled(const Value: Boolean);
begin
  if FBeveled xor Value then begin
    FBeveled := Value;
    Invalidate;
  end;
end;

procedure TGripSplitter.SetMaxSplitSize(Value: Integer);
begin
  if Value<0 then Value:=0;
  if FMaxSplitSize<>Value then begin
    FMaxSplitSize := Value;
    if (FMaxSplitSize<>0) and (FMinSplitSize>FMaxSplitSize) then
      FMinSplitSize:=FMaxSplitSize;
    UpdateAssociateState;
  end;
end;

procedure TGripSplitter.SetMinSplitSize(Value: Integer);
begin
  if Value<0 then Value:=0;
  if FMinSplitSize<>Value then begin
    FMinSplitSize := Value;
    if (FMaxSplitSize<>0) and (FMinSplitSize>FMaxSplitSize) then
      FMaxSplitSize:=FMinSplitSize;
    UpdateAssociateState;
  end;
end;

procedure TGripSplitter.SetMouseOnSplitter(const Value: Boolean);
var
  TME:TTrackMouseEvent;
begin
  if IsStateValid and (Value xor FMouseOnSplitter) then begin
    FMouseOnSplitter := Value;
    if Value then begin
      TME.cbSize:=SizeOf(TME);
      TME.dwFlags:=TME_LEAVE;
      TME.hwndTrack:=Handle;
      TME.dwHoverTime:=0;
      TrackMouseEvent(TME);
    end;
    Invalidate;
  end;
end;

procedure TGripSplitter.SetMouseOnSplitterButton(const Value: Boolean);
begin
  if IsStateValid and (Value xor FMouseOnSplitterButton) then begin
    FMouseOnSplitterButton := Value;
    Invalidate;
  end;
end;

procedure TGripSplitter.SetMouseSplitterButtonDown(const Value: Boolean);
begin
  if IsStateValid and (Value xor FMouseSplitterButtonDown) then begin
    FMouseSplitterButtonDown := Value;
    Invalidate;
  end;
end;

procedure TGripSplitter.SetMouseSplitterDown(const Value: Boolean);
var
  r:TRect;
begin
  if IsStateValid and (Value xor FMouseSplitterDown) then begin
    FMouseSplitterDown := Value;
    if Value then begin
      r:=Parent.ClientRect;
      r.TopLeft:=Parent.ClientToScreen(r.TopLeft);
      r.BottomRight:=Parent.ClientToScreen(r.BottomRight);
      ClipCursor(@r);
    end else
      ClipCursor(nil);
    Invalidate;
  end;
end;

procedure TGripSplitter.SetOnResize(const Value: TNotifyEvent);
begin
  FOnResize := Value;
end;

procedure TGripSplitter.SetSize(Value: Integer);
begin
  if Value<1 then Value:=1;
  if FSize<>Value then begin
    FSize := Value;
    UpdateAssociateState;
  end;
end;

procedure TGripSplitter.SetSizingCursor(const Value: TCursor);
begin
  if FSizingCursor<>Value then begin
    FSizingCursor := Value;
    FHSizingCursor:=Screen.Cursors[Value];
  end;
end;

procedure TGripSplitter.SetSnapped(const Value: Boolean);
begin
  if IsStateValid and (Value xor FSnapped) then begin
    FSnapped := Value;
    if Value then begin
      case Align of
        alLeft,alRight:begin
          FLastSplitterSize:=FAssociate.Width;
          FAssociate.Width:=0;
        end;
        alTop,alBottom:begin
          FLastSplitterSize:=FAssociate.Height;
          FAssociate.Height:=0;
        end;
      end;
    end else begin
      case Align of
        alLeft,alRight:FAssociate.Width:=Max(FLastSplitterSize,FMinSplitSize);
        alTop,alBottom:FAssociate.Height:=Max(FLastSplitterSize,FMinSplitSize);
      end;
      UpdateAssociateState;
    end;
    Invalidate;
  end else
    FSnapped := Value;
end;

procedure TGripSplitter.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;                            
  Invalidate;
end;

procedure TGripSplitter.SetUseThemes(const Value: Boolean);
begin
  FUseThemes := Value;
  Invalidate;
end;

procedure TGripSplitter.UpdateAssociateState;
begin
  if FUpdatingState then
    Exit;
  FUpdatingState:=True;
  if Assigned(FAssociate) and (FAssociate.Align in [alLeft,alTop,alBottom,alRight]) then begin
    if Parent<>FAssociate.Parent then
      Parent:=FAssociate.Parent;
    case FAssociate.Align of
      alTop:Top:=FAssociate.Top+FAssociate.Height;
      alBottom:Top:=FAssociate.Top-Height-1;
      alLeft:Left:=FAssociate.Left+FAssociate.Width;
      alRight:Left:=FAssociate.Left-Width-1;
    end;
    if Align<>FAssociate.Align then begin
      case FAssociate.Align of
        alLeft,alRight:SizingCursor:=crHSplit;
        alTop,alBottom:SizingCursor:=crVSplit;
      end;
      Align:=FAssociate.Align;
    end;
    if Vertical then begin
      Width:=FSize;
      if (FAssociate.Width<FMinSplitSize) and not Snapped then
        FAssociate.Width:=FMinSplitSize;
      if (FMaxSplitSize>0) and (FAssociate.Width>FMaxSplitSize) and not Snapped then
        FAssociate.Width:=FMaxSplitSize;
      if FSnapped and (FAssociate.Width<>0) then
        FAssociate.Width:=0;
    end else begin
      Height:=FSize;
      if (FAssociate.Height<FMinSplitSize) and not Snapped then
        FAssociate.Height:=FMinSplitSize;
      if (FMaxSplitSize>0) and (FAssociate.Height>FMaxSplitSize) and not Snapped then
        FAssociate.Height:=FMaxSplitSize;
      if FSnapped and (FAssociate.Height<>0) then
        FAssociate.Height:=0;
    end;
  end else begin
    Align:=alNone;
    FSnapped:=False;
    FMouseOnSplitter:=False;
    FMouseSplitterDown:=False;
    FMouseSplitterDown:=False;
    FMouseOnSplitterButton:=False;
    FMouseSplitterButtonDown:=False;
  end;
  FUpdatingState:=False;
end;

procedure TGripSplitter.WMMouseLeave(var Message: TMessage);
begin
  MouseOnSplitter:=False;
  MouseOnSplitterButton:=False;
end;

procedure TGripSplitter.WMSetCursor(var Message: TMessage);
begin
  if FMouseOnSplitterButton or not FMouseOnSplitter then
    inherited
  else begin
    Message.Result:=1;
    SetCursor(FHSizingCursor);
  end;
end;

procedure TGripSplitter.setCaption(const value : string);
begin
    Fcaption := value;
    invalidate;
end;

procedure TGripSplitter.WMWindowPosChanged(var Message: TMessage);
begin
  inherited;
  if IsStateValid and not FUpdatingState then begin
    if Vertical
       then FSize:=Width
       else FSize:=Height;
  end;
  UpdateAssociateState;
end;

procedure Register;
begin
  RegisterComponents('Supplément',[TGripSplitter]);
end;

end.
