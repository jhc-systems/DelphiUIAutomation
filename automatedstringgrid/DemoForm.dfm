object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 445
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 351
    Top = 8
    Width = 325
    Height = 425
    Columns = <
      item
        Caption = '1st'
      end
      item
        Caption = '2nd'
      end
      item
        Caption = '3rd'
      end
      item
        Caption = '4th'
      end>
    Items.ItemData = {
      05E50000000600000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
      0005460069007200730074000331002F003100302E430600000000FFFFFFFFFF
      FFFFFF00000000FFFFFFFF00000000065300650063006F006E00640000000000
      FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000055400680069007200640000
      000000FFFFFFFFFFFFFFFF00000000FFFFFFFF000000000546006F0072007400
      680000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000054600690066
      007400680000000000FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000044C00
      610073007400FFFF}
    TabOrder = 0
    ViewStyle = vsReport
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 337
    Height = 425
    TabOrder = 1
    OnDblClick = StringGrid1DblClick
  end
end
