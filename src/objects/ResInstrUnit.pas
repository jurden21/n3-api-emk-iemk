{***************************************************************************************************
* Тип Activity
* Комплексный тип Activity предназначен для передачи данных о произведенных медицинских воздействиях. Описание параметров типа Activity
* представлено в таблице.
* Code  1..1  String    Код медицинского воздействия (Региональная номенклатура медицинских услуг, OID 1.2.643.2.69.1.1.1.88)
* Date  1..1  DateTime  Время выполнения медицинского воздействия
*
* Тип ResInstr
* Комплексный тип ResInstr предназначен для передачи данных о проведенных инструментальных исследованиях. Описание параметров типа ResInstr
* представлено в таблице.
* Date        1..1  DateTime      Время проведения инструментального исследования
* Type        1..1  Integer       Код типа инструментального исследования (Справочник OID: 1.2.643.5.1.13.2.1.1.1504.11)
* Priority    1..1  Integer       Код приоритета инструментального исследования (Справочник OID: 1.2.643.2.69.1.1.1.103)
* Text        1..1  String        Текст результатов и\или заключения
* Performer   1..1  MedicalStaff  Исполнитель
* Activities  1..*  Activity      Сведения о медицинских воздействиях
***************************************************************************************************}
unit ResInstrUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit;

type
    TActivityObject = class
    private
        FCode: String;
        FDate: TDateTime;
    public
        property Code: String read FCode;
        property Date: TDateTime read FDate;
        constructor Create(const ACode: String; const ADate: TDateTime);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TResInstrObject = class (TMedRecordObject)
    private
        FDate: TDateTime;
        FTyp: Integer;
        FPriority: Integer;
        FText: String;
        FPerformer: TMedicalStaffObject;
        FAcitivites: TObjectList<TActivityObject>;
    public
        property Date: TDateTime read FDate;
        property Typ: Integer read FTyp;
        property Priority: Integer read FPriority;
        property Text: String read FText;
        property Performer: TMedicalStaffObject read FPerformer;
        property Activites: TObjectList<TActivityObject> read FAcitivites;
        constructor Create(const ADate: TDateTime; const ATyp, APriority: Integer; const AText: String; const APerformer: TMedicalStaffObject);
        destructor Destroy; override;
        function AddActivity(const AItem: TActivityObject): Integer;
        procedure ClearActivities;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TActivityObject }

constructor TActivityObject.Create(const ACode: String; const ADate: TDateTime);
begin
    FCode := ACode;
    FDate := ADate;
end;

procedure TActivityObject.SaveToXml(const ANode: IXmlNode);
var
    Node: IXmlNode;
begin
    Node := ANode.AddChild('m:Activity');
    TXmlWriter.WriteString(Node.AddChild('m:Code'), Code);
    TXmlWriter.WriteDateTime(Node.AddChild('m:Date'), Date);
end;

{ TResInstrObject }

constructor TResInstrObject.Create(const ADate: TDateTime; const ATyp, APriority: Integer; const AText: String; const APerformer: TMedicalStaffObject);
begin
    FDate := ADate;
    FTyp := ATyp;
    FPriority := APriority;
    FText := AText;
    FPerformer := APerformer;
    FAcitivites := TObjectList<TActivityObject>.Create(True);
end;

destructor TResInstrObject.Destroy;
begin
    FAcitivites.Free;
    FPerformer.Free;
    inherited;
end;

function TResInstrObject.AddActivity(const AItem: TActivityObject): Integer;
begin
    Result := FAcitivites.Add(AItem);
end;

procedure TResInstrObject.ClearActivities;
begin
    FAcitivites.Clear;
end;

procedure TResInstrObject.SaveToXml(const ANode: IXmlNode);
var
    PerformerNode, ActivitesNode: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:ResInstr');
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Date'), Date);
    TXmlWriter.WriteInteger(ANode.AddChild('m:Type'), Typ);
    TXmlWriter.WriteInteger(ANode.AddChild('m:Priority'), Priority);
    TXmlWriter.WriteString(ANode.AddChild('m:Text'), Text);

    PerformerNode := ANode.AddChild('m:Performer');
    if Performer = nil
    then TXmlWriter.WriteNull(PerformerNode)
    else Performer.SaveToXml(PerformerNode);

    ActivitesNode := ANode.AddChild('m:Activites');
    if Activites.Count = 0
    then TXmlWriter.WriteNull(ActivitesNode)
    else begin
        for Index := 0 to Activites.Count - 1 do
            Activites[Index].SaveToXml(ActivitesNode);
    end;
end;

end.
