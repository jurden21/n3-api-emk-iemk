{***************************************************************************************************
* Тип MedicalStaff
* Комплексный тип MedicalStaff предназначен для передачи данных о медицинском работнике. В таблице представлено описание комплексного типа
* MedicalStaff.
* Person          0..1  PersonWithIdentity  Сведения о о личности медицинского работника
* IdLpu           0..1	String              Идентификатор МО
* IdSpeciality    1..1	Integer             Идентификатор специальности медицинского работника
* IdPosition      1..1	Integer             Идентификатор должности медицинского работника
* IdMedicalStaff  0..0	Integer             Идентификатор записи в БД (не используется при передече данных в сервис)
* PositionName    0..0	String              Наименование должности (не используется при передече данных в сервис)
* SpecialityName  0..0	String              Наименование специальности (не используется при передече данных в сервис)
***************************************************************************************************}
unit MedicalStaffUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, PersonUnit;

type
    TMedicalStaffObject = class
    private
        FIdLpu: String;
        FIdSpeciality: Integer;
        FIdPosition: Integer;
        FPerson: TPersonObject;
    public
        property IdLpu: String read FIdLpu;
        property IdSpeciality: Integer read FIdSpeciality;
        property IdPosition: Integer read FIdPosition;
        property Person: TPersonObject read FPerson;
        constructor Create(const AIdLpu: String; const AIdSpeciality, AIdPosition: Integer; const APerson: TPersonObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

implementation

uses XmlWriterUnit;

{ TMedicalStaffObject }

constructor TMedicalStaffObject.Create(const AIdLpu: String; const AIdSpeciality, AIdPosition: Integer; const APerson: TPersonObject);
begin
    FIdLpu := AIdLpu;
    FIdSpeciality := AIdSpeciality;
    FIdPosition := AIdPosition;
    FPerson := APerson;
end;

destructor TMedicalStaffObject.Destroy;
begin
    FPerson.Free;
    inherited;
end;

procedure TMedicalStaffObject.SaveToXml(const ANode: IXmlNode);
var
    PersonNode: IXmlNode;
begin
    PersonNode := ANode.AddChild('b:Person');
    if Person = nil
    then TXmlWriter.WriteNull(PersonNode)
    else Person.SaveToXml(PersonNode);

    TXmlWriter.WriteStringNullable(ANode.AddChild('b:IdLpu'), IdLpu);
    TXmlWriter.WriteInteger(ANode.AddChild('b:IdPosition'), IdPosition);
    TXmlWriter.WriteInteger(ANode.AddChild('b:IdSpeciality'), IdSpeciality);
end;

end.
