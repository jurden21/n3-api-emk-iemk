{***************************************************************************************************
* Тип StepStat
* Комплексный тип StepStat используется для передачи данных эпизода стационарного случая обслуживания. Тип наследуется от StepBase и имеет
* дополнительные параметры. Параметры типа StepStat приведены в таблице.
* HospitalDepartmentName  1..1  String     Наименование отделения
* IdHospitalDepartment    1..1  String     Код отделения (Регистрационный код отделения в МО (возможно, из паспорта ЛПУ))
* IdRegimen               0..1  Integer    Идентификатор режима лечения (Справочник OID: 1.2.643.2.69.1.1.1.25)
* WardNumber              0..1  String     Номер палаты
* BedNumber               0..1  String     Номер койки
* BedProfile              1..1  Integer    Профиль койки (Справочник OID: 1.2.643.5.1.13.2.1.1.221)
* DaySpend                1..1  Integer    Кол-во проведенных койко-дней
* MedRecords              0..1  MedRecord  Массив MedRecord, доступных для эпизода амбулаторного случая обслуживания. Перечень допустимых
*                                          атрибутов приведен в соответствующем разделе документации.
***************************************************************************************************}
unit StepStatUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, StepBaseUnit, MedRecordUnit, MedicalStaffUnit;

type
    TStepStatObject = class (TStepBaseObject)
    private
        FHospitalDepartmentName: String;
        FIdHospitalDepartment: String;
        FIdRegimen: Integer;
        FWardNumber: String;
        FBedNumber: String;
        FBedProfile: Integer;
        FDaySpend: Integer;
        FMedRecords: TObjectList<TMedRecordObject>;
    public
        property HospitalDepartmentName: String read FHospitalDepartmentName;
        property IdHospitalDepartment: String read FIdHospitalDepartment;
        property IdRegimen: Integer read FIdRegimen;
        property WardNumber: String read FWardNumber;
        property BedNumber: String read FBedNumber;
        property BedProfile: Integer read FBedProfile;
        property DaySpend: Integer read FDaySpend;
        property MedRecords: TObjectList<TMedRecordObject> read FMedRecords;
        constructor Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
            const ADoctor: TMedicalStaffObject; const AIdStepMis, AHospitalDepartmentName, AIdHospitalDepartment: String;
            const AIdRegimen: Integer; const AWardNumber, ABedNumber: String; const ABedProfile, ADaySpend: Integer);
        destructor Destroy; override;
        function AddMedRecord(const AItem: TMedRecordObject): Integer;
        procedure ClearMedRecords;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

{ TStepStatObject }

uses XmlWriterUnit;

constructor TStepStatObject.Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
    const ADoctor: TMedicalStaffObject; const AIdStepMis, AHospitalDepartmentName, AIdHospitalDepartment: String; const AIdRegimen: Integer;
    const AWardNumber, ABedNumber: String; const ABedProfile, ADaySpend: Integer);
begin
    inherited Create(ADateStart, ADateEnd, AComment, AIdPaymentType, ADoctor, AIdStepMis);

    FHospitalDepartmentName := AHospitalDepartmentName;
    FIdHospitalDepartment := AIdHospitalDepartment;
    FIdRegimen := AIdRegimen;
    FWardNumber := AWardNumber;
    FBedNumber := ABedNumber;
    FBedProfile := ABedProfile;
    FDaySpend := ADaySpend;

    FMedRecords := TObjectList<TMedRecordObject>.Create(True);
end;

destructor TStepStatObject.Destroy;
begin
    FMedRecords.Free;
    inherited;
end;

function TStepStatObject.AddMedRecord(const AItem: TMedRecordObject): Integer;
begin
    Result := MedRecords.Add(AItem);
end;

procedure TStepStatObject.ClearMedRecords;
begin
    MedRecords.Clear;
end;

procedure TStepStatObject.SaveToXml(const ANode: IXmlNode);
var
    Node: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 's:StepStat');

    inherited SaveToXml(ANode);

    TXmlWriter.WriteString(ANode.AddChild('s:HospitalDepartmentName'), HospitalDepartmentName);
    TXmlWriter.WriteString(ANode.AddChild('s:IdHospitalDepartment'), IdHospitalDepartment);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('s:IdRegimen'), IdRegimen);
    TXmlWriter.WriteStringNullable(ANode.AddChild('s:WardNumber'), WardNumber);
    TXmlWriter.WriteStringNullable(ANode.AddChild('s:BedNumber'), BedNumber);
    TXmlWriter.WriteInteger(ANode.AddChild('s:BedProfile'), BedProfile);
    TXmlWriter.WriteInteger(ANode.AddChild('s:DaySpend'), DaySpend);

    Node := ANode.AddChild('s:MedRecords');
    if MedRecords.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MedRecords.Count - 1 do
            MedRecords[Index].SaveToXml(Node.AddChild('MedRecord'));
    end;
end;

end.
