{***************************************************************************************************
* Тип СaseAmb
* Комплексный тип СaseAmb используется для передачи данных амбулаторного случая обслуживания. Тип наследуется от CaseBase и имеет
* дополнительные параметры, описанные в таблице.
* IdCasePurpose  0..1  Integer    Идентификатор цели обращения (Справочник OID: 1.2.643.5.1.13.2.1.1.106)
* IdCaseType     1..1  Integer    Идентификатор типа случая обслуживания: амбулаторный, диспансеризация (Cправочник OID: 1.2.643.2.69.1.1.1.35)
* IdAmbResult    0..0  Integer    Код результата обращения (Cправочник OID: 1.2.643.2.69.1.1.1.17)
* IsActive       0..1  Boolean    Признак «Актив». Признак устанавливается, если пациент был направлен на приём к врачу
* Steps          1..*  StepAmb    Массив эпизодов случаев медицинского обслуживания
* MedRecords     0..1  MedRecord  Массив MedRecord, доступных для эпизода амбулаторного случая обслуживания
* CaseVisitType  1..1  Integer    Порядок обращения (OID справочника: 1.2.643.5.1.13.13.11.1007 )
***************************************************************************************************}
unit CaseAmbUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, CaseBaseUnit, StepAmbUnit, MedRecordUnit, MedicalStaffUnit, ParticipantUnit,
    GuardianUnit;

type
    TCaseAmbObject = class (TCaseBaseObject)
    private
        FIdCasePurpose: Integer;
        FIdCaseType: Integer;
        FIdAmbResult: Integer;
        FIsActive: Boolean;
        FSteps: TObjectList<TStepAmbObject>;
        FMedRecords: TObjectList<TMedRecordObject>;
        FCaseVisitType: Integer;
    public
        property IdCasePurpose: Integer read FIdCasePurpose;
        property IdCaseType: Integer read FIdCaseType;
        property IdAmbResult: Integer read FIdAmbResult;
        property IsActive: Boolean read FIsActive;
        property Steps: TObjectList<TStepAmbObject> read FSteps;
        property MedRecords: TObjectList<TMedRecordObject> read FMedRecords;
        property CaseVisitType: Integer read FCaseVisitType;
        constructor Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
            AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
            const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator, AAuthor,
            ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis: String; const AIdCasePurpose,
            AIdCaseType, AIdAmbResult: Integer; const AIsActive: Boolean; const ACaseVisitType: Integer);
        destructor Destroy; override;
        function AddStep(const AItem: TStepAmbObject): Integer;
        procedure ClearSteps;
        function AddMedRecord(const AItem: TMedRecordObject): Integer;
        procedure ClearMedRecords;
        procedure SaveToXml(const ANode: IXmlNode; const AFormat: String); override;
    end;

implementation

uses XmlWriterUnit;

{ TCaseAmbObject }

constructor TCaseAmbObject.Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
    AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
    const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator, AAuthor,
    ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis: String; const AIdCasePurpose,
    AIdCaseType, AIdAmbResult: Integer; const AIsActive: Boolean; const ACaseVisitType: Integer);
begin
    inherited Create(AOpenDate, ACloseDate, AHistoryNumber, AIdCaseMis, AIdCaseAidType, AIdPaymentType, AConfidentiality,
        ADoctorConfidentiality, ACuratorConfidentiality, AIdLpu, AIdCaseResult, AComment, ADoctorInCharge, AAuthenticator, AAuthor,
        ALegalAuthenticator, AGuardian, AIdPatientMis);

    FIdCasePurpose := AIdCasePurpose;
    FIdCaseType := AIdCaseType;
    FIdAmbResult := AIdAmbResult;
    FIsActive := AIsActive;
    FCaseVisitType := ACaseVisitType;

    FSteps := TObjectList<TStepAmbObject>.Create(True);
    FMedRecords := TObjectList<TMedRecordObject>.Create(True);
end;

destructor TCaseAmbObject.Destroy;
begin
    FMedRecords.Free;
    FSteps.Free;
    inherited;
end;

function TCaseAmbObject.AddStep(const AItem: TStepAmbObject): Integer;
begin
    Result := Steps.Add(AItem);
end;

procedure TCaseAmbObject.ClearSteps;
begin
    Steps.Clear;
end;

function TCaseAmbObject.AddMedRecord(const AItem: TMedRecordObject): Integer;
begin
    Result := MedRecords.Add(AItem);
end;

procedure TCaseAmbObject.ClearMedRecords;
begin
    MedRecords.Clear;
end;

// if (AFormat = 'CreateCase') or (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
procedure TCaseAmbObject.SaveToXml(const ANode: IXmlNode; const AFormat: String);
var
    Node: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'a:CaseAmb');

    inherited SaveToXml(ANode, AFormat);

    TXmlWriter.WriteIntegerNullable(ANode.AddChild('a:IdCasePurpose'), IdCasePurpose);
    TXmlWriter.WriteInteger(ANode.AddChild('a:IdCaseType'), IdCaseType);
    if (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
    then TXmlWriter.WriteIntegerNullable(ANode.AddChild('a:IdAmbResult'), IdAmbResult);
    TXmlWriter.WriteBoolean(ANode.AddChild('a:IsActive'), IsActive);
    TXmlWriter.WriteInteger(ANode.AddChild('a:CaseVisitType'), CaseVisitType);

    Node := ANode.AddChild('a:Steps');
    if Steps.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to Steps.Count - 1 do
            Steps[Index].SaveToXml(Node.AddChild('s:StepAmb'));
    end;

    Node := ANode.AddChild('a:MedRecords');
    if MedRecords.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MedRecords.Count - 1 do
            MedRecords[Index].SaveToXml(Node.AddChild('MedRecord'));
    end;

end;

end.
