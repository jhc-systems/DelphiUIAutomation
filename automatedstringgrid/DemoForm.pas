unit DemoForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ComCtrls,
  Vcl.DBGrids, Vcl.DBCGrids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Buttons, AutomatedStringGrid;

type
  TForm2 = class(TForm)
    StringGrid1: TAutomationStringGrid;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses
  // all for testing
  ActiveX,
  UIAutomationCore_TLB,
  StringGridRow;

{$R *.dfm}

type
  TTest = class(TInterfacedObject, IUnknown)

  end;

procedure TForm2.Button1Click(Sender: TObject);
var
//buffer : array of IRawElementProviderSimple;
  region_arr : variant;
//  intf : TAutomationStringGridItem;
  outBuffer : PSafeArray;
  offset : integer;
  unk : IUnknown;
  iRow, iCol : integer;
  Bounds : TVarArrayBoundArray;
  result : HResult;
//  intf: IRawElementProviderSimple;

begin
  iRow := 1;
  iCol := 1;

  // is a cell selected?
  if (iRow > -1) and (iCol > -1) then
  begin
    unk := TTest.create;

    Bounds[0].LowBound:=0;
    Bounds[0].ElementCount:=1;

    outBuffer := SafeArrayCreateVector(VT_UNKNOWN, 0, 1);

    if unk <> nil then
    begin
      offset := 0;
      Result := SafeArrayPutElement(outBuffer, offset, PUnknown(unk)^);
      if Result <> S_OK then
      begin
        SafeArrayDestroy(outBuffer);
    //    pRetVal := nil;
        result := E_OUTOFMEMORY;
      end
      else
      begin
      //  pRetVal := outBuffer;
        result := S_OK;
      end;
    end;
  end
  else
  begin
   // pRetVal := nil;
    result := S_FALSE;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 10;
  StringGrid1.RowCount := 6;

  StringGrid1.Cells[0,0] := 'Top Left';
  StringGrid1.Cells[1,0] := 'First';
  StringGrid1.Cells[2,0] := 'Second';
  StringGrid1.Cells[3,0] := 'Third';
  StringGrid1.Cells[4,0] := 'Forth';
  StringGrid1.Cells[5,0] := '5th';
  StringGrid1.Cells[6,0] := 'Thith';
  StringGrid1.Cells[7,0] := '7th';
  StringGrid1.Cells[8,0] := '8th';
  StringGrid1.Cells[9,0] := 'Last';

    StringGrid1.Cells[1,1] := 'Hello11';
    StringGrid1.Cells[1,3] := 'Hello13';
    StringGrid1.Cells[3,3] := 'Hello33';
    StringGrid1.Cells[3,4] := 'Hello34';
    StringGrid1.Cells[2,4] := 'Hello24';
    StringGrid1.Cells[2,9] := 'Hello24';
end;

procedure TForm2.StringGrid1DblClick(Sender: TObject);
begin
  ShowMessage(StringGrid1.Cells[StringGrid1.Col, StringGrid1.row]);
end;

end.

