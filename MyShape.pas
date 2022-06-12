unit MyShape;

interface

Uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.UIConsts,
  System.Classes,
  System.Generics.Collections,
  System.math,

  Vcl.graphics,

  Controls, Forms, Dialogs, ExtCtrls;

type
 TstyleBorne  = (bsDebut, bsFin);

 TBorneShape = class(TShape)
 private
 FisSelected : boolean;
 protected
    procedure Paint; override;
    procedure setSelected(value : boolean);
 public
   style : TstyleBorne;
   IndexModele, IndexCourbe: integer;
   couleur : TAlphaColor;
   property isSelected : boolean read FisSelected write setSelected;
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
 end;

 const
      dimBorne = 8;

implementation

constructor TBorneShape.Create(AOwner: TComponent);
begin
  inherited;
  brush.style := bsSolid;
  pen.width := 3;
  Cursor := crHandPoint;
  couleur := claBlack;
  width := 2*dimBorne;
  height := 2*dimBorne;
end;

procedure TBorneShape.Paint;
var R : TrectF;
begin
   if FisSelected
      then begin
         brush.Color := clGray;
         pen.width := 5;
      end
      else begin
         brush.Color := couleur;
         pen.width := 3;
      end;
   R := TrectF.create(0,0,2*dimBorne,2*dimBorne);
   case style of
       bsDebut : shape := stRectangle;
       bsFin : shape := stEllipse;
   end;
end;

procedure TBorneShape.setSelected(value : boolean);
begin
    FisSelected := value;
    BringToFront; // optional
    repaint;
end;

destructor TBorneShape.destroy;
begin
    inherited;
end;

end.


