{***************************************************************************************************
* Тип IdentityDocument
* Комплексный тип IdentityDocument предназначен для передачи сведений о документах персоны. В таблице представлено описание комплексного
* типа IdentityDocument.
* DocN            1..1  String    Номер документа
* DocS            0..1  String    Серия документа
* DocumentName    0..0  String    Наименование документа (не используется для передачи в сервис)
* ExpiredDate     0..1  DateTime  Дата окончания действия документа
* IdDocumentType  1..1  Integer   Код типа документа (Справочник OID: 1.2.643.2.69.1.1.1.6)
* IdProvider      1..1  Integer   Код организации, выдавшей документ. Заполняется только для полисов (Реестр страховых медицинских
                                  организаций (ФОМС), Справочник OID: 1.2.643.5.1.13.2.1.1.635)
* IssuedDate      0..1  DateTime  Дата выдачи документа
* ProviderName    1..1  String    Наименование организации, выдавшей документ
* RegionCode      0..1  String    Код территории страхования (для полиса)
* StartDate       0..1  DateTime  Дата начала действия документа
*
* Тип HumanName
* Комплексный тип HumanName предназначен для передачи имени персоны. В таблице представлено описание комплексного типа HumanName.
* GivenName    1..1  String     Имя
* MiddleName   0..1  String     Отчество
* FamilyName   1..1  String     Фамилия
*
* Тип Person
* Комплексный тип Person предназначен для передачи данных о лице - участнике случая обслуживания.
* HumanName    1..1  HumanName  Имя персоны
* Sex          0..1  Integer    Код пола (Справочник OID 1.2.643.5.1.13.2.1.1.156)
* BirthDate    0..1  DateTime   Дата рождения
* IdPersonMis  1..1  String     Идентификатор персоны в системе-источнике данных
*
* Тип PersonWithIdentity
* Комплексеный тип PersonWithIdentity предназначен для перечи данных документов, удостовяющих личность лица-участника случая обслуживания.
* Тип наследуется от Person и имеет дополнительные параметры, описанные в таблице.
* Documents    0..*  IdentityDocument  Сведения о документых персоны
***************************************************************************************************}
unit PersonUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf;

type
    TIdentityDocumentObject = class
    private
        FIdDocumentType: Integer;
        FDocN: String;
        FDocS: String;
        FIssueDate: TDateTime;
        FStartDate: TDateTime;
        FExpiredDate: TDateTime;
        FIdProvider: Integer;
        FProviderName: String;
        FRegionCode: String;
    public
        property IdDocumentType: Integer read FIdDocumentType;
        property DocN: String read FDocN;
        property DocS: String read FDocS;
        property IssueDate: TDateTime read FIssueDate;
        property StartDate: TDateTime read FStartDate;
        property ExpiredDate: TDateTime read FExpiredDate;
        property IdProvider: Integer read FIdProvider;
        property ProviderName: String read FProviderName;
        property RegionCode: String read FRegionCode;
        constructor Create(const AIdDocumentType: Integer; const ADocN, ADocS: String; const AIssueDate, AStartDate, AExpiredDate: TDateTime;
            const AIdProvider: Integer; const AProviderName, ARegionCode: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TPersonObject = class
    private
        FGivenName: String;
        FMiddleName: String;
        FFamilyName: String;
        FSex: Integer;
        FBirthDate: TDateTime;
        FIdPersonMis: String;
        FDocuments: TObjectList<TIdentityDocumentObject>;
    public
        property GivenName: String read FGivenName;
        property MiddleName: String read FMiddleName;
        property FamilyName: STring read FFamilyName;
        property Sex: Integer read FSex;
        property BirthDate: TDateTime read FBirthDate;
        property IdPersonMis: String read FIdPersonMis;
        property Documents: TObjectList<TIdentityDocumentObject> read FDocuments;
        constructor Create(const AGivenName, AMiddleName, AFamilyName: String; const ASex: Integer; const ABirthDate: TDateTime; const AIdPersonMis: String); overload;
        destructor Destroy; override;
        function AddDocument(const AItem: TIdentityDocumentObject): Integer;
        procedure ClearDocuments;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

implementation

uses XmlWriterUnit;

{ TIdentityDocumentObject }

constructor TIdentityDocumentObject.Create(const AIdDocumentType: Integer; const ADocN, ADocS: String; const AIssueDate, AStartDate,
    AExpiredDate: TDateTime; const AIdProvider: Integer; const AProviderName, ARegionCode: String);
begin
    FIdDocumentType := AIdDocumentType;
    FDocN := ADocN;
    FDocS := ADocS;
    FIssueDate := AIssueDate;
    FStartDate := AStartDate;
    FExpiredDate := AExpiredDate;
    FIdProvider := AIdProvider;
    FProviderName := AProviderName;
    FRegionCode := ARegionCode;
end;

procedure TIdentityDocumentObject.SaveToXml(const ANode: IXmlNode);
var
    Node: IXmlNode;
begin
    Node := ANode.AddChild('b:IdentityDocument');
    TXmlWriter.WriteString(Node.AddChild('b:DocN'), DocN);
    TXmlWriter.WriteStringNullable(Node.AddChild('b:DocS'), DocS);
    TXmlWriter.WriteInteger(Node.AddChild('b:IdDocumentType'), IdDocumentType);
    TXmlWriter.WriteInteger(Node.AddChild('b:IdProvider'), IdProvider);
    TXmlWriter.WriteDateTimeNullable(Node.AddChild('b:ExpiredDate'), ExpiredDate);
    TXmlWriter.WriteDateTimeNullable(Node.AddChild('b:IssueDate'), IssueDate);
    TXmlWriter.WriteString(Node.AddChild('b:ProviderName'), ProviderName);
    TXmlWriter.WriteStringNullable(Node.AddChild('b:RegionCode'), RegionCode);
    TXmlWriter.WriteDateTimeNullable(Node.AddChild('b:StartDate'), StartDate);
end;

{ TPersonObject }

constructor TPersonObject.Create(const AGivenName, AMiddleName, AFamilyName: String; const ASex: Integer; const ABirthDate: TDateTime; const AIdPersonMis: String);
begin
    FGivenName := AGivenName;
    FMiddleName := AMiddleName;
    FFamilyName := AFamilyName;
    FSex := ASex;
    FBirthDate := ABirthDate;
    FIdPersonMis := AIdPersonMis;
    FDocuments := TObjectList<TIdentityDocumentObject>.Create(True);
end;

destructor TPersonObject.Destroy;
begin
    FDocuments.Free;
    inherited;
end;

function TPersonObject.AddDocument(const AItem: TIdentityDocumentObject): Integer;
begin
    Result := FDocuments.Add(AItem);
end;

procedure TPersonObject.ClearDocuments;
begin
    FDocuments.Clear;
end;

procedure TPersonObject.SaveToXml(const ANode: IXmlNode);
var
    HumanNameNode, DocumentsNode: IXmlNode;
    Index: Integer;
begin

    HumanNameNode := ANode.AddChild('b:HumanName');
    TXmlWriter.WriteString(HumanNameNode.AddChild('b:GivenName'), GivenName);
    TXmlWriter.WriteStringNullable(HumanNameNode.AddChild('b:MiddleName'), MiddleName);
    TXmlWriter.WriteString(HumanNameNode.AddChild('b:FamilyName'), FamilyName);

    TXmlWriter.WriteIntegerNullable(ANode.AddChild('b:Sex'), Sex);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('b:Birthdate'), BirthDate);
    TXmlWriter.WriteString(ANode.AddChild('b:IdPersonMis'), IdPersonMis);

    DocumentsNode := ANode.AddChild('b:Documents');
    if Documents.Count = 0
    then TXmlWriter.WriteNull(DocumentsNode)
    else begin
        for Index := 0 to Documents.Count - 1 do
            Documents[Index].SaveToXml(DocumentsNode);
    end;

end;

end.
