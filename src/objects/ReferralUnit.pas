{***************************************************************************************************
* Тип ReferralInfo
* Комплексный тип ReferralInfo предназначен для передачи данных о направлении.
* Reason                1..1  String    Обоснование направления
* IdReferralMis         1..1  String    Идентификатор направления в МИС
* IdReferralType        1..1  Integer   Идентификатор вида направления (Справочник OID: 1.2.643.5.1.13.2.7.1.2)
* IssuedDateTime        1..1  DateTime  Дата направления
* HospitalizationOrder  0..1  Integer   Экстренность/плановость госпитализации (Справочник OID: 1.2.643.2.69.1.1.1.21) (Заполняется для IdReferralType = 1)
* MkbCode               1..1  String    Код заболевания (Справочник OID: 1.2.643.2.69.1.1.1.2)
*
* Подтип Referral
* Комплексный тип Referral предназначен для передачи данных направления на госпитализацию, обследование, консультацию по форме 057-У.
* Параметры типа Referral наследуются от родительского типа MedDocument и дополняются элементами, приведенными в таблице.
* ReferralInfo    1..1  ReferralInfo  Информация о направлении
* DepartmentHead  1..1  MedicalStaff  Информация о главе отделения
* IdSourceLpu     1..1  String        Идентификатор ЛПУ, из которого осуществляется направление. (Значение поля UNQ, Справочник OID: 1.2.643.2.69.1.1.1.64)
* IdTargetLpu     1..1  String        Идентификатор ЛПУ, куда направлен пациент. (Значение поля UNQ, Справочник OID: 1.2.643.2.69.1.1.1.64)
* ReferralID      0..1  String        Глобальный идентификатор направления в сервисе УО (от ЛПУ, из которого осуществляется направление)
* RelatedID       0..1  String        Глобальный идентификатор направления в сервисе УО (от ЛПУ, куда направлен пациент)
***************************************************************************************************}
unit ReferralUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit, MedDocumentUnit;

type
    TReferralInfoObject = class
    private
        FReason: String;
        FIdReferralMis: String;
        FIdReferralType: Integer;
        FIssuedDateTime: TDateTime;
        FHospitalizationOrder: Integer;
        FMkbCode: String;
    public
        property Reason: String read FReason;
        property IdReferralMis: String read FIdReferralMis;
        property IdReferralType: Integer read FIdReferralType;
        property IssuedDateTime: TDateTime read FIssuedDateTime;
        property HospitalizationOrder: Integer read FHospitalizationOrder;
        property MkbCode: String read FMkbCode;
        constructor Create(const AReason, AIdReferralMis: String; const AIdReferralType: Integer; const AIssuedDateTime: TDateTime;
            const AHospitalizationOrder: Integer; const AMkbCode: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TReferralObject = class (TMedDocumentObject)
    private
        FReferralInfo: TReferralInfoObject;
        FDepartmentHead: TMedicalStaffObject;
        FIdSourceLpu: String;
        FIdTargetLpu: String;
        FReferralId: String;
        FRelatedId: String;
    public
        property ReferralInfo: TReferralInfoObject read FReferralInfo;
        property DepartmentHead: TMedicalStaffObject read FDepartmentHead;
        property IdSourceLpu: String read FIdSourceLpu;
        property IdTargetLpu: String read FIdTargetLpu;
        property ReferralId: String read FReferralId;
        property RelatedId: String read FRelatedId;
        constructor Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
            const AAuthor: TMedicalStaffObject; const AHeader: String; const AReferralInfo: TReferralInfoObject;
            const ADepartmentHead: TMedicalStaffObject; const AIdSourceLpu, AIdTargetLpu, AReferralId, ARelatedId: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TReferralInfoObject }

constructor TReferralInfoObject.Create(const AReason, AIdReferralMis: String; const AIdReferralType: Integer;
    const AIssuedDateTime: TDateTime; const AHospitalizationOrder: Integer; const AMkbCode: String);
begin
    FReason := AReason;
    FIdReferralMis := AIdReferralMis;
    FIdReferralType := AIdReferralType;
    FIssuedDateTime := AIssuedDateTime;
    FHospitalizationOrder := AHospitalizationOrder;
    FMkbCode := AMkbCode;
end;

procedure TReferralInfoObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteString(ANode.AddChild('mm:Reason'), Reason);
    TXmlWriter.WriteString(ANode.AddChild('mm:IdReferralMis'), IdReferralMis);
    TXmlWriter.WriteInteger(ANode.AddChild('mm:IdReferralType'), IdReferralType);
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:IssuedDateTime'), IssuedDateTime);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:HospitalizationOrder'), HospitalizationOrder);
    TXmlWriter.WriteString(ANode.AddChild('mm:MkbCode'), MkbCode);
end;

{ TReferralObject }

constructor TReferralObject.Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
    const AAuthor: TMedicalStaffObject; const AHeader: String; const AReferralInfo: TReferralInfoObject;
    const ADepartmentHead: TMedicalStaffObject; const AIdSourceLpu, AIdTargetLpu, AReferralId, ARelatedId: String);
begin
    inherited Create(ACreationDate, AIdDocumentMis, AAttachment, AAuthor, AHeader);

    FReferralInfo := AReferralInfo;
    FDepartmentHead := ADepartmentHead;
    FIdSourceLpu := AIdSourceLpu;
    FIdTargetLpu := AIdTargetLpu;
    FReferralId := AReferralId;
    FRelatedId := ARelatedId;
end;

destructor TReferralObject.Destroy;
begin
    FDepartmentHead.Free;
    FReferralInfo.Free;
    inherited;
end;

procedure TReferralObject.SaveToXml(const ANode: IXmlNode);
var
    ReferralInfoNode, DepartmentHeadNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:Referral');

    inherited SaveToXml(ANode);

    ReferralInfoNode := ANode.AddChild('mm:ReferralInfo');
    if ReferralInfo = nil
    then TXmlWriter.WriteNull(ReferralInfoNode)
    else ReferralInfo.SaveToXml(ReferralInfoNode);

    DepartmentHeadNode := ANode.AddChild('mm:DepartmentHead');
    if DepartmentHead = nil
    then TXmlWriter.WriteNull(DepartmentHeadNode)
    else DepartmentHead.SaveToXml(DepartmentHeadNode);

    TXmlWriter.WriteString(ANode.AddChild('mm:IdSourceLpu'), IdSourceLpu);
    TXmlWriter.WriteString(ANode.AddChild('mm:IdTargetLpu'), IdTargetLpu);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:ReferralId'), ReferralId);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:RelatedId'), RelatedId);
end;

end.
