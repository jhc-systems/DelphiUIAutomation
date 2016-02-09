object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 590
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnCreate = FormCreate
  DesignSize = (
    650
    590)
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 96
    Top = 40
    Width = 217
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 96
    Top = 80
    Width = 217
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 157
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 238
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object PageControl1: TPageControl
    Left = 24
    Top = 174
    Width = 289
    Height = 193
    ActivePage = TabSheet2
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'First Tab'
      object Edit3: TEdit
        Left = 24
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit111'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Second Tab'
      ImageIndex = 1
      object Edit4: TEdit
        Left = 40
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit444'
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Last Tab'
      ImageIndex = 2
      object Edit5: TEdit
        Left = 40
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit3333'
      end
    end
  end
  object CheckBox1: TCheckBox
    Left = 28
    Top = 384
    Width = 97
    Height = 17
    Caption = 'First'
    TabOrder = 5
  end
  object CheckBox2: TCheckBox
    Left = 28
    Top = 407
    Width = 97
    Height = 17
    Caption = 'Second'
    TabOrder = 6
  end
  object RadioButton1: TRadioButton
    Left = 176
    Top = 384
    Width = 113
    Height = 17
    Caption = 'Radio 1'
    TabOrder = 7
  end
  object RadioButton2: TRadioButton
    Left = 176
    Top = 407
    Width = 113
    Height = 17
    Caption = 'Radio 1 Extra'
    TabOrder = 8
  end
  object RadioButton3: TRadioButton
    Left = 176
    Top = 430
    Width = 113
    Height = 17
    Caption = 'Radio 2'
    TabOrder = 9
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 571
    Width = 650
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Text = 'Statusbar Text'
        Width = 50
      end>
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 456
    Width = 285
    Height = 21
    TabOrder = 11
    Text = 'ComboBox1'
    Items.Strings = (
      'Premier'
      'Championship'
      'First'
      'Second'
      'Third'
      'Forth'
      'Beezer Conference')
  end
  object AutomatedEdit1: TAutomatedEdit
    Left = 24
    Top = 496
    Width = 121
    Height = 21
    TabOrder = 12
    Text = 'AutomatedEdit1'
  end
  object AutomatedCombobox1: TAutomatedCombobox
    Left = 24
    Top = 536
    Width = 145
    Height = 21
    TabOrder = 13
    Text = 'AutomatedCombobox1'
  end
  object AutomatedCombobox2: TAutomatedCombobox
    Left = 192
    Top = 536
    Width = 145
    Height = 21
    Style = csDropDownList
    TabOrder = 14
    Items.Strings = (
      'First'
      'Second'
      'Third')
  end
  object AutomationStringGrid1: TAutomationStringGrid
    Left = 328
    Top = 131
    Width = 313
    Height = 232
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 15
  end
  object AutomatedMaskEdit1: TAutomatedMaskEdit
    Left = 400
    Top = 456
    Width = 120
    Height = 21
    EditMask = '!99/99/00;1;_'
    MaxLength = 8
    TabOrder = 16
    Text = '  /  /  '
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Hel1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 112
    object PopupMenu2: TMenuItem
      Caption = 'Popup Menu '
      OnClick = PopupMenu2Click
    end
  end
end
