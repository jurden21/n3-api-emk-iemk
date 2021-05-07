{***************************************************************************************************
* Тип СaseStat
* Комплексный тип СaseStat используется для передачи данных стационарного обслуживания. Тип наследуется от CaseBase и имеет дополнительные
* атрибуты, описанные в таблице.
* DeliveryCode            0..1  String     Код бригады доставившей пациента/номер наряда скорой помощи. Параметр заполняется, если IdHospChannel = 1 («СМП»)
* IdIntoxicationType      0..1	Integer    Идентификатор типа интоксикации пациента при поступлении (Справочник OID: 1.2.643.5.1.13.2.1.1.555)
* AdmissionCondition      1..1	Integer    Идентификатор состояния пациента при поступлении (Справочник OID: 1.2.643.5.1.13.2.1.1.111)
* IdTypeFromDiseaseStart  1..1	Integer    Идентификатор интервалов времени, прошедшего с момента заболевания до обращения (Справочник OID: 1.2.643.5.1.13.2.1.1.537)
* IdRepetition            1..1	Integer    Первичность/повторность госпитализации (Справочник OID: 1.2.643.2.69.1.1.1.20)
* HospitalizationOrder    1..1	Integer    Экстренность/плановость госпитализации (Справочник OID: 1.2.643.2.69.1.1.1.21)
* IdTransportIntern       0..1	Integer    Идентификатор вида транспортировки (Справочник OID: 1.2.643.2.69.1.1.1.22)
* Steps                   1..*	StepStat   Массив эпизодов случаев медицинского обслуживания
* HospResult              1..1	Integer    Идентификатор исхода госпитализации (Справочник OID: 1.2.643.2.69.1.1.1.23)
* MedRecords              0..1	MedRecord  Массив MedRecord, доступных для стационарного случая обслуживания
* IdHospChannel           1..1	Integer    Код канала госпитализации (Справочник OID: 1.2.643.5.1.13.2.1.1.281)
* RW1Mark                 0..1	Boolean    Метка наличия результата обследования на сифилис
* AIDSMark                0..1	Boolean    Метка наличия результата обследования на ВИЧ-инфекцию
* PrehospitalDefects      1..*	Integer    Коды дефекта догоспитального этапа (Справочник OID: 1.2.643.2.69.1.1.1.24)
* AdmissionComment        1..1	String     Текстовый комментрий, описывающий состояние пациента при поступлении и/или другую важную медицинскую информацию
* DischargeCondition      1..1	Integer    Код состояния пациента при выписке (Справочник OID: 1.2.643.5.1.13.2.1.1.111)
* DischargeComment        1..1	String     Текстовый комментрий, описывающий состояние пациента при выписке и/или другую важную медицинскую информацию
* DietComment             1..1	String     Текстовый комментрий, содержащий рекомендации по режиму и диете
* TreatComment            1..1	String     Текстовый комментрий, содержащий рекомендации по дальнейшему лечению
* WorkComment             1..1	String     Текстовый комментрий, содержащий рекомендации по режиму труда
* OtherComment            0..1	String     Текстовый комментрий, содержащий иные рекомендации и пояснения
***************************************************************************************************}
unit CaseStatUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, CaseBaseUnit, StepStatUnit, MedRecordUnit, MedicalStaffUnit, ParticipantUnit,
    GuardianUnit;

type
    TCaseStatObject = class (TCaseBaseObject)
    private
        FDeliveryCode: String;
        FIdIntoxicationType: Integer;
        FAdmissionCondition: Integer;
        FIdTypeFromDiseaseStart: Integer;
        FIdRepetition: Integer;
        FHospitalizationOrder: Integer;
        FIdTransportIntern: Integer;
        FSteps: TObjectList<TStepStatObject>;
        FHospResult: Integer;
        FMedRecords: TObjectList<TMedRecordObject>;
        FIdHospChannel: Integer;
        FRW1Mark: Boolean;
        FAIDSMark: Boolean;
        FPrehospitalDefects: TList<Integer>;
        FAdmissionComment: String;
        FDischargeCondition: Integer;
        FDischargeComment: String;
        FDietComment: String;
        FTreatComment: String;
        FWorkComment: String;
        FOtherComment: String;
    public
        property DeliveryCode: String read FDeliveryCode;
        property IdIntoxicationType: Integer read FIdIntoxicationType;
        property AdmissionCondition: Integer read FAdmissionCondition;
        property IdTypeFromDiseaseStart: Integer read FIdTypeFromDiseaseStart;
        property IdRepetition: Integer read FIdRepetition;
        property HospitalizationOrder: Integer read FHospitalizationOrder;
        property IdTransportIntern: Integer read FIdTransportIntern;
        property Steps: TObjectList<TStepStatObject> read FSteps;
        property HospResult: Integer read FHospResult;
        property MedRecords: TObjectList<TMedRecordObject> read FMedRecords;
        property IdHospChannel: Integer read FIdHospChannel;
        property RW1Mark: Boolean read FRW1Mark;
        property AIDSMark: Boolean read FAIDSMark;
        property PrehospitalDefects: TList<Integer> read FPrehospitalDefects;
        property AdmissionComment: String read FAdmissionComment;
        property DischargeCondition: Integer read FDischargeCondition;
        property DischargeComment: String read FDischargeComment;
        property DietComment: String read FDietComment;
        property TreatComment: String read FTreatComment;
        property WorkComment: String read FWorkComment;
        property OtherComment: String read FOtherComment;
        constructor Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
            AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
            const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator,
            AAuthor, ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis, ADeliveryCode: String;
            const AIdIntoxicationType, AAdmissionCondition, AIdTypeFromDiseaseStart, AIdRepetition, AHospitalizationOrder,
            AIdTransportIntern, AHospResult, AIdHospChannel: Integer; const ARW1Mark, AAIDSMark: Boolean; const AAdmissionComment: String;
            const ADischargeCondition: Integer; const ADischargeComment, ADietComment, ATreatComment, AWorkComment, AOtherComment: String);
        destructor Destroy; override;
        function AddStep(const AItem: TStepStatObject): Integer;
        procedure ClearSteps;
        function AddMedRecord(const AItem: TMedRecordObject): Integer;
        procedure ClearMedRecords;
        function AddPrehospitalDefect(const AValue: Integer): Integer;
        procedure ClearPrehospitalDefects;
        procedure SaveToXml(const ANode: IXmlNode; const AFormat: String); override;
    end;

implementation

uses XmlWriterUnit;

{ TCaseStatObject }

constructor TCaseStatObject.Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
    AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
    const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator, AAuthor,
    ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis, ADeliveryCode: String;
    const AIdIntoxicationType, AAdmissionCondition, AIdTypeFromDiseaseStart, AIdRepetition, AHospitalizationOrder, AIdTransportIntern,
    AHospResult, AIdHospChannel: Integer; const ARW1Mark, AAIDSMark: Boolean; const AAdmissionComment: String;
    const ADischargeCondition: Integer; const ADischargeComment, ADietComment, ATreatComment, AWorkComment, AOtherComment: String);
begin
    inherited Create(AOpenDate, ACloseDate, AHistoryNumber, AIdCaseMis, AIdCaseAidType, AIdPaymentType, AConfidentiality,
        ADoctorConfidentiality, ACuratorConfidentiality, AIdLpu, AIdCaseResult, AComment, ADoctorInCharge, AAuthenticator, AAuthor,
        ALegalAuthenticator, AGuardian, AIdPatientMis);

    FDeliveryCode := ADeliveryCode;
    FIdIntoxicationType := AIdIntoxicationType;
    FAdmissionCondition := AAdmissionCondition;
    FIdTypeFromDiseaseStart := AIdTypeFromDiseaseStart;
    FIdRepetition := AIdRepetition;
    FHospitalizationOrder := AHospitalizationOrder;
    FIdTransportIntern := AIdTransportIntern;
    FHospResult := AHospResult;
    FIdHospChannel := AIdHospChannel;
    FRW1Mark := ARW1Mark;
    FAIDSMark := AAIDSMark;
    FAdmissionComment := AAdmissionComment;
    FDischargeCondition := ADischargeCondition;
    FDischargeComment := ADischargeComment;
    FDietComment := ADietComment;
    FTreatComment := ATreatComment;
    FWorkComment := AWorkComment;
    FOtherComment := AOtherComment;

    FSteps := TObjectList<TStepStatObject>.Create(True);
    FMedRecords := TObjectList<TMedRecordObject>.Create(True);
    FPrehospitalDefects := TList<Integer>.Create;
end;

destructor TCaseStatObject.Destroy;
begin
    FPrehospitalDefects.Free;
    FMedRecords.Free;
    FSteps.Free;

    inherited;
end;

function TCaseStatObject.AddStep(const AItem: TStepStatObject): Integer;
begin
    Result := Steps.Add(AItem);
end;

procedure TCaseStatObject.ClearSteps;
begin
    Steps.Clear;
end;

function TCaseStatObject.AddMedRecord(const AItem: TMedRecordObject): Integer;
begin
    Result := MedRecords.Add(AItem);
end;

procedure TCaseStatObject.ClearMedRecords;
begin
    MedRecords.Clear;
end;

function TCaseStatObject.AddPrehospitalDefect(const AValue: Integer): Integer;
begin
    Result := PrehospitalDefects.Add(AValue);
end;

procedure TCaseStatObject.ClearPrehospitalDefects;
begin
    PrehospitalDefects.Clear;
end;

// if (AFormat = 'CreateCase') or (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
procedure TCaseStatObject.SaveToXml(const ANode: IXmlNode; const AFormat: String);
var
    Node: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'a:CaseStat');

    inherited SaveToXml(ANode, AFormat);

    TXmlWriter.WriteStringNullable(ANode.AddChild('a:DeliveryCode'), DeliveryCode);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('a:IdIntoxicationType'), IdIntoxicationType);
    TXmlWriter.WriteInteger(ANode.AddChild('a:AdmissionCondition'), AdmissionCondition);
    TXmlWriter.WriteInteger(ANode.AddChild('a:IdTypeFromDiseaseStart'), IdTypeFromDiseaseStart);
    TXmlWriter.WriteInteger(ANode.AddChild('a:IdRepetition'), IdRepetition);
    TXmlWriter.WriteInteger(ANode.AddChild('a:HospitalizationOrder'), HospitalizationOrder);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('a:IdTransportIntern'), IdTransportIntern);

    Node := ANode.AddChild('a:Steps');
    if Steps.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to Steps.Count - 1 do
            Steps[Index].SaveToXml(Node.AddChild('s:StepStat'));
    end;

    if (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
    then TXmlWriter.WriteInteger(ANode.AddChild('a:HospResult'), HospResult);

    Node := ANode.AddChild('a:MedRecords');
    if MedRecords.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MedRecords.Count - 1 do
            MedRecords[Index].SaveToXml(Node.AddChild('MedRecord'));
    end;

    TXmlWriter.WriteInteger(ANode.AddChild('a:IdHospChannel'), IdHospChannel);
    TXmlWriter.WriteBoolean(ANode.AddChild('a:RW1Mark'), RW1Mark);
    TXmlWriter.WriteBoolean(ANode.AddChild('a:AIDSMark'), AIDSMark);

    Node := ANode.AddChild('a:PrehospitalDefects');
    if PrehospitalDefects.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to PrehospitalDefects.Count - 1 do
            TXmlWriter.WriteInteger(Node.AddChild('IdPrehospitalDefect'), PrehospitalDefects[Index]);
    end;

    TXmlWriter.WriteString(ANode.AddChild('a:AdmissionComment'), AdmissionComment);
    TXmlWriter.WriteInteger(ANode.AddChild('a:DischargeCondition'), DischargeCondition);
    TXmlWriter.WriteString(ANode.AddChild('a:DischargeComment'), DischargeComment);
    TXmlWriter.WriteString(ANode.AddChild('a:DietComment'), DietComment);
    TXmlWriter.WriteString(ANode.AddChild('a:TreatComment'), TreatComment);
    TXmlWriter.WriteString(ANode.AddChild('a:WorkComment'), WorkComment);
    TXmlWriter.WriteStringNullable(ANode.AddChild('a:OtherComment'), OtherComment);
end;

end.
