object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Delphi Keystone'
  ClientHeight = 496
  ClientWidth = 985
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 17
  object Splitter1: TSplitter
    Left = 353
    Top = 41
    Width = 8
    Height = 455
    ExplicitLeft = 369
    ExplicitHeight = 608
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 985
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    ExplicitWidth = 981
    object Label1: TLabel
      Left = 346
      Top = 12
      Width = 48
      Height = 17
      Caption = 'Address'
    end
    object Button1: TButton
      Left = 16
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Method 1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 97
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Method 2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Edit1: TEdit
      Left = 402
      Top = 9
      Width = 121
      Height = 25
      TabOrder = 2
      Text = '1000'
    end
    object Button3: TButton
      Left = 178
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Method 3'
      TabOrder = 3
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 259
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Method 4'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 353
    Height = 455
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'MOV             X0, X26'
      'MOV             X4, X24'
      'MOV             X5, X25'
      'MOV             X6, X21'
      'MOV             X7, X23'
      'BL                #0x2c')
    ParentFont = False
    TabOrder = 1
    ExplicitHeight = 454
  end
  object Memo2: TMemo
    Left = 361
    Top = 41
    Width = 624
    Height = 455
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 620
    ExplicitHeight = 454
  end
end
