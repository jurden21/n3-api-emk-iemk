{***************************************************************************************************
* Тип Immunize
* Комплексный тип Immunize предназначен для передачи данных о проведенной вакцинации и иммунизации пациента. Описание параметров типа
* Immunize представлено в таблице.
* Date  1..1  DateTime  Дата вакциации
* Code  1..1  Integer   Код иммунобиологического препарата (Справочник OID: 1.2.643.5.1.13.13.11.1078)
***************************************************************************************************}
unit ImmunizeUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TImmunizeObject = class (TMedRecordObject)
    private
        FDate: TDateTime;
        FCode: Integer;
    public
        property Date: TDateTime read FDate;
        property Code: Integer read FCode;
        constructor Create(const ADate: TDateTime; const ACode: Integer);
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TImmunizeObject }

constructor TImmunizeObject.Create(const ADate: TDateTime; const ACode: Integer);
begin
    FDate := ADate;
    FCode := ACode;
end;

procedure TImmunizeObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:Immunize');
    TXmlWriter.WriteDateTime(ANode.AddChild('m:Date'), Date);
    TXmlWriter.WriteInteger(ANode.AddChild('m:Code'), Code);
end;

end.
