{***************************************************************************************************
* Тип StepBase
* Комплексный тип StepBase является базовым для передачи информации об эпизоде случая медицинского обслуживания и наследуется такими
* дочерними типами как:
* Тип StepAmb – использумым для передачи эпизода амбулаторного случая обслуживания.
* Тип StepStat – использумым для передачи эпизода стационарного случая обслуживания.
* При передаче информации по эпизоду случая обслуживания вне объекта caseDto (см. метод AddStepToCase) указывается для объекта step
* соответствующее значение атрибута xsi:type (используется для указания в явном виде типа наследуемого объекта от базового объекта StepBase;
* подробнее про xsi:type – см. http://www.w3.org/TR/xmlschema-1/#xsi_type): StepAmb для амбулаторного эпизода случая обслуживания и StepStat
* для стационарного эпизода случая обслуживания соответственно.
* Комплексный тип StepBase содержит базовую информацию об эпизодах случая медицинского обслуживания, таких как движения по отделениям,
* назначенные препараты, сведения об оказанных услугах или сформированных документах.
* Описание типа StepBase представлено в таблице.
* DateStart      1..1	DateTime      Дата начала эпизода
* DateEnd        1..1	DateTime      Дата окончания эпизода
* Comment        0..1	String        Текстовый комментарий
* IdPaymentType  0..1	Integer       Идентификатор источника финансирования (Справочник OID: 1.2.643.2.69.1.1.1.32)
* Doctor         1..1	MedicalStaff  Информация о враче
* IdStepMis      1..1	String        Идентификатор эпизода случая медицинского обслуживания в передающей МИС
***************************************************************************************************}
unit StepBaseUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedicalStaffUnit;

type
    TStepBaseObject = class
    private
        FDateStart: TDateTime;
        FDateEnd: TDateTime;
        FComment: String;
        FIdPaymentType: Integer;
        FDoctor: TMedicalStaffObject;
        FIdStepMis: String;
    public
        property DateStart: TDateTime read FDateStart;
        property DateEnd: TDateTime read FDateEnd;
        property Comment: String read FComment;
        property IdPaymentType: Integer read FIdPaymentType;
        property Doctor: TMedicalStaffObject read FDoctor;
        property IdStepMis: String read FIdStepMis;
        constructor Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
            const ADoctor: TMedicalStaffObject; const AIdStepMis: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); virtual;
    end;

implementation

uses XmlWriterUnit;

{ TStepBaseObject }

constructor TStepBaseObject.Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
    const ADoctor: TMedicalStaffObject; const AIdStepMis: String);
begin
    FDateStart := ADateStart;
    FDateEnd := ADateEnd;
    FComment := AComment;
    FIdPaymentType := AIdPaymentType;
    FDoctor := ADoctor;
    FIdStepMis := AIdStepMis;
end;

destructor TStepBaseObject.Destroy;
begin
    FDoctor.Free;
    inherited;
end;

procedure TStepBaseObject.SaveToXml(const ANode: IXmlNode);
var
   Node: IXmlNode;
begin
   TXmlWriter.WriteDateTime(ANode.AddChild('s:DateStart'), DateStart);
   TXmlWriter.WriteDateTime(ANode.AddChild('s:DateEnd'), DateEnd);
   TXmlWriter.WriteStringNullable(ANode.AddChild('s:Comment'), Comment);
   TXmlWriter.WriteIntegerNullable(ANode.AddChild('s:IdPaymentType'), IdPaymentType);

   Node := ANode.AddChild('s:Doctor');
   if Doctor = nil
   then TXmlWriter.WriteNull(Node)
   else Doctor.SaveToXml(Node);

   TXmlWriter.WriteString(ANode.AddChild('s:IdStepMis'), IdStepMis);
end;

end.
