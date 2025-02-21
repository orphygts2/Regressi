unit cursdata;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ImgList, ExtCtrls, ComCtrls,
  vcl.HtmlHelpViewer,
  regutil, compile, graphker, aidekey, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TReticuleDataDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Curseur1GB: TComboBox;
    Curseur2GB: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    OptionsGB: TGroupBox;
    PenteCB: TCheckBox;
    YCB: TCheckBox;
    XCB: TCheckBox;
    DeltaXCB: TCheckBox;
    ReticuleCB: TCheckBox;
    deltaYCB: TCheckBox;
    TangenteColor: TColorBox;
    LigneCombo: TComboBoxEx;
    DeuxCurseursCB: TCheckBox;
    GridCB: TCheckBox;
    ImageCollection2: TImageCollection;
    VirtualImageList2: TVirtualImageList;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure DeuxCurseursCBClick(Sender: TObject);
  private
     ListeVar : TstringList;
  public
     Agraphe : TgrapheReg;
  end;

var
  ReticuleDataDlg: TReticuleDataDlg;

implementation

{$R *.DFM}

procedure TReticuleDataDlg.FormActivate(Sender: TObject);
var i : integer;
    index1,index2 : integer;
begin
    inherited;
    ReticuleCB.checked := ReticuleComplet;
    TangenteColor.selected := pColorReticule;
    LigneCombo.itemIndex := ord(PstyleReticule);
    gridCB.Checked := avecTableau;
    ListeVar.Clear;
    for i := 1 to maxOrdonnee do with Agraphe do
        if Coordonnee[i].nomY<>'' then ListeVar.add(Coordonnee[i].nomY);
    with Agraphe do begin
        if curseurOsc[curseurData1].grandeurCurseur=nil
           then index1 := -1
           else index1 := listeVar.indexOf(curseurOsc[curseurData1].grandeurCurseur.nom);
        if curseurOsc[curseurData2].grandeurCurseur=nil
           then index2 := -1
           else index2:= listeVar.indexOf(curseurOsc[curseurData2].grandeurCurseur.nom);
        if index1<0 then index1 := listeVar.indexOf(Coordonnee[1].nomY);
        if index1<0 then index1 := 0;
        DeuxCurseursCB.checked := index2>=0;
        if index2<0 then index2 := index1;
        penteCB.checked := coPente in agraphe.optionCurseur;
        deltaXCB.checked := coDeltaX in agraphe.optionCurseur;
        deltaYCB.checked := coDeltaY in agraphe.optionCurseur;
        XCB.checked := coX in agraphe.optionCurseur;
        YCB.checked := coY in agraphe.optionCurseur;
        DeuxCurseursCBClick(nil);
    end;
    Curseur1GB.items := listeVar;
    Curseur1GB.itemIndex := index1;
    Curseur2GB.items := listeVar;
    Curseur2GB.itemIndex := index2;
end;

procedure TReticuleDataDlg.FormCreate(Sender: TObject);
begin
    ListeVar := TstringList.create;
    VirtualImageList2.height := VirtualImageListSize;
    VirtualImageList2.width := VirtualImageListSize;
end;

procedure TReticuleDataDlg.FormDestroy(Sender: TObject);
begin
     ListeVar.free;
     inherited
end;

procedure TReticuleDataDlg.OKBtnClick(Sender: TObject);
var index : integer;
    deuxPermis : boolean;
begin with Agraphe do begin
      avecTableau := gridCB.Checked;
      PstyleReticule := TpenStyle(LigneCombo.itemIndex);
      index := indexNom(curseur1GB.text);
      if index<>grandeurInconnue
         then CurseurOsc[curseurData1].grandeurCurseur := grandeurs[index]
         else begin
            CurseurOsc[curseurData1].grandeurCurseur := nil;
            curseurOsc[curseurData1].mondeC := mondeX;
         end;
      if DeuxCurseursCB.Checked
        then begin
           index := indexNom(curseur2GB.text);
           if index<>grandeurInconnue
              then CurseurOsc[curseurData2].grandeurCurseur := grandeurs[index]
        end
        else index := grandeurInconnue;
      if index=grandeurInconnue then begin
          CurseurOsc[curseurData2].grandeurCurseur := nil;
          curseurOsc[curseurData2].mondeC := mondeX;
      end;
      agraphe.optionCurseur := [];
      pColorReticule := TangenteColor.selected;
      if XCB.checked then include(agraphe.optionCurseur,coX);
      if YCB.checked then include(agraphe.optionCurseur,coY);
      DeuxPermis := DeuxCurseursCB.checked and 
             (CurseurOsc[curseurData2].grandeurCurseur<>nil) and
             (CurseurOsc[curseurData1].grandeurCurseur<>nil);
      if deltaXCB.checked and DeuxPermis then include(optionCurseur,coDeltaX);
      DeuxPermis := DeuxPermis and
             (CurseurOsc[curseurData2].grandeurCurseur.nomUnite=CurseurOsc[curseurData1].grandeurCurseur.nomUnite);
      if penteCB.checked and DeuxPermis then include(optionCurseur,coPente);
      if deltaYCB.checked and DeuxPermis then include(optionCurseur,coDeltaY);
      ReticuleComplet := ReticuleCB.checked;
      if  (CurseurOsc[curseurData1].grandeurCurseur=nil) and
          (CurseurOsc[curseurData2].grandeurCurseur<>nil) then begin
              CurseurOsc[curseurData1].grandeurCurseur := CurseurOsc[curseurData2].grandeurCurseur;
              CurseurOsc[curseurData2].grandeurCurseur := nil;
      end;
      if  (CurseurOsc[curseurData1].grandeurCurseur=nil) and
          (CurseurOsc[curseurData2].grandeurCurseur=nil) then modalResult := mrCancel;
end end;

procedure TReticuleDataDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_OutilsGraphiques)
end;

procedure TReticuleDataDlg.DeuxCurseursCBClick(Sender: TObject);
begin
      Label2.Visible := DeuxCurseursCB.checked;
      Curseur2GB.Visible := DeuxCurseursCB.checked;
      penteCB.visible := DeuxCurseursCB.checked;
      deltaXCB.visible := DeuxCurseursCB.checked;
      deltaYCB.visible := DeuxCurseursCB.checked;
end;

end.
