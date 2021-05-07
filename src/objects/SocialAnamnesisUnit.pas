{***************************************************************************************************
* Тип Disability
* Комплексный тип Disability служит для передачи сведений о наличии инвалидности у пациента. В таблице представлено описание комплексного
* типа Disability.
* Code   1..1  Integer   Код группы инвалидности (Льготные категории населения, OID 1.2.643.5.1.13.13.11.1050)
* Date   1..1  DateTime  Дата\время установления инвалидности
* Order  0..1  Integer   Порядок установления инвалидности, OID 1.2.643.5.1.13.13.11.1041
*
* Тип Privilege
* Комплексный тип Privilege предназначен для передачи данных о наличии льгот у пациента. Описание параметров типа Privilege представлено в таблице
* Code   1..1  Integer   Код категории льготы (Льготные категории населения, OID 1.2.643.5.1.13.13.11.1050)
* Start  1..1  DateTime  Дата\время начала действия льготы
* End    1..1  DateTime  Дата\время окончания действия льготы
*
* Тип SocialGroup
* Комплексный тип SocialGroup предназначен для передачи данных о занятости пациента.
* Code  1..1  Integer  Код занятости (Занятость (социальные группы) населения, OID 1.2.643.5.1.13.13.11.1038)
* Text  1..1  String   Текстовое описание занятости (место и должность работы)
*
* Тип SocialAnamnesis
* Комплексный тип SocialAnamnesis является базовым для передачи важной анамнестической информации о пациенте. Описание параметров типа
* SocialAnamnesis представлено в таблице
* BadHabits            0..*  Integer      Код вредной привычки/зависимости (Вредные привычки и зависимости, OID 1.2.643.5.1.13.13.11.1058)
* Disability           0..1  Disability   Кодирование инвалидности
* OccupationalHazards  0..*  Integer      Кодирование профессиональных вредностей (Профессиональные вредности, OID 1.2.643.5.1.13.13.11.1060)
* Privileges           0..*  Privilege    Список льгот
* RegistryArea         0..1  Integer      Код местности регистрации (Признак жителя города или села, OID 1.2.643.5.1.13.13.11.1042)
* SocialGroup          0..1  SocialGroup  Код местности регистрации (Признак жителя города или села, OID 1.2.643.5.1.13.13.11.1042)
* SocialRiskFactors    0..*  Integer      Кодирование потенциально-опасных для здоровья социальных факторов (Потенциально-опасные соцфакторы, OID 1.2.643.5.1.13.13.11.1059)
***************************************************************************************************}
unit SocialAnamnesisUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TDisabilityObject = class
    private
        FCode: Integer;
        FDate: TDateTime;
        FOrder: Integer;
    public
        property Code: Integer read FCode;
        property Date: TDateTime read FDate;
        property Order: Integer read FOrder;
        constructor Create(const ACode: Integer; const ADate: TDateTime; const AOrder: Integer);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TPrivilegeObject = class
    private
        FCode: Integer;
        FDateStart: TDateTime;
        FDateEnd: TDateTime;
    public
        property Code: Integer read FCode;
        property DateStart: TDateTime read FDateStart;
        property DateEnd: TDateTime read FDateEnd;
        constructor Create(const ACode: Integer; const ADateStart, ADateEnd: TDateTime);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TSocialGroupObject = class
    private
        FCode: Integer;
        FText: String;
    public
        property Code: Integer read FCode;
        property Text: String read FText;
        constructor Create(const ACode: Integer; const AText: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TSocialAnamnesisObject = class (TMedRecordObject)
    private
        FBadHabits: TList<Integer>;
        FDisability: TDisabilityObject;
        FOccupationalHazards: TList<Integer>;
        FPrivileges: TObjectList<TPrivilegeObject>;
        FRegistryArea: Integer;
        FSocialGroup: TSocialGroupObject;
        FSocialRiskFactors: TList<Integer>;
    public
        property BadHabits: TList<Integer> read FBadHabits;
        property Disability: TDisabilityObject read FDisability;
        property OccupationalHazards: TList<Integer> read FOccupationalHazards;
        property Privileges: TObjectList<TPrivilegeObject> read FPrivileges;
        property RegistryArea: Integer read FRegistryArea;
        property SocialGroup: TSocialGroupObject read FSocialGroup;
        property SocialRiskFactors: TList<Integer> read FSocialRiskFactors;
        constructor Create(const ADisability: TDisabilityObject; const ARegistryArea: Integer; const ASocialGroup: TSocialGroupObject);
        destructor Destroy; override;
        function AddBadHabit(const AValue: Integer): Integer;
        procedure ClearBadHabbits;
        function AddOccupationalHazard(const AValue: Integer): Integer;
        procedure ClearOccupationalHazards;
        function AddPrivilege(const AItem: TPrivilegeObject): Integer;
        procedure ClearPrivileges;
        function AddSocialRiskFactor(const AValue: Integer): Integer;
        procedure ClearSocialRskFactors;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TDisabilityObject }

constructor TDisabilityObject.Create(const ACode: Integer; const ADate: TDateTime; const AOrder: Integer);
begin
    FCode := ACode;
    FDate := ADate;
    FOrder := AOrder;
end;

procedure TDisabilityObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:Code'), Code);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Date'), Date);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:Order'), Order);
end;

{ TPrivilegeObject }

constructor TPrivilegeObject.Create(const ACode: Integer; const ADateStart, ADateEnd: TDateTime);
begin
    FCode := ACode;
    FDateStart := ADateStart;
    FDateEnd := ADateEnd;
end;

procedure TPrivilegeObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:Code'), Code);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Start'), DateStart);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:End'), DateEnd);
end;

{ TSocialGroupObject }

constructor TSocialGroupObject.Create(const ACode: Integer; const AText: String);
begin
    FCode := ACode;
    FText := AText;
end;

procedure TSocialGroupObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:Code'), Code);
    TXmlWriter.WriteString(ANode.AddChild('m:Text'), Text);
end;

{ TSocialAnamnesisObject }

constructor TSocialAnamnesisObject.Create(const ADisability: TDisabilityObject; const ARegistryArea: Integer; const ASocialGroup: TSocialGroupObject);
begin
    FDisability := ADisability;
    FRegistryArea := ARegistryArea;
    FSocialGroup := ASocialGroup;
    FBadHabits := TList<Integer>.Create;
    FOccupationalHazards := TList<Integer>.Create;
    FPrivileges := TObjectList<TPrivilegeObject>.Create(True);
    FSocialRiskFactors := TList<Integer>.Create;
end;

destructor TSocialAnamnesisObject.Destroy;
begin
    FSocialRiskFactors.Free;
    FSocialGroup.Free;
    FPrivileges.Free;
    FOccupationalHazards.Free;
    FDisability.Free;
    FBadHabits.Free;
    inherited;
end;

function TSocialAnamnesisObject.AddBadHabit(const AValue: Integer): Integer;
begin
    Result := BadHabits.Add(AValue);
end;

procedure TSocialAnamnesisObject.ClearBadHabbits;
begin
    BadHabits.Clear;
end;

function TSocialAnamnesisObject.AddOccupationalHazard(const AValue: Integer): Integer;
begin
    Result := OccupationalHazards.Add(AValue);
end;

procedure TSocialAnamnesisObject.ClearOccupationalHazards;
begin
    OccupationalHazards.Clear;
end;

function TSocialAnamnesisObject.AddPrivilege(const AItem: TPrivilegeObject): Integer;
begin
    Result := Privileges.Add(AItem);
end;

procedure TSocialAnamnesisObject.ClearPrivileges;
begin
    Privileges.Clear;
end;

function TSocialAnamnesisObject.AddSocialRiskFactor(const AValue: Integer): Integer;
begin
    Result := SocialRiskFactors.Add(AValue);
end;

procedure TSocialAnamnesisObject.ClearSocialRskFactors;
begin
    SocialRiskFactors.Clear;
end;

procedure TSocialAnamnesisObject.SaveToXml(const ANode: IXmlNode);
var
    BadHabitsNode, DisabilityNode, OccupationalHazardsNode, PrivilegesNode, SocialGroupNode, SocialRiskFactorsNode: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:SocialAnamnesis');

    inherited SaveToXml(ANode);

    BadHabitsNode := ANode.AddChild('m:BadHabits');
    if BadHabits.Count = 0
    then TXmlWriter.WriteNull(BadHabitsNode)
    else begin
        for Index := 0 to BadHabits.Count - 1 do
            TXmlWriter.WriteInteger(BadHabitsNode.AddChild('m:BadHabit'), BadHabits[Index]);
    end;

    DisabilityNode := ANode.AddChild('m:Disability');
    if Disability = nil
    then TXmlWriter.WriteNull(DisabilityNode)
    else Disability.SaveToXml(DisabilityNode);

    OccupationalHazardsNode := ANode.AddChild('m:OccupationalHazards');
    if OccupationalHazards.Count = 0
    then TXmlWriter.WriteNull(OccupationalHazardsNode)
    else begin
        for Index := 0 to OccupationalHazards.Count - 1 do
            TXmlWriter.WriteInteger(OccupationalHazardsNode.AddChild('m:OccupationalHazard'), OccupationalHazards[Index]);
    end;

    PrivilegesNode := ANode.AddChild('m:Privileges');
    if Privileges.Count = 0
    then TXmlWriter.WriteNull(PrivilegesNode)
    else begin
        for Index := 0 to Privileges.Count - 1 do
           Privileges[Index].SaveToXml(PrivilegesNode);
    end;

    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:RegistryArea'), RegistryArea);

    SocialGroupNode := ANode.AddChild('m:SocialGroup');
    if SocialGroup = nil
    then TXmlWriter.WriteNull(SocialGroupNode)
    else SocialGroup.SaveToXml(SocialGroupNode);

    SocialRiskFactorsNode := ANode.AddChild('m:SocialRiskFactors');
    if SocialRiskFactors.Count = 0
    then TXmlWriter.WriteNull(SocialRiskFactorsNode)
    else begin
        for Index := 0 to SocialRiskFactors.Count - 1 do
            TXmlWriter.WriteInteger(SocialRiskFactorsNode.AddChild('m:SocialRiskFactor'), SocialRiskFactors[Index]);
    end;
end;

end.
