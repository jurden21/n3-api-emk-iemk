{***************************************************************************************************
* Подтип SurgicalTreatment
* SurgeryName           1..1  String    Название операции
* SurgeryDate           0..1  Datetime  Дата операции
* SurgeryСomplications  0..1  String    Осложнения операции
*
* Подтип Form027U
* Комплексеный тип Form027U используется для сбора маршрутных карт пациентов с подозрением на онкологическое заболевание в объеме формы
* 027-1/У с целью дальнейшей передачи в Городской регистр карт маршрутизации (в случае наличия в регионе). Объект типа Form027U может
* передаваться только в рамках стационарного случая обслуживания.
*
* IssuingInstitution                1..1  String             Код выдавшего учреждения. Региональный идентификатор МО, выдавшего выписку (значение поля code из Справочника МО региона OID 1.2.643.2.69.1.1.1.64)
* TargetMU                          0..1  String             Код целевого учреждения. Региональный идентификатор МО, куда направляется выписка (значение поля code из Справочника МО региона OID 1.2.643.2.69.1.1.1.64)
* StartDate                         1..1  Datetime           Дата начала случая
* EndDate                           1..1  Datetime           Дата завершения случая
* Duration                          0..1  Integer            Длительность случая в днях
* DiagnosFirstTime                  0..1  Integer            Первичность диагноза
* ServiceCaseGoal                   0..1  Integer            Цель случая
* MainDiagnos                       1..1  String             Код заболевания. Значение в соответствии с МКБ-10 (OID справочника: 1.2.643.2.69.1.1.1.2)
* MainDiagnosText                   0..1  String             Заключительный диагноз текст
* TopographyTumor                   0..1  Integer            Топография опухоли
* MorphologicalTypeTumor            0..1  Integer            Морфологический тип опухоли
* TNM_T                             0..1  String             TNM_T
* TNM_N                             0..1  String             TNM_N
* TNM_M                             0..1  String             TNM_M
* TumorStage                        0..1  Integer            Стадия опухолевого процесса
* LocalizationOfMetastases          0..*  Integer            Локализация отдаленных метастазов (IdLocalization)
* MethodConfirmingDiagnosis         0..*  Integer            Метод подтверждения диагноза (IdMethod)
* AttendantDiagnosis                0..1  String             Сопутствующие заболевания
* NatureDisease                     0..1  Integer            Характер заболевания
* CauseInterruption                 0..1  String             Причина незавершенности радикального лечения
* SurgicalTreatments                0..*  SurgicalTreatment  Хирургическое лечение
* SDRadiationTreatment              0..1  Datetime           Дата начала лучевого лечения
* TypeRadiationTreatment            0..1  Integer            Способ облучения
* TypeRadiationTreatmentText        0..1  String             Способ облучения (текст)
* ViewRadiationTreatment            0..1  Integer            Вид лучевой терапии
* ViewRadiationTreatmentText        0..1  String             Вид лучевой терапии (текст)
* MethodRadiationTreatment          0..*  Integer            Методы лучевой терапии (IdRadiationTreatment)
* RadioModifiers                    0..*  Integer            Радиомодификаторы (IdModifier)
* FieldsRadiationTreatment          0..1  String             Поля облучения
* TotalDose                         0..1  Integer            Суммарная доза на опухоль (гр.)
* MetastasesTotalDose               0..1  Integer            Суммарная доза на зоны регионарного метастазирования (гр.)
* СomplicationsRadiationTreatment   0..1  String             Осложнения лучевого лечения
* SDChemotherapy                    0..1  Datetime           Дата начала курса химиотерапии
* TypeChemotherapy                  0..1  Integer            Вид химиотерапии
* Chemotherapy_PreparationsDoses    0..1  String             Препараты, суммарные дозы
* СomplicationsTypeChemotherapy     0..1  String             Осложнения химиотерапевтического лечения
* SDHormonetherapy                  0..1  Datetime           Дата начала гормонотерапии
* TypeHormonetherapy                0..1  Integer            Вид гормонотерапии
* Hormonetherapy_PreparationsDoses  0..1  String             Препараты, дозы
* HormonetherapyTypeChemotherapy    0..1  String             Осложнения гормоноиммунотерапевтического лечения
* OtherSpecialTreatment             0..1  String             Другие виды специального лечения
* CaseFeatures                      0..1  String             Особенности случая
* Recommendations                   0..1  String             Лечебные и трудовые рекомендации
***************************************************************************************************}
unit Form027UUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, MedDocumentUnit, MedicalStaffUnit;

type
    TSurgicalTreatmentObject = class
    private
        FSurgeryName: String;
        FSurgeryDate: TDateTime;
        FSurgeryСomplications: String;
    public
        property SurgeryName: String read FSurgeryName;
        property SurgeryDate: TDateTime read FSurgeryDate;
        property SurgeryСomplications: String read FSurgeryСomplications;
        constructor Create(const ASurgeryName: String; const ASurgeryDate: TDateTime; const ASurgeryСomplications: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TForm027UObject = class (TMedDocumentObject)
    private
        FIssuingInstitution: String;
        FTargetMU: String;
        FStartDate: TDateTime;
        FEndDate: TDateTime;
        FDuration: Integer;
        FDiagnosFirstTime: Integer;
        FServiceCaseGoal: Integer;
        FMainDiagnos: String;
        FMainDiagnosText: String;
        FTopographyTumor: Integer;
        FMorphologicalTypeTumor: Integer;
        FTNMT: String;
        FTNMN: String;
        FTNMM: String;
        FTumorStage: Integer;
        FLocalizationOfMetastases: TList<Integer>;
        FMethodConfirmingDiagnosis: TList<Integer>;
        FAttendantDiagnosis: String;
        FNatureDisease: Integer;
        FCauseInterruption: String;
        FSurgicalTreatments: TObjectList<TSurgicalTreatmentObject>;
        FSDRadiationTreatment: TDateTime;
        FTypeRadiationTreatment: Integer;
        FTypeRadiationTreatmentText: String;
        FViewRadiationTreatment: Integer;
        FViewRadiationTreatmentText: String;
        FMethodRadiationTreatment: TList<Integer>;
        FRadioModifiers: TList<Integer>;
        FFieldsRadiationTreatment: String;
        FTotalDose: Integer;
        FMetastasesTotalDose: Integer;
        FСomplicationsRadiationTreatment: String;
        FSDChemotherapy: TDateTime;
        FTypeChemotherapy: Integer;
        FChemotherapyPreparationsDoses: String;
        FСomplicationsTypeChemotherapy: String;
        FSDHormonetherapy: TDateTime;
        FTypeHormonetherapy: Integer;
        FHormonetherapyPreparationsDoses: String;
        FHormonetherapyTypeChemotherapy: String;
        FOtherSpecialTreatment: String;
        FCaseFeatures: String;
        FRecommendations: String;
    public
        property IssuingInstitution: String read FIssuingInstitution;
        property TargetMU: String read FTargetMU;
        property StartDate: TDateTime read FStartDate;
        property EndDate: TDateTime read FEndDate;
        property Duration: Integer read FDuration;
        property DiagnosFirstTime: Integer read FDiagnosFirstTime;
        property ServiceCaseGoal: Integer read FServiceCaseGoal;
        property MainDiagnos: String read FMainDiagnos;
        property MainDiagnosText: String read FMainDiagnosText;
        property TopographyTumor: Integer read FTopographyTumor;
        property MorphologicalTypeTumor: Integer read FMorphologicalTypeTumor;
        property TNMT: String read FTNMT;
        property TNMN: String read FTNMN;
        property TNMM: String read FTNMM;
        property TumorStage: Integer read FTumorStage;
        property LocalizationOfMetastases: TList<Integer> read FLocalizationOfMetastases;
        property MethodConfirmingDiagnosis: TList<Integer> read FMethodConfirmingDiagnosis;
        property AttendantDiagnosis: String read FAttendantDiagnosis;
        property NatureDisease: Integer read FNatureDisease;
        property CauseInterruption: String read FCauseInterruption;
        property SurgicalTreatments: TObjectList<TSurgicalTreatmentObject> read FSurgicalTreatments;
        property SDRadiationTreatment: TDateTime read FSDRadiationTreatment;
        property TypeRadiationTreatment: Integer read FTypeRadiationTreatment;
        property TypeRadiationTreatmentText: String read FTypeRadiationTreatmentText;
        property ViewRadiationTreatment: Integer read FViewRadiationTreatment;
        property ViewRadiationTreatmentText: String read FViewRadiationTreatmentText;
        property MethodRadiationTreatment: TList<Integer> read FMethodRadiationTreatment;
        property RadioModifiers: TList<Integer> read FRadioModifiers;
        property FieldsRadiationTreatment: String read FFieldsRadiationTreatment;
        property TotalDose: Integer read FTotalDose;
        property MetastasesTotalDose: Integer read FMetastasesTotalDose;
        property СomplicationsRadiationTreatment: String read FСomplicationsRadiationTreatment;
        property SDChemotherapy: TDateTime read FSDChemotherapy;
        property TypeChemotherapy: Integer read FTypeChemotherapy;
        property ChemotherapyPreparationsDoses: String read FChemotherapyPreparationsDoses;
        property СomplicationsTypeChemotherapy: String read FСomplicationsTypeChemotherapy;
        property SDHormonetherapy: TDateTime read FSDHormonetherapy;
        property TypeHormonetherapy: Integer read FTypeHormonetherapy;
        property HormonetherapyPreparationsDoses: String read FHormonetherapyPreparationsDoses;
        property HormonetherapyTypeChemotherapy: String read FHormonetherapyTypeChemotherapy;
        property OtherSpecialTreatment: String read FOtherSpecialTreatment;
        property CaseFeatures: String read FCaseFeatures;
        property Recommendations: String read FRecommendations;
        constructor Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
            const AAuthor: TMedicalStaffObject; const AHeader: String; const AIssuingInstitution, ATargetMU: String; const AStartDate,
            AEndDate: TDateTime; const ADuration, ADiagnosFirstTime, AServiceCaseGoal: Integer; const AMainDiagnos, AMainDiagnosText: String;
            const ATopographyTumor, AMorphologicalTypeTumor: Integer; const ATNMT, ATNMN, ATNMM: String; const ATumorStage: Integer;
            const AAttendantDiagnosis: String; const ANatureDisease: Integer; const ACauseInterruption: String;
            const ASDRadiationTreatment: TDateTime; const ATypeRadiationTreatment: Integer; const ATypeRadiationTreatmentText: String;
            const AViewRadiationTreatment: Integer; const AViewRadiationTreatmentText, AFieldsRadiationTreatment: String;
            const ATotalDose, AMetastasesTotalDose: Integer; const AСomplicationsRadiationTreatment: String;
            const ASDChemotherapy: TDateTime; const ATypeChemotherapy: Integer; const AChemotherapyPreparationsDoses,
            AСomplicationsTypeChemotherapy: String; const ASDHormonetherapy: TDateTime; const ATypeHormonetherapy: Integer;
            const AHormonetherapyPreparationsDoses, AHormonetherapyTypeChemotherapy, AOtherSpecialTreatment, ACaseFeatures,
            ARecommendations: String);
        destructor Destroy; override;
        function AddLocalizationOfMetastase(const AValue: Integer): Integer;
        procedure ClearALocalizationOfMetastases;
        function AddMethodConfirmingDiagnosis(const AValue: Integer): Integer;
        procedure ClearMethodConfirmingDiagnosis;
        function AddSurgicalTreatment(const AItem: TSurgicalTreatmentObject): Integer;
        procedure ClearSurgicalTreatments;
        function AddMethodRadiationTreatment(const AValue: Integer): Integer;
        procedure ClearMethodRadiationTreatment;
        function AddRadioModifier(const AValue: Integer): Integer;
        procedure ClearRadioModifiers;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TSurgicalTreatmentObject }

constructor TSurgicalTreatmentObject.Create(const ASurgeryName: String; const ASurgeryDate: TDateTime; const ASurgeryСomplications: String);
begin
    FSurgeryName := ASurgeryName;
    FSurgeryDate := ASurgeryDate;
    FSurgeryСomplications := ASurgeryСomplications;
end;

procedure TSurgicalTreatmentObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteString(ANode.AddChild('mm:SurgeryName'), SurgeryName);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('mm:SurgeryDate'), SurgeryDate);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:SurgeryСomplications'), SurgeryСomplications);
end;

{ TForm027UObject }

constructor TForm027UObject.Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
    const AAuthor: TMedicalStaffObject; const AHeader: String; const AIssuingInstitution, ATargetMU: String; const AStartDate,
    AEndDate: TDateTime; const ADuration, ADiagnosFirstTime, AServiceCaseGoal: Integer; const AMainDiagnos, AMainDiagnosText: String;
    const ATopographyTumor, AMorphologicalTypeTumor: Integer; const ATNMT, ATNMN, ATNMM: String; const ATumorStage: Integer;
    const AAttendantDiagnosis: String; const ANatureDisease: Integer; const ACauseInterruption: String;
    const ASDRadiationTreatment: TDateTime; const ATypeRadiationTreatment: Integer; const ATypeRadiationTreatmentText: String;
    const AViewRadiationTreatment: Integer; const AViewRadiationTreatmentText, AFieldsRadiationTreatment: String;
    const ATotalDose, AMetastasesTotalDose: Integer; const AСomplicationsRadiationTreatment: String;
    const ASDChemotherapy: TDateTime; const ATypeChemotherapy: Integer; const AChemotherapyPreparationsDoses,
    AСomplicationsTypeChemotherapy: String; const ASDHormonetherapy: TDateTime; const ATypeHormonetherapy: Integer;
    const AHormonetherapyPreparationsDoses, AHormonetherapyTypeChemotherapy, AOtherSpecialTreatment, ACaseFeatures,
    ARecommendations: String);
begin
    inherited Create(ACreationDate, AIdDocumentMis, AAttachment, AAuthor, AHeader);

    FIssuingInstitution := AIssuingInstitution;
    FTargetMU := ATargetMU;
    FStartDate := AStartDate;
    FEndDate := AEndDate;
    FDuration := ADuration;
    FDiagnosFirstTime := ADiagnosFirstTime;
    FServiceCaseGoal := AServiceCaseGoal;
    FMainDiagnos := AMainDiagnos;
    FMainDiagnosText := AMainDiagnosText;
    FTopographyTumor := ATopographyTumor;
    FMorphologicalTypeTumor := AMorphologicalTypeTumor;
    FTNMT := ATNMT;
    FTNMN := ATNMN;
    FTNMM := ATNMM;
    FTumorStage := ATumorStage;
    FAttendantDiagnosis := AAttendantDiagnosis;
    FNatureDisease := ANatureDisease;
    FCauseInterruption := ACauseInterruption;
    FSDRadiationTreatment := ASDRadiationTreatment;
    FTypeRadiationTreatment := ATypeRadiationTreatment;
    FTypeRadiationTreatmentText := ATypeRadiationTreatmentText;
    FViewRadiationTreatment := AViewRadiationTreatment;
    FViewRadiationTreatmentText := AViewRadiationTreatmentText;
    FFieldsRadiationTreatment := AFieldsRadiationTreatment;
    FTotalDose := ATotalDose;
    FMetastasesTotalDose := AMetastasesTotalDose;
    FСomplicationsRadiationTreatment := AСomplicationsRadiationTreatment;
    FSDChemotherapy := ASDChemotherapy;
    FTypeChemotherapy := ATypeChemotherapy;
    FChemotherapyPreparationsDoses := AChemotherapyPreparationsDoses;
    FСomplicationsTypeChemotherapy := AСomplicationsTypeChemotherapy;
    FSDHormonetherapy := ASDHormonetherapy;
    FTypeHormonetherapy := ATypeHormonetherapy;
    FHormonetherapyPreparationsDoses := AHormonetherapyPreparationsDoses;
    FHormonetherapyTypeChemotherapy := AHormonetherapyTypeChemotherapy;
    FOtherSpecialTreatment := AOtherSpecialTreatment;
    FCaseFeatures := ACaseFeatures;
    FRecommendations := ARecommendations;

    FLocalizationOfMetastases := TList<Integer>.Create;
    FMethodConfirmingDiagnosis := TList<Integer>.Create;
    FSurgicalTreatments := TObjectList<TSurgicalTreatmentObject>.Create(True);
    FMethodRadiationTreatment := TList<Integer>.Create;
    FRadioModifiers := TList<Integer>.Create;
end;

destructor TForm027UObject.Destroy;
begin
    FRadioModifiers.Free;
    FMethodRadiationTreatment.Free;
    FSurgicalTreatments.Free;
    FMethodConfirmingDiagnosis.Free;
    FLocalizationOfMetastases.Free;
    inherited;
end;

function TForm027UObject.AddLocalizationOfMetastase(const AValue: Integer): Integer;
begin
    Result := FLocalizationOfMetastases.Add(AValue);
end;

procedure TForm027UObject.ClearALocalizationOfMetastases;
begin
    FLocalizationOfMetastases.Clear;
end;

function TForm027UObject.AddMethodConfirmingDiagnosis(const AValue: Integer): Integer;
begin
    Result := FMethodConfirmingDiagnosis.Add(AValue);
end;

procedure TForm027UObject.ClearMethodConfirmingDiagnosis;
begin
    FMethodConfirmingDiagnosis.Clear;
end;

function TForm027UObject.AddSurgicalTreatment(const AItem: TSurgicalTreatmentObject): Integer;
begin
    Result := FSurgicalTreatments.Add(AItem);
end;

procedure TForm027UObject.ClearSurgicalTreatments;
begin
    FSurgicalTreatments.Clear;
end;

function TForm027UObject.AddMethodRadiationTreatment(const AValue: Integer): Integer;
begin
    Result := FMethodRadiationTreatment.Add(AValue);
end;

procedure TForm027UObject.ClearMethodRadiationTreatment;
begin
    FMethodRadiationTreatment.Clear;
end;

function TForm027UObject.AddRadioModifier(const AValue: Integer): Integer;
begin
    Result := FRadioModifiers.Add(AValue);
end;

procedure TForm027UObject.ClearRadioModifiers;
begin
    FRadioModifiers.Clear;
end;

procedure TForm027UObject.SaveToXml(const ANode: IXmlNode);
var
    Node: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:Form027U');

    inherited SaveToXml(ANode);

    TXmlWriter.WriteString(ANode.AddChild('mm:IssuingInstitution'), IssuingInstitution);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:TargetMU'), TargetMU);
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:StartDate'), StartDate);
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:EndDate'), EndDate);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:Duration'), Duration);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:DiagnosFirstTime'), DiagnosFirstTime);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:ServiceCaseGoal'), ServiceCaseGoal);
    TXmlWriter.WriteString(ANode.AddChild('mm:MainDiagnos'), MainDiagnos);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:MainDiagnosText'), MainDiagnosText);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TopographyTumor'), TopographyTumor);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:MorphologicalTypeTumor'), MorphologicalTypeTumor);

    Node := ANode.AddChild('mm:TNM');
    TXmlWriter.WriteAttrString(Node, 'mm:TNM_T', TNMT);
    TXmlWriter.WriteAttrString(Node, 'mm:TNM_N', TNMN);
    TXmlWriter.WriteAttrString(Node, 'mm:TNM_M', TNMM);

    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TumorStage'), TumorStage);

    Node := ANode.AddChild('mm:LocalizationOfMetastases');
    if LocalizationOfMetastases.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to LocalizationOfMetastases.Count - 1 do
            TXmlWriter.WriteInteger(Node.AddChild('mm:IdLocalization'), LocalizationOfMetastases[Index]);
    end;

    Node := ANode.AddChild('mm:MethodConfirmingDiagnosis');
    if MethodConfirmingDiagnosis.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MethodConfirmingDiagnosis.Count - 1 do
            TXmlWriter.WriteInteger(Node.AddChild('mm:IdMethod'), MethodConfirmingDiagnosis[Index]);
    end;

    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:AttendantDiagnosis'), AttendantDiagnosis);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:NatureDisease'), NatureDisease);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:CauseInterruption'), CauseInterruption);

    Node := ANode.AddChild('mm:SurgicalTreatments');
    if SurgicalTreatments.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to SurgicalTreatments.Count - 1 do
            SurgicalTreatments[Index].SaveToXml(Node.AddChild('mm:SurgicalTreatment'));
    end;

    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('mm:SDRadiationTreatment'), SDRadiationTreatment);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TypeRadiationTreatment'), TypeRadiationTreatment);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:TypeRadiationTreatmentText'), TypeRadiationTreatmentText);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:ViewRadiationTreatment'), ViewRadiationTreatment);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:ViewRadiationTreatmentText'), ViewRadiationTreatmentText);

    Node := ANode.AddChild('mm:MethodRadiationTreatment');
    if MethodRadiationTreatment.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MethodRadiationTreatment.Count - 1 do
            TXmlWriter.WriteInteger(Node.AddChild('mm:IdRadiationTreatment'), MethodRadiationTreatment[Index]);
    end;

    Node := ANode.AddChild('mm:RadioModifiers');
    if RadioModifiers.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to RadioModifiers.Count - 1 do
            TXmlWriter.WriteInteger(Node.AddChild('mm:IdModifier'), RadioModifiers[Index]);
    end;

    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:FieldsRadiationTreatment'), FieldsRadiationTreatment);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TotalDose'), TotalDose);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:MetastasesTotalDose'), MetastasesTotalDose);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:СomplicationsRadiationTreatment'), СomplicationsRadiationTreatment);

    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('mm:SDChemotherapy'), SDChemotherapy);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TypeChemotherapy'), TypeChemotherapy);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Chemotherapy_PreparationsDoses'), ChemotherapyPreparationsDoses);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:СomplicationsTypeChemotherapy'), СomplicationsTypeChemotherapy);

    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('mm:SDHormonetherapy'), SDHormonetherapy);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('mm:TypeHormonetherapy'), TypeHormonetherapy);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Hormonetherapy_PreparationsDoses'), HormonetherapyPreparationsDoses);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:HormonetherapyTypeChemotherapy'), HormonetherapyTypeChemotherapy);

    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:OtherSpecialTreatment'), OtherSpecialTreatment);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:CaseFeatures'), CaseFeatures);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Recommendations'), Recommendations);

end;

end.
