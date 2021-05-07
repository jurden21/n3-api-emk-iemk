{***************************************************************************************************
* Тип СaseBase
* Комплексный тип СaseBase является базовым типом для передачи информации о случае медицинского обслуживания и наследуется дочерними
* типами, такими как:
* Тип СaseAmb – используется для передачи амбулаторного случая обслуживания.
* Тип СaseStat – используется для передачи стационарного случая обслуживания.
* Объекты CaseAmb и CaseStat используются в вызовах методов Модуля сбора статистики.
* В зависимости от типа случая обслуживания для объекта caseDto должно указываться соответствующее значение атрибута xsi:type (используется
* для указания в явном виде типа наследуемого объекта; подробнее про xsi:type – см. http://www.w3.org/TR/xmlschema-1/#xsi_type).
* Комплексный тип СaseBase содержит основные сведения по случаю, такие как информация по эпизодам обслуживания и медицинские записи,
* созданные в рамках случая. Описание типа CaseBase представлено в таблице.
* OpenDate                1..1  DateTime      Дата открытия случая
* CloseDate               1..1  DateTime      Дата закрытия случая
* HistoryNumber           1..1  String        Номер истории болезни/Амбулаторного талона
* IdCaseMis               1..1  String        Идентификатор случая в передающей МИС
* IdCaseAidType           0..1  Integer       Идентификатор вида медицинского обслуживания (Справочник OID: 1.2.643.2.69.1.1.1.16)
* IdPaymentType           1..1	Integer       Идентификатор источника финансирования (Cправочник OID: 1.2.643.2.69.1.1.1.32)
* Confidentiality         1..1	Integer       Код уровня конфиденциальности по региональному справочнику (Cправочник OID: 1.2.643.2.69.1.1.1.90)
* DoctorConfidentiality   1..1	Integer       Код уровня конфиденциальности по региональному справочнику (Cправочник OID: 1.2.643.2.69.1.1.1.90)
* CuratorConfidentiality  1..1	Integer       Код уровня конфиденциальности по региональному справочнику (Cправочник OID: 1.2.643.2.69.1.1.1.90)
* IdLpu                   1..1	String        Идентификатор МО
* IdCaseResult            1..1	Integer       Идентификатор исхода заболевания (Справочник OID: 1.2.643.5.1.13.2.1.1.688)
* Comment                 1..1	String        Текст заключения из эпикриза и/или другую важную медицинскую информацию в неструктурированном виде, например, текст медицинского протокола
* DoctorInCharge          1..1	MedicalStaff  Информация о лечащем враче
* Authenticator           1..1	Participant   Лицо, подписывающее или визирующее формируемый набор медицинской информации
* Author                  1..1	Participant   Лицо, являющееся автором передаваемого набора медицинской информации (как правило, лечащий врач)
* LegalAuthenticator      0..1	Participant   Лицо, утвердившее информацию о случае обслуживания (несущее юридическую ответственность)
* Guardian                0..1	Guardian      Информация о другом участнике случая (родителе/опекуне)
* IdPatientMis            1..1	String        Идентификатор пациента в передающей системе
***************************************************************************************************}
unit CaseBaseUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedicalStaffUnit, ParticipantUnit, GuardianUnit;

type
    TCaseBaseObject = class
    private
        FOpenDate: TDateTime;
        FCloseDate: TDateTime;
        FHistoryNumber: String;
        FIdCaseMis: String;
        FIdCaseAidType: Integer;
        FIdPaymentType: Integer;
        FConfidentiality: Integer;
        FDoctorConfidentiality: Integer;
        FCuratorConfidentiality: Integer;
        FIdLpu: String;
        FIdCaseResult: Integer;
        FComment: String;
        FDoctorInCharge: TMedicalStaffObject;
        FAuthenticator: TParticipantObject;
        FAuthor: TParticipantObject;
        FLegalAuthenticator: TParticipantObject;
        FGuardian: TGuardianObject;
        FIdPatientMis: String;
    public
        property OpenDate: TDateTime read FOpenDate;
        property CloseDate: TDateTime read FCloseDate;
        property HistoryNumber: String read FHistoryNumber;
        property IdCaseMis: String read FIdCaseMis;
        property IdCaseAidType: Integer read FIdCaseAidType;
        property IdPaymentType: Integer read FIdPaymentType;
        property Confidentiality: Integer read FConfidentiality;
        property DoctorConfidentiality: Integer read FDoctorConfidentiality;
        property CuratorConfidentiality: Integer read FCuratorConfidentiality;
        property IdLpu: String read FIdLpu;
        property IdCaseResult: Integer read FIdCaseResult;
        property Comment: String read FComment;
        property DoctorInCharge: TMedicalStaffObject read FDoctorInCharge;
        property Authenticator: TParticipantObject read FAuthenticator;
        property Author: TParticipantObject read FAuthor;
        property LegalAuthenticator: TParticipantObject read FLegalAuthenticator;
        property Guardian: TGuardianObject read FGuardian;
        property IdPatientMis: String read FIdPatientMis;
        constructor Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
            AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
            const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator,
            AAuthor, ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode; const AFormat: String); virtual;
    end;

implementation

uses XmlWriterUnit;

{ TCaseBaseObject }

constructor TCaseBaseObject.Create(const AOpenDate, ACloseDate: TDateTime; const AHistoryNumber, AIdCaseMis: String; const AIdCaseAidType,
    AIdPaymentType, AConfidentiality, ADoctorConfidentiality, ACuratorConfidentiality: Integer; const AIdLpu: String;
    const AIdCaseResult: Integer; const AComment: String; const ADoctorInCharge: TMedicalStaffObject; const AAuthenticator, AAuthor,
    ALegalAuthenticator: TParticipantObject; const AGuardian: TGuardianObject; const AIdPatientMis: String);
begin
    FOpenDate := AOpenDate;
    FCloseDate := ACloseDate;
    FHistoryNumber := AHistoryNumber;
    FIdCaseMis := AIdCaseMis;
    FIdCaseAidType := AIdCaseAidType;
    FIdPaymentType := AIdPaymentType;
    FConfidentiality := AConfidentiality;
    FDoctorConfidentiality := ADoctorConfidentiality;
    FCuratorConfidentiality := ACuratorConfidentiality;
    FIdLpu := AIdLpu;
    FIdCaseResult := AIdCaseResult;
    FComment := AComment;
    FDoctorInCharge := ADoctorInCharge;
    FAuthenticator := AAuthenticator;
    FAuthor := AAuthor;
    FLegalAuthenticator := ALegalAuthenticator;
    FGuardian := AGuardian;
    FIdPatientMis := AIdPatientMis;
end;

destructor TCaseBaseObject.Destroy;
begin
    FGuardian.Free;
    FLegalAuthenticator.Free;
    FAuthor.Free;
    FAuthenticator.Free;
    FDoctorInCharge.Free;
    inherited;
end;

// if (AFormat = 'CreateCase') or (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
procedure TCaseBaseObject.SaveToXml(const ANode: IXmlNode; const AFormat: String);
var
    Node: IXmlNode;
begin
    TXmlWriter.WriteDateTime(ANode.AddChild('a:OpenDate'), OpenDate);
    if (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
    then TXmlWriter.WriteDateTime(ANode.AddChild('a:CloseDate'), CloseDate);
    TXmlWriter.WriteString(ANode.AddChild('a:HistoryNumber'), HistoryNumber);
    TXmlWriter.WriteString(ANode.AddChild('a:IdCaseMis'), IdCaseMis);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('a:IdCaseAidType'), IdCaseAidType);
    TXmlWriter.WriteInteger(ANode.AddChild('a:IdPaymentType'), IdPaymentType);
    TXmlWriter.WriteInteger(ANode.AddChild('a:Confidentiality'), Confidentiality);
    TXmlWriter.WriteInteger(ANode.AddChild('a:DoctorConfidentiality'), DoctorConfidentiality);
    TXmlWriter.WriteInteger(ANode.AddChild('a:CuratorConfidentiality'), CuratorConfidentiality);
    TXmlWriter.WriteString(ANode.AddChild('a:IdLpu'), IdLpu);
    if (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
    then TXmlWriter.WriteInteger(ANode.AddChild('a:IdCaseResult'), IdCaseResult);
    if (AFormat = 'AddCase') or (AFormat = 'UpdateCase') or (AFormat = 'CloseCase')
    then TXmlWriter.WriteString(ANode.AddChild('a:Comment'), Comment);

    Node := ANode.AddChild('a:DoctorInCharge');
    if DoctorInCharge = nil
    then TXmlWriter.WriteNull(Node)
    else DoctorInCharge.SaveToXml(Node);

    Node := ANode.AddChild('a:Authenticator');
    if Authenticator = nil
    then TXmlWriter.WriteNull(Node)
    else Authenticator.SaveToXml(Node);

    Node := ANode.AddChild('a:Author');
    if Authenticator = nil
    then TXmlWriter.WriteNull(Node)
    else Author.SaveToXml(Node);

    Node := ANode.AddChild('a:LegalAuthenticator');
    if Authenticator = nil
    then TXmlWriter.WriteNull(Node)
    else LegalAuthenticator.SaveToXml(Node);

    Node := ANode.AddChild('a:Guardian');
    if Authenticator = nil
    then TXmlWriter.WriteNull(Node)
    else Guardian.SaveToXml(Node);

    TXmlWriter.WriteString(ANode.AddChild('a:IdPatientMis'), IdPatientMis);
end;

end.
