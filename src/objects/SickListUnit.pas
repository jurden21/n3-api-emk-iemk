{***************************************************************************************************
* Тип SickListInfo
* Комплексный тип SickListInfo предназначен для передачи иннформации о выданном листке временной нетрудоспособности (больничного листа).
* Параметры типа SickListInfo приведены в таблице.
* Number               1..1  String	Номер листа нетрудоспособности
* DateStart            1..1  DateTime	Дата открытия листа нетрудоспособности
* Caregiver            0..1  Guardian   Дополнительная информация об ухаживающем за больным (которому выдан ЛВН)
* DateEnd              1..1  DateTime   Дата закрытия листа нетрудоспособности
* DisabilityDocReason  0..1  Integer    Идентификатор причины выдачи документа временной нетрудоспособности (Справочник OID: 1.2.643.2.69.1.1.1.15)
* DisabilityDocState   0..1	 Integer    Идентификатор статуса документа временной нетрудоспособности (Справочник OID: 1.2.643.2.69.1.1.1.14)
* IsPatientTaker       1..1  Boolean    Признак: является ли получателем ЛВН сам является пациент
*
* Подтип SickList
* Комплексный тип SickList предназначен для передачи информации о выданных листках временной нетрудоспособности в рамках случая обслуживания.
* Параметры типа SickListInfo наследуются от родительского типа MedDocument и дополняются элементами, приведенными в таблице.
* SickListInfo  1..1  SickListInfo  Информация о выданном листке временной нетрудоспособности
***************************************************************************************************}
unit SickListUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, GuardianUnit, MedDocumentUnit, MedicalStaffUnit;

type
    TSickListInfoObject = class
    private
        FNumber: String;
        FDateStart: TDateTime;
        FDateEnd: TDateTime;
        FCaregiver: TGuardianObject;
        FDisabilityDocReason: Integer;
        FDisabilityDocState: Integer;
        FIsPatientTaker: Boolean;
    public
        property Number: String read FNumber;
        property DateStart: TDateTime read FDateStart;
        property DateEnd: TDateTime read FDateEnd;
        property Caregiver: TGuardianObject read FCaregiver;
        property DisabilityDocReason: Integer read FDisabilityDocReason;
        property DisabilityDocState: Integer read FDisabilityDocState;
        property IsPatientTaker: Boolean read FIsPatientTaker;
        constructor Create(const ANumber: String; const ADateStart, ADateEnd: TDateTime; const ACaregiver: TGuardianObject;
            const ADisabilityDocReason, ADisabilityDocState: Integer; const AIsPatientTaker: Boolean);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TSickListObject = class (TMedDocumentObject)
    private
        FSickListInfo: TSickListInfoObject;
    public
        property SickListInfo: TSickListInfoObject read FSickListInfo;
        constructor Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
            const AAuthor: TMedicalStaffObject; const AHeader: String; const ASickListInfo: TSickListInfoObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TSickListInfoObject }

constructor TSickListInfoObject.Create(const ANumber: String; const ADateStart, ADateEnd: TDateTime; const ACaregiver: TGuardianObject;
    const ADisabilityDocReason, ADisabilityDocState: Integer; const AIsPatientTaker: Boolean);
begin
    FNumber := ANumber;
    FDateStart := ADateStart;
    FDateEnd := ADateEnd;
    FCaregiver := ACaregiver;
    FDisabilityDocReason := ADisabilityDocReason;
    FDisabilityDocState := ADisabilityDocState;
    FIsPatientTaker := AIsPatientTaker;
end;

destructor TSickListInfoObject.Destroy;
begin
    FCaregiver.Free;
    inherited;
end;

procedure TSickListInfoObject.SaveToXml(const ANode: IXmlNode);
var
    CaregiverNode: IXmlNode;
begin
    TXmlWriter.WriteString(ANode.AddChild('mm:Number'), Number);
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:DateStart'), DateStart);

    CaregiverNode := ANode.AddChild('mm:Caregiver');
    if Caregiver = nil
    then TXmlWriter.WriteNull(CaregiverNode)
    else Caregiver.SaveToXml(CaregiverNode);

    TXmlWriter.WriteDateTime(ANode.AddChild('mm:DateEnd'), DateEnd);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:DisabilityDocReason'), DisabilityDocReason);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:DisabilityDocState'), DisabilityDocState);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:IsPatientTaker'), IsPatientTaker);
end;

{ TSickListObject }

constructor TSickListObject.Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
    const AAuthor: TMedicalStaffObject; const AHeader: String; const ASickListInfo: TSickListInfoObject);
begin
    inherited Create(ACreationDate, AIdDocumentMis, AAttachment, AAuthor, AHeader);
    FSickListInfo := ASickListInfo;
end;

destructor TSickListObject.Destroy;
begin
    FSickListInfo.Free;
    inherited;
end;

procedure TSickListObject.SaveToXml(const ANode: IXmlNode);
var
    SickListInfoNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:SickList');

    inherited SaveToXml(ANode);

    SickListInfoNode := ANode.AddChild('mm:SickListInfo');
    if SickListInfo = nil
    then TXmlWriter.WriteNull(SickListInfoNode)
    else SickListInfo.SaveToXml(SickListInfoNode);
end;

end.
