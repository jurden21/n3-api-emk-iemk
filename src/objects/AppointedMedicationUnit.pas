{***************************************************************************************************
* Тип Quantity
* Комплексный тип Quantity предназначен для передачи данных о дозировке лекарственных средств.
* IdUnit  1..1 Integer  Идентификатор едицины измерения (Справочник OID: 1.2.643.5.1.13.2.1.1.180)
* Value   1..1 Decimal  Количественное значение
*
* Тип AppointedMedication
* Комплексный тип AppointedMedication предназначен для передачи данных о назначенных препаратах. Объекты типа AppointedMedication
* передаются в рамках эпизода случая обслуживания. Описание параметров объекта AppointedMedication представлено в таблице.
* AnatomicTherapeuticChemicalClassification  0..1  String        Сведения о препарате (активном веществе) (Справочник OID: 1.2.643.5.1.13.2.1.1.56)
* CourseDose                                 0..1  Quantity      Курсовая доза
* DayDose                                    0..1  Quantity      Суточная доза (Обязателен, если передается параметр DaysCount)
* DaysCount                                  0..1  Integer       Количество дней лечения (Обязателен, если передается контейнер DayDose)
* Doctor                                     1..1  MedicalStaff  Медицинский работник, зарегистрировавший рецепт/ назначивший препарат
* IssuedDate                                 1..1  DateTime      Дата выдачи рецепта /назначения на препарат
* MedicineIssueType                          0..1  String        Тип выдачи препарата (Справочник OID: 1.2.643.5.1.13.2.7.1.36)
* MedicineName                               1..1  String        Наименование препарата
* MedicineType                               0..1  Integer       Лекарственная форма препарата (Справочник OID: 1.2.643.5.1.13.2.1.1.331)
* MedicineUseWay                             0..1  Integer       Способ введения медикамента (способ применения) (Справочник OID: 1.2.643.5.1.13.2.7.1.64)
* Number                                     0..1  String        Номер рецепта/назначения
* OneTimeDose                                0..1  Quantity      Разовая доза
* idINN                                      1..1  Integer       Код лекарственного средства (Справочник OID: 1.2.643.5.1.13.2.1.1.179)
* Seria                                      0..1  String        Серия рецепта/назначения
***************************************************************************************************}
unit AppointedMedicationUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit;

type
    TQuantityObject = class
    private
        FIdUnit: Integer;
        FValue: Real;
    public
        property IdUnit: Integer read FIdUnit;
        property Value: Real read FValue;
        constructor Create(const AIdUnit: Integer; const AValue: Real);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TAppointedMedicationObject = class (TMedRecordObject)
    private
        FATC: String;
        FCourseDose: TQuantityObject;
        FDayDose: TQuantityObject;
        FDaysCount: Integer;
        FDoctor: TMedicalStaffObject;
        FIssuedDate: TDateTime;
        FMedicineIssueType: String;
        FMedicineName: String;
        FMedicineType: Integer;
        FMedicineUseWay: Integer;
        FNumber: String;
        FOneTimeDose: TQuantityObject;
        FIdINN: Integer;
        FSeria: String;
    public
        property ATC: String read FATC;
        property CourseDose: TQuantityObject read FCourseDose;
        property DayDose: TQuantityObject read FDayDose;
        property DaysCount: Integer read FDaysCount;
        property Doctor: TMedicalStaffObject read FDoctor;
        property IssuedDate: TDateTime read FIssuedDate;
        property MedicineIssueType: String read FMedicineIssueType;
        property MedicineName: String read FMedicineName;
        property MedicineType: Integer read FMedicineType;
        property MedicineUseWay: Integer read FMedicineUseWay;
        property Number: String read FNumber;
        property OneTimeDose: TQuantityObject read FOneTimeDose;
        property IdINN: Integer read FIdINN;
        property Seria: String read FSeria;
        constructor Create(const AATC: String; const ACourseDose, ADayDose: TQuantityObject; const ADaysCount: Integer;
            const ADoctor: TMedicalStaffObject; const AIssuedDate: TDateTime; const AMedicineIssueType, AMedicineName: String;
            const AMedicineType, AMedicineUseWay: Integer; const ANumber: String; const AOneTimeDose: TQuantityObject;
            const AIdINN: Integer; const ASeria: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TQuantityObject }

constructor TQuantityObject.Create(const AIdUnit: Integer; const AValue: Real);
begin
    FIdUnit := AIdUnit;
    FValue := AValue;
end;

procedure TQuantityObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:IdUnit'), IdUnit);
    TXmlWriter.WriteFloat(ANode.AddChild('m:Value'), Value);
end;

{ TAppointedMedicationObject }

constructor TAppointedMedicationObject.Create(const AATC: String; const ACourseDose, ADayDose: TQuantityObject; const ADaysCount: Integer;
    const ADoctor: TMedicalStaffObject; const AIssuedDate: TDateTime; const AMedicineIssueType, AMedicineName: String; const AMedicineType,
    AMedicineUseWay: Integer; const ANumber: String; const AOneTimeDose: TQuantityObject; const AIdINN: Integer; const ASeria: String);
begin
    FATC := AATC;
    FCourseDose := ACourseDose;
    FDayDose := ADayDose;
    FDaysCount := ADaysCount;
    FDoctor := ADoctor;
    FIssuedDate := AIssuedDate;
    FMedicineIssueType := AMedicineIssueType;
    FMedicineName := AMedicineName;
    FMedicineType := AMedicineType;
    FMedicineUseWay := AMedicineUseWay;
    FNumber := ANumber;
    FOneTimeDose := AOneTimeDose;
    FIdINN := AIdINN;
    FSeria := ASeria;
end;

destructor TAppointedMedicationObject.Destroy;
begin
    FOneTimeDose.Free;
    FDoctor.Free;
    FDayDose.Free;
    FCourseDose.Free;
    inherited;
end;

procedure TAppointedMedicationObject.SaveToXml(const ANode: IXmlNode);
var
    CourceDoseNode, DayDoseNode, DoctorNode, OneTimeDoseNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:AppointedMedication');

    TXmlWriter.WriteStringNullable(ANode.AddChild('m:AnatomicTherapeuticChemicalClassification'), ATC);

    CourceDoseNode := ANode.AddChild('m:CourseDose');
    if CourseDose = nil
    then TXmlWriter.WriteNull(CourceDoseNode)
    else CourseDose.SaveToXml(CourceDoseNode);

    DayDoseNode := ANode.AddChild('m:DayDose');
    if DayDose = nil
    then TXmlWriter.WriteNull(DayDoseNode)
    else DayDose.SaveToXml(DayDoseNode);

    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:DaysCount'), DaysCount);

    DoctorNode := ANode.AddChild('m:Doctor');
    if Doctor = nil
    then TXmlWriter.WriteNull(DoctorNode)
    else Doctor.SaveToXml(DoctorNode);

    TXmlWriter.WriteDateTime(ANode.AddChild('m:IssuedDate'), IssuedDate);
    TXmlWriter.WriteStringNullable(ANode.AddChild('m:MedicineIssueType'), MedicineIssueType);
    TXmlWriter.WriteString(ANode.AddChild('m:MedicineName'), MedicineName);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:MedicineType'), MedicineType);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:MedicineUseWay'), MedicineUseWay);
    TXmlWriter.WriteStringNullable(ANode.AddChild('m:Number'), Number);

    OneTimeDoseNode := ANode.AddChild('m:DayDose');
    if OneTimeDose = nil
    then TXmlWriter.WriteNull(OneTimeDoseNode)
    else OneTimeDose.SaveToXml(OneTimeDoseNode);

    TXmlWriter.WriteInteger(ANode.AddChild('m:IdINN'), IdINN);
    TXmlWriter.WriteStringNullable(ANode.AddChild('m:Seria'), Seria);
end;

end.
