{***************************************************************************************************
* Тип NonDrugTreatment
* Комплексный тип NonDrugTreatment предназначен для передачи данных о назначенном немедикаментозном лечении. Описание параметров типа
* NonDrugTreatment представлено в таблице.
* Name    1..1  String    Наименование лечения
* Scheme  1..1  String    Описание схемы лечения
* Start   0..1  DateTime  Дата начала лечения
* End     0..1  DateTime  Дата окончания лечения
***************************************************************************************************}
unit NonDrugTreatmentUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TNonDrugTreatmentObject = class (TMedRecordObject)
    private
        FName: String;
        FScheme: String;
        FDateStart: TDateTime;
        FDateEnd: TDateTime;
    public
        property Name: String read FName;
        property Scheme: String read FScheme;
        property DateStart: TDateTime read FDateStart;
        property DateEnd: TDateTime read FDateEnd;
        constructor Create(const AName, AScheme: String; const ADateStart, ADateEnd: TDateTime);
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TNonDrugTreatmentObject }

constructor TNonDrugTreatmentObject.Create(const AName, AScheme: String; const ADateStart, ADateEnd: TDateTime);
begin
    FName := AName;
    FScheme := AScheme;
    FDateStart := ADateStart;
    FDateEnd := ADateEnd;
end;

procedure TNonDrugTreatmentObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:NonDrugTreatment');
    TXmlWriter.WriteString(ANode.AddChild('m:Name'), Name);
    TXmlWriter.WriteString(ANode.AddChild('m:Scheme'), Scheme);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('m:Start'), DateStart);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('m:End'), DateEnd);
end;

end.
