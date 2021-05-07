{***************************************************************************************************
* Тип DiagnosisInfo
* Компдексный тип DiagnosisInfo предназначен для передачи сведений о диагнозе как сведений о состоянии пациента.
* IdDiseaseType             0..1  Integer   Идентификатор характеров заболеваний (Справочник OID: 1.2.643.2.69.1.1.1.8)
* DiagnosedDate             1..1  DateTime  Дата постановки диагноза
* IdDiagnosisType           1..1  Integer   Идентификатор статуса диагноза (Справочнк OID: 1.2.643.2.69.1.1.1.26)
* Comment                   1..1  String    Комментарий к диагнозу
* DiagnosisChangeReason     0..1  Integer   Причина изменения диагноза (для ранее зарегистрированного диагноза) (Справочник OID: 1.2.643.2.69.1.1.1.9)
* DiagnosisStage            0..1  Integer   Идентификатор этапа установления диагноза (Справочник OID: 1.2.643.2.69.1.1.1.10)
* IdDispensaryState         0..1  Integer   Идентификатор состояния диспансерного учета по данному диагнозу (заболеванию) (Справочник OID: 1.2.643.2.69.1.1.1.11)
* IdTraumaType              0..1  Integer   Идентификатор типа травм (Справочник OID: 1.2.643.2.69.1.1.1.12)
* MESImplementationFeature  0..1  Integer   Идентификатор особенности выполнения стандарта (Справочник OID: 1.2.643.2.69.1.1.1.13)
* MedicalStandard           0..1  Integer   Код стандарта учета оказания медицинской помощи (Справочник OID: 1.2.643.2.69.1.1.1.29
* MkbCode                   1..1  String    Код заболевания по МКБ-10 (Справочник OID: 1.2.643.2.69.1.1.1.2)
*
* Тип Diagnosis
* Комплексный тип Diagnosis используется для передачи информации о диагнозе и лице, его поставившем. Наследуемыми типами для Diagnosis
* являются: ClinicMainDiagnosis – заключительный диагноз; AnatomopathologicalClinicMainDiagnosis – патологоанатомический диагноз.
* В таблице представлено описание комплексного типа Diagnosis.
* DiagnosisInfo  1..1  DiagnosisInfo  Диагноз
* Doctor         1..1  MedicalStaff   Сведения о медицинском работнике
*
* Тип ClinicMainDiagnosis
* Объект ClinicMainDiagnosis используется для передачи информации об основном диагнозе (при отсутствии летального исхода). Объект
* ClinicMainDiagnosis является наследуемым от объекта Diagnosis и имеет возможность передавать вложенные объекты типа Diagnosis (например,
* таким образом можно передать основной диагноз, а также его осложнение и сопутствующее заболевание). Описание параметров объекта
* ClinicMainDiagnosis представлено в таблице.
* Complications  0..*  Diagnosis  Массив диагнозов (данные об осложнении или сопутствующем заболевании)
* Внимание
* Не допускается передавать в параметре Complications диагнозы с типом "Основной диагноз" (IdDiagnosisType=1)
*
* Тип AnatomopathologicalClinicMainDiagnosis
* Объект AnatomopathologicalClinicMainDiagnosis предназначен для передачи информации о патологоанатомических диагнозах (основном диагнозе,
* его осложнении и сопутствующем заболевании). Тип AnatomopathologicalClinicMainDiagnosis является полным аналогом типа ClinicMainDiagnosis.
***************************************************************************************************}
unit DiagnosisUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit;

type
    TDiagnosisInfoObject = class
    private
        FIdDiseaseType: Integer;
        FDiagnosedDate: TDateTime;
        FIdDiagnosisType: Integer;
        FComment: String;
        FDiagnosisChangeReason: Integer;
        FDiagnosisStage: Integer;
        FIdDispensaryState: Integer;
        FIdTraumaType: Integer;
        FMESImplementationFeature: Integer;
        FMedicalStandard: Integer;
        FMkbCode: String;
    public
        property IdDiseaseType: Integer read FIdDiseaseType;
        property DiagnosedDate: TDateTime read FDiagnosedDate;
        property IdDiagnosisType: Integer read FIdDiagnosisType;
        property Comment: String read FComment;
        property DiagnosisChangeReason: Integer read FDiagnosisChangeReason;
        property DiagnosisStage: Integer read FDiagnosisStage;
        property IdDispensaryState: Integer read FIdDispensaryState;
        property IdTraumaType: Integer read FIdTraumaType;
        property MESImplementationFeature: Integer read FMESImplementationFeature;
        property MedicalStandard: Integer read FMedicalStandard;
        property MkbCode: String read FMkbCode;
        constructor Create(const AIdDiseaseType: Integer; const ADiagnosedDate: TDateTime; const AIdDiagnosisType: Integer;
            const AComment: String; const ADiagnosisChangeReason, ADiagnosisStage, AIdDispensaryState, AIdTraumaType,
            AMESImplementationFeature, AMedicalStandard: Integer; const AMkbCode: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TDiagnosisObject = class (TMedRecordObject)
    private
        FDiagnosisInfo: TDiagnosisInfoObject;
        FDoctor: TMedicalStaffObject;
    public
        property DiagnosisInfo: TDiagnosisInfoObject read FDiagnosisInfo;
        property Doctor: TMedicalStaffObject read FDoctor;
        constructor Create(const ADiagnosisInfo: TDiagnosisInfoObject; const ADoctor: TMedicalStaffObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TClinicMainDiagnosisObject = class (TDiagnosisObject)
    private
        FComplications: TObjectList<TDiagnosisObject>;
    public
        property Complications: TObjectList<TDiagnosisObject> read FComplications;
        constructor Create(const ADiagnosisInfo: TDiagnosisInfoObject; const ADoctor: TMedicalStaffObject);
        destructor Destroy; override;
        function AddComlication(const AItem: TDiagnosisObject): Integer;
        procedure ClearComplications;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TAnatomopathologicalClinicMainDiagnosisObject = class (TClinicMainDiagnosisObject)
    public
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TDiagnosisInfoObject }

constructor TDiagnosisInfoObject.Create(const AIdDiseaseType: Integer; const ADiagnosedDate: TDateTime; const AIdDiagnosisType: Integer;
    const AComment: String; const ADiagnosisChangeReason, ADiagnosisStage, AIdDispensaryState, AIdTraumaType, AMESImplementationFeature,
    AMedicalStandard: Integer; const AMkbCode: String);
begin
    FIdDiseaseType := AIdDiseaseType;
    FDiagnosedDate := ADiagnosedDate;
    FIdDiagnosisType := AIdDiagnosisType;
    FComment := AComment;
    FDiagnosisChangeReason := ADiagnosisChangeReason;
    FDiagnosisStage := ADiagnosisStage;
    FIdDispensaryState := AIdDispensaryState;
    FIdTraumaType := AIdTraumaType;
    FMESImplementationFeature := AMESImplementationFeature;
    FMedicalStandard := AMedicalStandard;
    FMkbCode := AMkbCode;
end;

procedure TDiagnosisInfoObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:IdDiseaseType'), IdDiseaseType);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:DiagnosedDate'), DiagnosedDate);
    TXmlWriter.WriteInteger(ANode.AddChild('m:IdDiagnosisType'), IdDiagnosisType);
    TXmlWriter.WriteString(ANode.AddChild('m:Comment'), Comment);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:DiagnosisChangeReason'), DiagnosisChangeReason);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:DiagnosisStage'), DiagnosisStage);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:IdDispensaryState'), IdDispensaryState);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:IdTraumaType'), IdTraumaType);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:MESImplementationFeature'), MESImplementationFeature);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('m:MedicalStandard'), MedicalStandard);
    TXmlWriter.WriteString(ANode.AddChild('m:MkbCode'), MkbCode);
end;

{ TDiagnosisObject }

constructor TDiagnosisObject.Create(const ADiagnosisInfo: TDiagnosisInfoObject; const ADoctor: TMedicalStaffObject);
begin
    FDiagnosisInfo := ADiagnosisInfo;
    FDoctor := ADoctor;
end;

destructor TDiagnosisObject.Destroy;
begin
    FDoctor.Free;
    FDiagnosisInfo.Free;
    inherited;
end;

procedure TDiagnosisObject.SaveToXml(const ANode: IXmlNode);
var
    DiagnosisInfoNode, DoctorNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'md:Diagnosis');

    DiagnosisInfoNode := ANode.AddChild('m:DiagnosisInfo');
    if DiagnosisInfo = nil
    then TXmlWriter.WriteNull(DiagnosisInfoNode)
    else DiagnosisInfo.SaveToXml(DiagnosisInfoNode);

    DoctorNode := ANode.AddChild('m:Doctor');
    if Doctor = nil
    then TXmlWriter.WriteNull(DoctorNode)
    else Doctor.SaveToXml(DoctorNode);
end;

{ TClinicMainDiagnosisObject }

constructor TClinicMainDiagnosisObject.Create(const ADiagnosisInfo: TDiagnosisInfoObject; const ADoctor: TMedicalStaffObject);
begin
    inherited Create(ADiagnosisInfo, ADoctor);
    FComplications := TObjectList<TDiagnosisObject>.Create(True);
end;

destructor TClinicMainDiagnosisObject.Destroy;
begin
    FComplications.Free;
    inherited;
end;

function TClinicMainDiagnosisObject.AddComlication(const AItem: TDiagnosisObject): Integer;
begin
    Result := FComplications.Add(AItem);
end;

procedure TClinicMainDiagnosisObject.ClearComplications;
begin
    FComplications.Free;
end;

procedure TClinicMainDiagnosisObject.SaveToXml(const ANode: IXmlNode);
var
    ComplicationsNode: IXmlNode;
    Index: Integer;
begin
    inherited SaveToXml(ANode);

    TXmlWriter.WriteAttrString(ANode, 'i:type', 'md:ClinicMainDiagnosis'); // rewrite md:Diagnosis

    ComplicationsNode := ANode.AddChild('m:Complications');
    if Complications.Count = 0
    then TXmlWriter.WriteNull(ComplicationsNode)
    else begin
        for Index := 0 to Complications.Count - 1 do
            Complications[Index].SaveToXml(ComplicationsNode);
    end;
end;

{ TAnatomopathologicalClinicMainDiagnosisObject }

procedure TAnatomopathologicalClinicMainDiagnosisObject.SaveToXml(const ANode: IXmlNode);
begin
    inherited SaveToXml(ANode);
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'md:AnatomopathologicalClinicMainDiagnosis'); // rewrite 'md:ClinicMainDiagnosis'


end;

end.
