{***************************************************************************************************
* Тип Scores
* Комплексный тип Scores предназначен для указания результатов различных диагностических и прогностических шкал. Описание параметров типа
* Scores представлено в таблице.
* Date   1..1  Date    Дата измерения
* Scale  1..1  String  Наименование шкалы
* Data   1..1  String  Значение по шкале
***************************************************************************************************}

unit ScoresUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TScoresObject = class (TMedRecordObject)
    private
        FDate: TDateTime;
        FScale: String;
        FValue: String;
    public
        property Date: TDateTime read FDate;
        property Scale: String read FScale;
        property Value: String read FValue;
        constructor Create(const ADate: TDateTime; const AScale, AValue: String);
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TScoresObject }

constructor TScoresObject.Create(const ADate: TDateTime; const AScale, AValue: String);
begin
    FDate := ADate;
    FScale := AScale;
    FValue := AValue;
end;

procedure TScoresObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:Scores');
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Date'), Date);
    TXmlWriter.WriteString(ANode.AddChild('m:Scale'), Scale);
    TXmlWriter.WriteString(ANode.AddChild('m:Value'), Value);
end;

end.
