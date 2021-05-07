{***************************************************************************************************
* Тип Surgery
* Комплексный тип Surgery предназначен для передачи данных о проведенных хирургических операциях. Описание параметров типа Surgery
* представлено в таблице.
* Code        1..1  String        Код операции по региональной номенклатуре (Справочник ОID: 1.2.643.2.69.1.1.1.88)
* Date        0..1  DateTime      Дата проведения операции
* Performers  1..1  MedicalStaff  Сведения об исполнителях
***************************************************************************************************}
unit SurgeryUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit;

type
    TSurgeryObject = class (TMedRecordObject)
    private
        FCode: String;
        FDate: TDateTime;
        FPerformers: TMedicalStaffObject;
    public
        property Code: String read FCode;
        property Date: TDateTime read FDate;
        property Performers: TMedicalStaffObject read FPerformers;
        constructor Create(const ACode: String; const ADate: TDateTime; const APerformers: TMedicalStaffObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TSurgeryObject }

constructor TSurgeryObject.Create(const ACode: String; const ADate: TDateTime; const APerformers: TMedicalStaffObject);
begin
    FCode := ACode;
    FDate := ADate;
    FPerformers := APerformers;
end;

destructor TSurgeryObject.Destroy;
begin
    FPerformers.Free;
    inherited;
end;

procedure TSurgeryObject.SaveToXml(const ANode: IXmlNode);
var
    PerformersNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:Surgery');

    TXmlWriter.WriteString(ANode.AddChild('m:Code'), Code);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('m:Date'), Date);

    PerformersNode := ANode.AddChild('m:Performers');
    if Performers = nil
    then TXmlWriter.WriteNull(PerformersNode)
    else Performers.SaveToXml(PerformersNode);
end;

end.
