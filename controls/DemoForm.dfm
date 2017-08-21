object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 506
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    684
    506)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TAutomatedStringGrid
    Left = 8
    Top = 8
    Width = 668
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goFixedRowClick]
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object AutomatedEdit1: TAutomatedEdit
    Left = 144
    Top = 408
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'AutomatedEdit1'
  end
  object Edit1: TEdit
    Left = 144
    Top = 435
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object ComboBox1: TComboBox
    Left = 368
    Top = 435
    Width = 145
    Height = 21
    TabOrder = 3
    Text = 'ComboBox1'
  end
  object AutomatedCombobox1: TAutomatedCombobox
    Left = 368
    Top = 408
    Width = 145
    Height = 21
    TabOrder = 4
    Text = 'AutomatedCombobox1'
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 384
    Top = 232
    object Hello1: TMenuItem
      Caption = 'Hello'
    end
    object here1: TMenuItem
      Caption = 'There'
    end
    object Everyyone1: TMenuItem
      Caption = 'Everyone'
    end
    object item1: TMenuItem
      Caption = '<item>'
    end
  end
end
