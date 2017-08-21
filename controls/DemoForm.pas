unit DemoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ComCtrls,
  Vcl.DBGrids, Vcl.DBCGrids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, AutomatedStringGrid, AutomatedEdit, AutomatedCombobox;

type
  TForm2 = class(TForm)
    StringGrid1: TAutomatedStringGrid;
    PopupMenu1: TPopupMenu;
    Hello1: TMenuItem;
    here1: TMenuItem;
    Everyyone1: TMenuItem;
    item1: TMenuItem;
    AutomatedEdit1: TAutomatedEdit;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    AutomatedCombobox1: TAutomatedCombobox;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
     { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 10;
  StringGrid1.RowCount := 6;

//  StringGrid1.Cells[0, 0] := 'Top Left';
//StringGrid1.cell
  StringGrid1.Cells[1, 0] := 'First';
  StringGrid1.Cells[2, 0] := 'Second';
  StringGrid1.Cells[3, 0] := 'Third';
  StringGrid1.Cells[4, 0] := 'Forth';
  StringGrid1.Cells[5, 0] := '5th';
  StringGrid1.Cells[6, 0] := 'Thith';
  StringGrid1.Cells[7, 0] := '7th';
  StringGrid1.Cells[8, 0] := '8th';
  StringGrid1.Cells[9, 0] := 'Last';

  StringGrid1.Cells[1, 1] := 'Hello11';
  StringGrid1.Cells[1, 3] := 'Hello13';
  StringGrid1.Cells[3, 3] := 'Hello33';
  StringGrid1.Cells[3, 4] := 'Hello34';
  StringGrid1.Cells[2, 4] := 'Hello24';
  StringGrid1.Cells[2, 9] := 'Hello29';
end;

procedure TForm2.PopupMenu1Popup(Sender: TObject);
begin
  item1.caption := 'Cell : ' + IntToStr(StringGrid1.Row) + IntToStr(StringGrid1.Col);
end;

procedure TForm2.StringGrid1DblClick(Sender: TObject);
begin
  ShowMessage(StringGrid1.Cells[StringGrid1.Row, StringGrid1.Col]);
end;

end.
