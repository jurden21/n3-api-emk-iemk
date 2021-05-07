{***************************************************************************************************
* Тип AllergyBase
* Комплексный тип AllergyBase используется как базовый тип для передачи данных о патологических реакциях (аллергиях) и индивидуальной
* лекарственной непереносимости. Объекты типа AllergyBase отдельно не передаются, а расширяются дочерними типами AllergyDrug и
* AllergyNonDrug. Описание параметров объекта AllergyBase представлено в таблице.
* Type          1..1  Integer   Тип патологической реакции для сбора аллергоанамнеза (Справочник OID: 1.2.643.5.1.13.13.11.1064)
* Comment       0..1  String    Комментарий
* Time          1..1  DateTime  Дата выявления
* ReactionCode  1..1  Integer   Код реакции (Справочник OID: 1.2.643.5.1.13.13.11.1063)
*
* Тип AllergyDrug
* Комплексный тип AllergyDrug предназначен для передачи данных об индивидуальной непереносимости лекарственных средств. Описание параметров
* типа AllergyDrug представлено в таблице.
* AllergyBase  1..1  AllergyBase  Общие параметры
* IdINN        1..1  Integer      Код лекарственного средства (Справочник OID: 1.2.643.5.1.13.2.1.1.179)
*
* Тип AllergyNonDrug
* Комплексный тип AllergyNonDrug предназначен для передачи данных об индивидуальной непереносимости лекарственных средств. Описание параметров типа AllergyNonDrug представлено в таблице.
* AllergyBase  1..1  AllergyBase  Общие параметры
* Description  1..1  String       Описание агента (аллергена)
***************************************************************************************************}
unit AllergyUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TAllergyBaseObject = class
    private
        FTyp: Integer;
        FComment: String;
        FTime: TDateTime;
        FReactionCode: Integer;
    public
        property Typ: Integer read FTyp;
        property Comment: String read FComment;
        property Time: TDateTime read FTime;
        property ReactionCode: Integer read FReactionCode;
        constructor Create(const ATyp: Integer; const AComment: String; const ATime: TDateTime; const AReactionCode: Integer);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TAllergyDrugObject = class (TMedRecordObject)
    private
        FAllergyBase: TAllergyBaseObject;
        FIdINN: Integer;
    public
        property AllergyBase: TAllergyBaseObject read FAllergyBase;
        property IdINN: Integer read FIdINN;
        constructor Create(const AAllergyBase: TAllergyBaseObject; const AIdINN: Integer);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TAllergyNonDrugObject = class (TMedRecordObject)
    private
        FAllergyBase: TAllergyBaseObject;
        FDescription: String;
    public
        property AllergyBase: TAllergyBaseObject read FAllergyBase;
        property Description: String read FDescription;
        constructor Create(const AAllergyBase: TAllergyBaseObject; const ADescription: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;


implementation

uses XmlWriterUnit;

{ TAllergyBaseObject }

constructor TAllergyBaseObject.Create(const ATyp: Integer; const AComment: String; const ATime: TDateTime; const AReactionCode: Integer);
begin
    FTyp := ATyp;
    FComment := AComment;
    FTime := ATime;
    FReactionCode := AReactionCode;
end;

procedure TAllergyBaseObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:Type'), Typ);
    TXmlWriter.WriteStringNullable(ANode.AddChild('m:Comment'), Comment);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Time'), Time);
    TXmlWriter.WriteInteger(ANode.AddChild('m:ReactionCode'), ReactionCode);
end;

{ TAllergyDrugObject }

constructor TAllergyDrugObject.Create(const AAllergyBase: TAllergyBaseObject; const AIdINN: Integer);
begin
    FAllergyBase := AAllergyBase;
    FIdINN := AIdINN;
end;

destructor TAllergyDrugObject.Destroy;
begin
    FAllergyBase.Free;
    inherited;
end;

procedure TAllergyDrugObject.SaveToXml(const ANode: IXmlNode);
var
    AllergyBaseNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:AllergyDrug');
    AllergyBaseNode := ANode.AddChild('m:AllergyBase');
    if AllergyBase = nil
    then TXmlWriter.WriteNull(AllergyBaseNode)
    else AllergyBase.SaveToXml(AllergyBaseNode);
    TXmlWriter.WriteInteger(ANode.AddChild('m:IdINN'), IdINN);
end;

{ TAllergyNonDrugObject }

constructor TAllergyNonDrugObject.Create(const AAllergyBase: TAllergyBaseObject; const ADescription: String);
begin
    FAllergyBase := AAllergyBase;
    FDescription := ADescription;
end;

destructor TAllergyNonDrugObject.Destroy;
begin
    FAllergyBase.Free;
    inherited;
end;

procedure TAllergyNonDrugObject.SaveToXml(const ANode: IXmlNode);
var
    AllergyBaseNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:AllergyNonDrug');
    AllergyBaseNode := ANode.AddChild('m:AllergyBase');
    if AllergyBase = nil
    then TXmlWriter.WriteNull(AllergyBaseNode)
    else AllergyBase.SaveToXml(AllergyBaseNode);
    TXmlWriter.WriteString(ANode.AddChild('m:Description'), Description);
end;

end.
