{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{           Copyright 2015 JHC Systems Limited                              }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}
unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Menus,
  AutomatedCombobox, AutomatedEdit, Vcl.Grids, AutomatedStringGrid, Vcl.Mask,
  AutomatedMaskEdit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    StatusBar1: TStatusBar;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Hel1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TMenuItem;
    AutomatedEdit1: TAutomatedEdit;
    AutomatedCombobox1: TAutomatedCombobox;
    AutomatedCombobox2: TAutomatedCombobox;
    AutomationStringGrid1: TAutomationStringGrid;
    AutomatedMaskEdit1: TAutomatedMaskEdit;
    RichEdit1: TRichEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure PopupMenu2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage (edit1.Text + ' | ' + edit2.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowMessage ('Cancelled');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  ShowMessage('Oh well done');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AutomationStringGrid1.Cells[0,0] := 'Title 1';
  AutomationStringGrid1.Cells[1,0] := 'Title 2';
  AutomationStringGrid1.Cells[2,0] := 'Title 3';
  AutomationStringGrid1.Cells[3,0] := 'Title 4';
  AutomationStringGrid1.Cells[4,0] := 'Title 5';

  AutomationStringGrid1.Cells[0,1] := 'Row 1, Col 0';
  AutomationStringGrid1.Cells[1,1] := 'Row 1, Col 1';
  AutomationStringGrid1.Cells[2,1] := 'Row 1, Col 2';
  AutomationStringGrid1.Cells[3,1] := 'Row 1, Col 3';
  AutomationStringGrid1.Cells[4,1] := 'Row 1, Col 4';

  AutomationStringGrid1.Cells[0,3] := 'Row 3, Col 0';
  AutomationStringGrid1.Cells[1,3] := 'Row 3, Col 1';
  AutomationStringGrid1.Cells[2,3] := 'Row 3, Col 2';
  AutomationStringGrid1.Cells[3,3] := 'Row 3, Col 3';
  AutomationStringGrid1.Cells[4,3] := 'Row 3, Col 4';

end;

procedure TForm1.PopupMenu2Click(Sender: TObject);
begin
  ShowMessage ('Popup menu clicked');
end;

end.
