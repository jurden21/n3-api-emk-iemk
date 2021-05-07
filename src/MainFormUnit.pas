unit MainFormUnit;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
    TMainForm = class(TForm)
        RequestMemo: TMemo;
        ResponseMemo: TMemo;
        ServiceGuidEdit: TEdit;
        LpuGuidEdit: TEdit;
        ServiceGuidLabel: TLabel;
        LpuGuidLabel: TLabel;
        CreateCaseButton: TBitBtn;
        AddStepToCaseButton: TBitBtn;
        MedRecordComboBox: TComboBox;
        AddMedRecordButton: TBitBtn;
    StepComboBox: TComboBox;
    CaseComboBox: TComboBox;
        procedure ProcessEventHandler(Sender: TObject);
    private
        procedure AddMedRecordMethodHandler;
        procedure AddStepToCaseMethodHandler;
        procedure CreateCaseMethodHandler;
    public
    end;

var
    MainForm: TMainForm;

implementation

{$R *.dfm}

uses XmlWriterUnit, CreateCaseMethodUnit, CaseBaseUnit, CaseStatUnit, CaseAmbUnit, MedicalStaffUnit, PersonUnit, GuardianUnit,
     ParticipantUnit, StepStatUnit, StepBaseUnit, StepAmbUnit, AddStepToCaseMethodUnit, AllergyUnit, AppointedMedicationUnit, MedRecordUnit,
  AddMedRecordMethodUnit, ServiceUnit, TfomsUnit, DeathInfoUnit, DiagnosisUnit, ImmunizeUnit, ProcedureUnit, SocialAnamnesisUnit,
  MedDocumentUnit, DispensaryUnit, Form027UUnit, ReferralUnit, SickListUnit, NonDrugTreatmentUnit, ResInstrUnit, ScoresUnit, SurgeryUnit;

procedure TMainForm.ProcessEventHandler(Sender: TObject);
begin
    if (Sender is TBitBtn)
    then begin
        if (Sender as TBitBtn) = AddMedRecordButton
        then AddMedRecordMethodHandler;
        if (Sender as TBitBtn) = AddStepToCaseButton
        then AddStepToCaseMethodHandler;
        if (Sender as TBitBtn) = CreateCaseButton
        then CreateCaseMethodHandler;
    end;
end;

procedure TMainForm.AddMedRecordMethodHandler;
var
    MedRecord: TMedRecordObject;
    Method: TAddMedRecordMethod;
    Text: TStringList;
begin
    MedRecord := nil;

    if MedRecordComboBox.Text = 'AllergyDrug'
    then
        MedRecord := TAllergyDrugObject.Create(
            TAllergyBaseObject.Create(1, 'Comment1', EncodeDate(2000, 1, 1), 1), 1);

    if MedRecordComboBox.Text = 'AllergyNonDrug'
    then MedRecord := TAllergyNonDrugObject.Create(
            TAllergyBaseObject.Create(2, 'Comment2', EncodeDate(2000, 2, 2), 200), 'Description');

    if MedRecordComboBox.Text = 'AppointedMedication'
    then
        MedRecord := TAppointedMedicationObject.Create(
            'ATC', TQuantityObject.Create(1, 10), TQuantityObject.Create(2, 20), 3,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            EncodeDate(1991, 1, 1), 'MedicineIssueType', 'MedicineName', 4, 5, 'Number', TQuantityObject.Create(3, 30), 6, 'Seria');

    if MedRecordComboBox.Text = 'ConsultNote'
    then
        MedRecord := TConsultNoteObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header');

    if MedRecordComboBox.Text = 'DeathInfo'
    then
        MedRecord := TDeathInfoObject.Create('M00');

    if MedRecordComboBox.Text = 'DischargeSummary'
    then
        MedRecord := TDischargeSummaryObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header');

    if MedRecordComboBox.Text = 'DispensaryOne'
    then
        MedRecord := TDispensaryOneObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header', True, False, True, False, True, False, True,
            THealthGroupInfoObject.Create(EncodeDate(2010, 5, 7), 456));

    if MedRecordComboBox.Text = 'Form027U'
    then
        MedRecord := TForm027UObject.Create(
            EncodeDate(2006, 1, 1), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header', 'IssuingInstitution', 'TargetMU', EncodeDate(2010, 1, 1), EncodeDate(2011, 1, 1), 100, 101, 102, '', '', 0, 0, '',
            '', '', 0, '', 0, '', EncodeDate(2010, 1, 1), 0, '', 0, '', '', 0, 0, '', EncodeDate(2010, 1, 1), 0, '', '', EncodeDate(2010, 1, 1),
            0, '', '', '', '', '');

    if MedRecordComboBox.Text = 'Immunize'
    then
        MedRecord := TImmunizeObject.Create(EncodeDate(2002, 5, 5), 10001);

    if MedRecordComboBox.Text = 'LaboratoryReport'
    then
        MedRecord := TLaboratoryReportObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header');

    if MedRecordComboBox.Text = 'NonDrugTreatment'
    then
        MedRecord := TNonDrugTreatmentObject.Create('Name', 'Scheme', EncodeDate(2001, 1, 1), EncodeDate(2002, 1, 1));

    if MedRecordComboBox.Text = 'Procedure'
    then
        MedRecord := TProcedureObject.Create('ProcedureCode', EncodeDate(2004, 1, 6),
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')));

    if MedRecordComboBox.Text = 'Referral'
    then
        MedRecord := TReferralObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header',
            TReferralInfoObject.Create('Reason', 'IdReferralMis', 1, EncodeDate(2011, 3, 3), 1, 'M00'),
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            LpuGuidEdit.Text, LpuGuidEdit.Text, 'ReferralId', 'RelatedId');

    if MedRecordComboBox.Text = 'ResInstr'
    then
        MedRecord := TResInstrObject.Create(
            EncodeDate(2001, 1, 1), 2, 3, 'Text',
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')));

    if MedRecordComboBox.Text = 'Scores'
    then
        MedRecord := TScoresObject.Create(EncodeDate(2001, 1, 1), 'Scale', 'Data');

    if MedRecordComboBox.Text = 'Service'
    then
        MedRecord := TServiceObject.Create(
            EncodeDate(2012, 11, 1), EncodeDate(2002, 11, 10), 'A01.01.001.001', 'Название услуги',
            TPaymentInfoObject.Create(1, 1, 1, 1, 1000),
            TParticipantObject.Create(3, TMedicalStaffObject.Create(LpuGuidEdit.Text, 29, 74, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPatientMis: uzbafjfyvm'))));

    if MedRecordComboBox.Text = 'SickList'
    then
        MedRecord := TSickListObject.Create(
            EncodeDate(2006, 5, 6), 'IdDocumentMis',
            nil,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'Header',
            TSickListInfoObject.Create(
                'Number', EncodeDate(2000, 1, 1), EncodeDate(2001, 1, 1),
                TGuardianObject.Create(1, 'UnderlyingDocument', TPersonObject.Create('GN2', 'MN2', 'FN2', 1, EncodeDate(1970, 1, 1), 'IdPersonMis')),
                123, 124, False));

    if MedRecordComboBox.Text = 'SocialAnamnesis'
    then
        MedRecord := TSocialAnamnesisObject.Create(
            TDisabilityObject.Create(1, EncodeDate(2006, 7, 7), 1), 1, TSocialGroupObject.Create(1, 'SocialGroupText'));

    if MedRecordComboBox.Text = 'Surgery'
    then
        MedRecord := TSurgeryObject.Create(
            'Code', EncodeDate(2001, 1, 1),
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')));

    if MedRecordComboBox.Text = 'TfomsInfo'
    then
        MedRecord := TTfomsObject.Create(1, '211010', 100);

    Method := TAddMedRecordMethod.Create(ServiceGuidEdit.Text, LpuGuidEdit.Text, 'IdPatientMis: uzbafjfyvm', 'IdCaseMis: abcdef', MedRecord);

    Text := TStringList.Create;
    try

        Method.Execute;

        Method.RequestStream.SaveToFile('.\AddMedRecord_' + MedRecordComboBox.Text + '_request.xml');
        RequestMemo.Lines.LoadFromFile('.\AddMedRecord_' + MedRecordComboBox.Text + '_request.xml');
        Method.ResponseStream.SaveToFile('.\AddMedRecord_' + MedRecordComboBox.Text + '_response.xml');
        ResponseMemo.Lines.LoadFromFile('.\AddMedRecord_' + MedRecordComboBox.Text + '_response.xml');

    finally
        Method.Free;
        Text.Free;
    end;

end;

procedure TMainForm.AddStepToCaseMethodHandler;
var
    Step: TStepBaseObject;
    Method: TAddStepToCaseMethod;
    Text: TStringList;
begin

    Step := nil;

    if StepComboBox.Text = 'Amb'
    then begin
        Step := TStepAmbObject.Create(
            EncodeDate(2002, 1, 1), EncodeDate(2002, 3, 3), 'StepComment', 1,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'IdStepMis200', 31, 32);

        (Step as TStepAmbObject).AddMedRecord(
            TAppointedMedicationObject.Create(
                'ATC', TQuantityObject.Create(1, 10), TQuantityObject.Create(2, 20), 3,
                 TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
                 EncodeDate(1991, 1, 1), 'MedicineIssueType', 'MedicineName', 4, 5, 'Number', TQuantityObject.Create(3, 30), 6, 'Seria'));
    end;

    if StepComboBox.Text = 'Stat'
    then begin
        Step := TStepStatObject.Create(
            EncodeDate(2002, 1, 1), EncodeDate(2002, 3, 3), 'StepComment', 1,
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            'IdStepMis200', 'HospitalDepartmentName200', 'IdHospitalDepartment200', 3, 'WardNumber200', 'BedNumber200', 1, 30);

        (Step as TStepStatObject).AddMedRecord(
            TAllergyDrugObject.Create(TAllergyBaseObject.Create(1, 'Comment1', EncodeDate(1990, 1, 1), 2), 3));
        (Step as TStepStatObject).AddMedRecord(
            TAllergyNonDrugObject.Create(TAllergyBaseObject.Create(2, 'Comment2', EncodeDate(1991, 2, 2), 4), 'Description'));
    end;

    Method := TAddStepToCaseMethod.Create(ServiceGuidEdit.Text, LpuGuidEdit.Text, 'IdPatientMis: uzbafjfyvm', 'IdCaseMis: abcdef', Step);

    Text := TStringList.Create;
    try

        Method.Execute;

        Method.RequestStream.SaveToFile('.\AddStepToCase_' + StepComboBox.Text + '_request.xml');
        RequestMemo.Lines.LoadFromFile('.\AddStepToCase_' + StepComboBox.Text + '_request.xml');
        Method.ResponseStream.SaveToFile('.\AddStepToCase_' + StepComboBox.Text + '_response.xml');
        ResponseMemo.Lines.LoadFromFile('.\AddStepToCase_' + StepComboBox.Text + '_response.xml');

    finally
        Method.Free;
        Text.Free;
    end;

end;

procedure TMainForm.CreateCaseMethodHandler;
var
    Casee: TCaseBaseObject;
    Method: TCreateCaseMethod;
    Text: TStringList;
begin

    Casee := nil;

    if CaseComboBox.Text = 'Stat'
    then begin

        Casee := TCaseStatObject.Create(
            EncodeDate(2001, 1, 1), EncodeDate(2002, 1, 1), 'HistoryNumber', 'IdCaseMis: abcdef', 1, 2, 3, 3, 3, LpuGuidEdit.Text, 6, 'Comment',
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29,TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            TParticipantObject.Create(2, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN2', 'MN2', 'FN2', 1, EncodeDate(1990, 2, 2), 'IdPersonMis2'))),
            TParticipantObject.Create(3, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN3', 'MN3', 'FN3', 1, EncodeDate(1990, 2, 2), 'IdPersonMis3'))),
            TParticipantObject.Create(4, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN4', 'MN4', 'FN4', 1, EncodeDate(1990, 2, 2), 'IdPersonMis4'))),
            TGuardianObject.Create(1, 'UnderlyingDocument1', TPersonObject.Create('GN5', 'MN5', 'FN5', 1, EncodeDate(1990, 2, 2), 'IdPersonMis5')),
            'IdPatientMis: uzbafjfyvm', 'DeliveryCode', 1, 1, 1, 1, 1, 1, 1, 1, False, False, 'AdmissionComment', 15, 'DischargeComment',
            'DietComment', 'TreatComment', 'WorkComment', 'OtherComment');

        (Casee as TCaseStatObject).AddStep(
            TStepStatObject.Create(EncodeDate(2012, 1, 1), EncodeDate(2012, 2, 2), 'Comment', 1,
                TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
                'IdStepMis100', 'HospitalDepartmentName', 'IdHospitalDepartment', 1, 'WardNumber', 'BedNumber', 12, 12));
    end;

    if CaseComboBox.Text = 'Amb'
    then begin

        Casee := TCaseAmbObject.Create(
            EncodeDate(2001, 1, 1), EncodeDate(2002, 1, 1), 'HistoryNumber', 'IdCaseMis: abcdef', 1, 2, 3, 3, 3, LpuGuidEdit.Text, 6, 'Comment',
            TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29,TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
            TParticipantObject.Create(2, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN2', 'MN2', 'FN2', 1, EncodeDate(1990, 2, 2), 'IdPersonMis2'))),
            TParticipantObject.Create(3, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN3', 'MN3', 'FN3', 1, EncodeDate(1990, 2, 2), 'IdPersonMis3'))),
            TParticipantObject.Create(4, TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN4', 'MN4', 'FN4', 1, EncodeDate(1990, 2, 2), 'IdPersonMis4'))),
            TGuardianObject.Create(1, 'UnderlyingDocument1', TPersonObject.Create('GN5', 'MN5', 'FN5', 1, EncodeDate(1990, 2, 2), 'IdPersonMis5')),
            'IdPatientMis: uzbafjfyvm', 1, 1, 1, True, 1);

        (Casee as TCaseAmbObject).AddStep(
            TStepAmbObject.Create(EncodeDate(2012, 1, 1), EncodeDate(2012, 2, 2), 'Comment', 1,
                TMedicalStaffObject.Create(LpuGuidEdit.Text, 1, 29, TPersonObject.Create('GN1', 'MN1', 'FN1', 1, EncodeDate(1990, 2, 2), 'IdPersonMis1')),
                'IdStepMis100', 1, 1));
    end;

    Method := TCreateCaseMethod.Create(ServiceGuidEdit.Text, LpuGuidEdit.Text, Casee);

    Text := TStringList.Create;
    try

        Method.Execute;

        Method.RequestStream.SaveToFile('.\CreateCase_' + CaseComboBox.Text + '_request.xml');
        RequestMemo.Lines.LoadFromFile('.\CreateCase_' + CaseComboBox.Text + '_request.xml');
        Method.ResponseStream.SaveToFile('.\CreateCase_' + CaseComboBox.Text + '_response.xml');
        ResponseMemo.Lines.LoadFromFile('.\CreateCase_' + CaseComboBox.Text + '_response.xml');

    finally
        Method.Free;
        Text.Free;
    end;

end;

end.
