program N3APIEmk;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  XmlWriterUnit in 'services\XmlWriterUnit.pas',
  EmkServiceMethodUnit in 'methods\EmkServiceMethodUnit.pas',
  ServiceMethodUnit in 'services\ServiceMethodUnit.pas',
  CreateCaseMethodUnit in 'methods\CreateCaseMethodUnit.pas',
  MedicalStaffUnit in 'objects\MedicalStaffUnit.pas',
  PersonUnit in 'objects\PersonUnit.pas',
  GuardianUnit in 'objects\GuardianUnit.pas',
  RecommendationUnit in 'objects\RecommendationUnit.pas',
  ProcedureUnit in 'objects\ProcedureUnit.pas',
  ParticipantUnit in 'objects\ParticipantUnit.pas',
  SickListUnit in 'objects\SickListUnit.pas',
  MedRecordUnit in 'objects\MedRecordUnit.pas',
  AllergyUnit in 'objects\AllergyUnit.pas',
  ImmunizeUnit in 'objects\ImmunizeUnit.pas',
  NonDrugTreatmentUnit in 'objects\NonDrugTreatmentUnit.pas',
  ResInstrUnit in 'objects\ResInstrUnit.pas',
  ScoresUnit in 'objects\ScoresUnit.pas',
  ServiceUnit in 'objects\ServiceUnit.pas',
  SurgeryUnit in 'objects\SurgeryUnit.pas',
  TfomsUnit in 'objects\TfomsUnit.pas',
  AppointedMedicationUnit in 'objects\AppointedMedicationUnit.pas',
  DeathInfoUnit in 'objects\DeathInfoUnit.pas',
  DiagnosisUnit in 'objects\DiagnosisUnit.pas',
  MedDocumentUnit in 'objects\MedDocumentUnit.pas',
  DispensaryUnit in 'objects\DispensaryUnit.pas',
  ReferralUnit in 'objects\ReferralUnit.pas',
  SocialAnamnesisUnit in 'objects\SocialAnamnesisUnit.pas',
  Form027UUnit in 'objects\Form027UUnit.pas',
  StepBaseUnit in 'objects\StepBaseUnit.pas',
  StepAmbUnit in 'objects\StepAmbUnit.pas',
  StepStatUnit in 'objects\StepStatUnit.pas',
  CaseBaseUnit in 'objects\CaseBaseUnit.pas',
  CaseAmbUnit in 'objects\CaseAmbUnit.pas',
  CaseStatUnit in 'objects\CaseStatUnit.pas',
  AddStepToCaseMethodUnit in 'methods\AddStepToCaseMethodUnit.pas',
  AddMedRecordMethodUnit in 'methods\AddMedRecordMethodUnit.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
