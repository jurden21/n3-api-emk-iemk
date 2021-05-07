{***************************************************************************************************
* Тип HealthGroupInfo
* Комплексный тип HealthGroupInfo используется для передачи группы здоровья, передаваемой в рамках объекта DispensaryOne. В таблице
* представлено описание комплексного типа HealthGroupInfo.
* Date           1..1  DateTime  Дата установки группы
* IdHealthGroup  1..1  Integer   Группа здоровья (Справочник OID: 1.2.643.5.1.13.2.1.1.118)
*
* Тип DispensaryBase
* Комплексный тип DispensaryBase используется для передачи данных диспенсерного наблюдения. Тип полностью наследуется от комплексного
* типа MedDocument. В текущем решении поддерживается только передача сведений первого этапа диспансеризации (см. тип DispensaryOne).
*
* Тип DispensaryOne
* Комплексный тип DispensaryOne используется для передачи данных первого этапа диспансеризации, наследуется от DispensaryBase.
* Дополнительные параметры типа DispensaryOne представлены в таблице.
* IsGuested                 1..1  Boolean          Диспансеризация проводится в ходе выездной работы (да/нет)
* HasExtraResearchRefferal  1..1  Boolean          Дано направление на дополнительное диагностическое исследование, не входящее в объем диспансеризации (да/нет)
* IsUnderObservation        1..1  Boolean          Взят под диспансерное наблюдение (да/нет)
* HasExpertCareRefferal     1..1  Boolean          Дано направление для получения специализированной, в том числе высокотехнологичной медицинской помощи (да/нет)
* HasPrescribeCure          1..1  Boolean          Назначено лечение (да/нет)
* HasHealthResortRefferal   1..1  Boolean          Дано направление на санаторно-курортное лечение (да/нет)
* HasSecondStageRefferal    1..1  Boolean          Необходимо прохождение 2-го этапа диспансеризации (да/нет)
* HealthGroup               1..1  HealthGroupInfo  Информация о группе здоровья и поставившему ее медицинскому работнике
* Recommendations           1..*  Recommendation   Рекомендации по итогам диспансеризации
***************************************************************************************************}
unit DispensaryUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, MedDocumentUnit, RecommendationUnit, MedicalStaffUnit;

type
    THealthGroupInfoObject = class
    private
        FDate: TDateTime;
        FIdHealthGroup: Integer;
    public
        property Date: TDateTime read FDate;
        property IdHealthGroup: Integer read FIdHealthGroup;
        constructor Create(const ADate: TDateTime; const AIdHealthGroup: Integer);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TDispensaryBaseObject = class (TMedDocumentObject)
    end;

    TDispensaryOneObject = class (TDispensaryBaseObject)
    private
        FIsGuested: Boolean;
        FHasExtraResearchRefferal: Boolean;
        FIsUnderObservation: Boolean;
        FHasExpertCareRefferal: Boolean;
        FHasPrescribeCure: Boolean;
        FHasHealthResortRefferal: Boolean;
        FHasSecondStageRefferal: Boolean;
        FHealthGroup: THealthGroupInfoObject;
        FRecommendations: TObjectList<TRecommendationObject>;
    public
        property IsGuested: Boolean read FIsGuested;
        property HasExtraResearchRefferal: Boolean read FHasExtraResearchRefferal;
        property IsUnderObservation: Boolean read FIsUnderObservation;
        property HasExpertCareRefferal: Boolean read FHasExpertCareRefferal;
        property HasPrescribeCure: Boolean read FHasPrescribeCure;
        property HasHealthResortRefferal: Boolean read FHasHealthResortRefferal;
        property HasSecondStageRefferal: Boolean read FHasSecondStageRefferal;
        property HealthGroup: THealthGroupInfoObject read FHealthGroup;
        property Recommendations: TObjectList<TRecommendationObject> read FRecommendations;
        constructor Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
            const AAuthor: TMedicalStaffObject; const AHeader: String; const AIsGuested, AHasExtraResearchRefferal, AIsUnderObservation,
            AHasExpertCareRefferal, AHasPrescribeCure, AHasHealthResortRefferal, AHasSecondStageRefferal: Boolean;
            const AHealthGroup: THealthGroupInfoObject);
        destructor Destroy; override;
        function AddRecommendation(const AItem: TRecommendationObject): Integer;
        procedure ClearRecommendations;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ THealthGroupInfoObject }

constructor THealthGroupInfoObject.Create(const ADate: TDateTime; const AIdHealthGroup: Integer);
begin
    FDate := ADate;
    FIdHealthGroup := AIdHealthGroup;
end;

procedure THealthGroupInfoObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:Date'), Date);
    TXmlWriter.WriteInteger(ANode.AddChild('mm:IdHealthGroup'), IdHealthGroup);
end;

{ TDispensaryOneObject }

constructor TDispensaryOneObject.Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
    const AAuthor: TMedicalStaffObject; const AHeader: String; const AIsGuested, AHasExtraResearchRefferal, AIsUnderObservation, AHasExpertCareRefferal,
    AHasPrescribeCure, AHasHealthResortRefferal, AHasSecondStageRefferal: Boolean; const AHealthGroup: THealthGroupInfoObject);
begin
    inherited Create(ACreationDate, AIdDocumentMis, AAttachment, AAuthor, AHeader);

    FIsGuested := AIsGuested;
    FHasExtraResearchRefferal := AHasExtraResearchRefferal;
    FIsUnderObservation := AIsUnderObservation;
    FHasExpertCareRefferal := AHasExpertCareRefferal;
    FHasPrescribeCure := AHasPrescribeCure;
    FHasHealthResortRefferal := AHasHealthResortRefferal;
    FHasSecondStageRefferal := AHasSecondStageRefferal;
    FHealthGroup := AHealthGroup;

    FRecommendations := TObjectList<TRecommendationObject>.Create(True);
end;

destructor TDispensaryOneObject.Destroy;
begin
    FRecommendations.Free;
    FHealthGroup.Free;
    inherited;
end;

function TDispensaryOneObject.AddRecommendation(const AItem: TRecommendationObject): Integer;
begin
    Result := FRecommendations.Add(AItem);
end;

procedure TDispensaryOneObject.ClearRecommendations;
begin
    FRecommendations.Clear;
end;

procedure TDispensaryOneObject.SaveToXml(const ANode: IXmlNode);
var
    HealthGroupNode, RecommendationsNode: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:DispensaryOne');

    inherited SaveToXml(ANode);

    TXmlWriter.WriteBoolean(ANode.AddChild('mm:IsGuested'), IsGuested);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:HasExtraResearchRefferal'), HasExtraResearchRefferal);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:IsUnderObservation'), IsUnderObservation);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:HasExpertCareRefferal'), HasExpertCareRefferal);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:HasPrescribeCure'), HasPrescribeCure);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:HasHealthResortRefferal'), HasHealthResortRefferal);
    TXmlWriter.WriteBoolean(ANode.AddChild('mm:HasSecondStageRefferal'), HasSecondStageRefferal);

    HealthGroupNode := ANode.AddChild('mm:HealthGroup');
    if HealthGroup = nil
    then TXmlWriter.WriteNull(HealthGroupNode)
    else HealthGroup.SaveToXml(HealthGroupNode);

    RecommendationsNode := ANode.AddChild('mm:Recommendations');
    if Recommendations.Count = 0
    then TXmlWriter.WriteNull(RecommendationsNode)
    else begin
        for Index := 0 to Recommendations.Count - 1 do
            Recommendations[Index].SaveToXml(RecommendationsNode);
    end;
end;

end.
