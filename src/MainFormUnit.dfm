object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 667
  ClientWidth = 1036
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ServiceGuidLabel: TLabel
    Left = 8
    Top = 12
    Width = 65
    Height = 13
    Caption = 'Service GUID'
  end
  object LpuGuidLabel: TLabel
    Left = 8
    Top = 32
    Width = 49
    Height = 13
    Caption = 'LPU GUID'
  end
  object RequestMemo: TMemo
    Left = 188
    Top = 56
    Width = 841
    Height = 417
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ResponseMemo: TMemo
    Left = 192
    Top = 480
    Width = 841
    Height = 181
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ServiceGuidEdit: TEdit
    Left = 188
    Top = 4
    Width = 841
    Height = 21
    TabOrder = 2
  end
  object LpuGuidEdit: TEdit
    Left = 188
    Top = 28
    Width = 841
    Height = 21
    TabOrder = 3
  end
  object CreateCaseButton: TBitBtn
    Left = 4
    Top = 196
    Width = 177
    Height = 25
    Caption = 'CreateCase'
    TabOrder = 4
    OnClick = ProcessEventHandler
  end
  object AddStepToCaseButton: TBitBtn
    Left = 4
    Top = 140
    Width = 177
    Height = 25
    Caption = 'AddStepToCase'
    TabOrder = 5
    OnClick = ProcessEventHandler
  end
  object MedRecordComboBox: TComboBox
    Left = 4
    Top = 56
    Width = 177
    Height = 21
    Style = csDropDownList
    DropDownCount = 30
    ItemIndex = 0
    TabOrder = 6
    Text = 'AllergyDrug'
    Items.Strings = (
      'AllergyDrug'
      'AllergyNonDrug'
      'AppointedMedication'
      'ConsultNote'
      'DeathInfo'
      'DischargeSummary'
      'DispensaryOne'
      'Form027U'
      'Immunize'
      'LaboratoryReport'
      'NonDrugTreatment'
      'Procedure'
      'Referral'
      'ResInstr'
      'Scores'
      'Service'
      'SickList'
      'SocialAnamnesis'
      'Surgery'
      'TfomsInfo')
  end
  object AddMedRecordButton: TBitBtn
    Left = 4
    Top = 80
    Width = 177
    Height = 25
    Caption = 'AddMedRecord'
    TabOrder = 7
    OnClick = ProcessEventHandler
  end
  object StepComboBox: TComboBox
    Left = 4
    Top = 116
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = 'Stat'
    Items.Strings = (
      'Stat'
      'Amb')
  end
  object CaseComboBox: TComboBox
    Left = 4
    Top = 172
    Width = 177
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 9
    Text = 'Stat'
    Items.Strings = (
      'Stat'
      'Amb')
  end
end
