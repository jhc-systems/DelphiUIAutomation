{***************************************************************************}
{                                                                           }
{           DelphiUIAutomation                                              }
{                                                                           }
{                                                                           }
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
unit DelphiUIAutomation.TabItem;

interface

uses
  DelphiUIAutomation.Base,
  UIAutomationClient_TLB;

type
  /// <summary>
  ///  Represents a tab item
  /// </summary>
  TAutomationTabItem = class (TAutomationBase)
  public
    /// <summary>
    ///  Selects this tabitem
    /// </summary>
    procedure Select;

    /// <summary>
    ///  Prints out the child controls
    /// </summary>
    /// <remarks>
    ///  For debugging only
    /// </remarks>
    procedure ListControlsAndStuff(element : IUIAutomationElement); deprecated;
  end;

implementation

uses
  DelphiUIAutomation.Automation,
  DelphiUIAutomation.PatternIDs;

{ TAutomationTabItem }

procedure TAutomationTabItem.ListControlsAndStuff(
  element: IUIAutomationElement);
var
  collection : IUIAutomationElementArray;
  condition : IUIAutomationCondition;
  count : integer;
  name, help : widestring;
  length : integer;
  retVal : integer;

begin
  UIAuto.CreateTrueCondition(condition);

  if (element = nil) then
    element := self.FElement;

  // Find the element
  element.FindAll(TreeScope_Descendants, condition, collection);

  collection.Get_Length(length);

  for count := 0 to length -1 do
  begin
    collection.GetElement(count, element);

    element.Get_CurrentName(name);
    element.Get_CurrentControlType(retVal);
    element.Get_CurrentHelpText(help);

    Write(name + ' - ');
    Write(retval);
    Writeln(' - ' + help);

//    if retval = UIA_PaneControlTypeId then
//    begin
//      writeln('Looking at children');
//      ListControlsAndStuff(element);
 //   end;
  end;
end;

procedure TAutomationTabItem.Select;
var
  unknown: IInterface;
  Pattern  : IUIAutomationInvokePattern;

begin
  fElement.GetCurrentPattern(UIA_SelectionItemPatternID, unknown);

  if (unknown <> nil) then
  begin
    if unknown.QueryInterface(IUIAutomationSelectionItemPattern, Pattern) = S_OK then
    begin
      Pattern.Invoke;
    end;
  end;
end;

end.
