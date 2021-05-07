{***************************************************************************************************
* Тип Procedure
* Комплексный тип Procedure предназначен для передачи данных о выполненных медицинских процедурах. Описание параметров типа Procedure
* представлено в таблице
* Code       1..1  String        Код процедуры (Номенклатура медицинских услуг, OID 1.2.643.5.1.13.13.11.1070)
* Date       0..1  DateTime	     Дата проведения процедуры
* Performer  1..1  MedicalStaff  Сведения об исполнителе
***************************************************************************************************}
unit ProcedureUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedicalStaffUnit, MedRecordUnit;

type
    TProcedureObject = class (TMedRecordObject)
    private
        FCode: String;
        FDate: TDateTime;
        FPerformer: TMedicalStaffObject;
    public
        property Code: String read FCode;
        property Date: TDateTime read FDate;
        property Performer: TMedicalStaffObject read FPerformer;
        constructor Create(const ACode: String; const ADate: TDateTime; const APerformer: TMedicalStaffObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TProcedureObject }

constructor TProcedureObject.Create(const ACode: String; const ADate: TDateTime; const APerformer: TMedicalStaffObject);
begin
    FCode := ACode;
    FDate := ADate;
    FPerformer := APerformer;
end;

destructor TProcedureObject.Destroy;
begin
    FPerformer.Free;
    inherited;
end;

procedure TProcedureObject.SaveToXml(const ANode: IXmlNode);
var
    PerformerNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:Procedure');
    TXmlWriter.WriteString(ANode.AddChild('m:Code'), Code);
    TXmlWriter.WriteDateTimeNullable(ANode.AddChild('m:Date'), Date);
    PerformerNode := ANode.AddChild('m:Performer');
    if Performer = nil
    then TXmlWriter.WriteNull(PerformerNode)
    else Performer.SaveToXml(PerformerNode);
end;

end.
