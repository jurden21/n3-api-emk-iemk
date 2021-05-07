{***************************************************************************************************
* Тип Guardian
* Комплексный тип Guardian служит для передачи сведений о законном представителе пациента. В таблице представлено описание комплексного
* типа Guardian.
* Person              1..1  PersonWithIdentity  Информация о персоне
* IdRelationType      1..1  Integer             Категория отношения к пациенту (Справочник OID 1.2.643.5.1.13.2.7.1.15)
* UnderlyingDocument  1..1  String              Реквизиты документа, определяющего право представлять пациента
***************************************************************************************************}
unit GuardianUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, PersonUnit;

type
    TGuardianObject = class
    private
        FIdRelationType: Integer;
        FUnderlyingDocument: String;
        FPerson: TPersonObject;
    public
        property IdRelationType: Integer read FIdRelationType;
        property UnderlyingDocument: String read FUnderlyingDocument;
        property Person: TPersonObject read FPerson;
        constructor Create(const AIdRelationType: Integer; const AUnderlyingDocument: String; const APerson: TPersonObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

implementation

uses XmlWriterUnit;

{ TGuardianObject }

constructor TGuardianObject.Create(const AIdRelationType: Integer; const AUnderlyingDocument: String; const APerson: TPersonObject);
begin
    FIdRelationType := AIdRelationType;
    FUnderlyingDocument := AUnderlyingDocument;
    FPerson := APerson;
end;

destructor TGuardianObject.Destroy;
begin
    FPerson.Free;
    inherited;
end;

procedure TGuardianObject.SaveToXml(const ANode: IXmlNode);
var
    PersonNode: IXmlNode;
begin
    PersonNode := ANode.AddChild('b:Person');
    if FPerson = nil
    then TXmlWriter.WriteNull(PersonNode)
    else FPerson.SaveToXml(PersonNode);
    TXmlWriter.WriteInteger(ANode.AddChild('b:IdRelationType'), IdRelationType);
    TXmlWriter.WriteString(ANode.AddChild('b:UnderlyingDocument'), UnderlyingDocument);
end;

end.
