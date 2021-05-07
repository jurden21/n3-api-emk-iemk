{***************************************************************************************************
* Тип Participant
* Комплексный тип Participant предназначен для передачи данных о враче.
* Doctor  0..1 (обязательно только для Service)  MedicalStaff  Данные медицинского работника
* IdRole  0..1 (обязательно только для Service)  Integer       Роль работника в оказании помощи (Справочник OID: 1.2.643.5.1.13.2.7.1.30)
***************************************************************************************************}
unit ParticipantUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedicalStaffUnit;

type
    TParticipantObject = class
    private
        FIdRole: Integer;
        FDoctor: TMedicalStaffObject;
    public
        property IdRole: Integer read FIdRole;
        property Doctor: TMedicalStaffObject read FDoctor;
        constructor Create(const AIdRole: Integer; const ADoctor: TMedicalStaffObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

implementation

uses XmlWriterUnit;

{ TParticipantObject }

constructor TParticipantObject.Create(const AIdRole: Integer; const ADoctor: TMedicalStaffObject);
begin
    FIdRole := AIdRole;
    FDoctor := ADoctor;
end;

destructor TParticipantObject.Destroy;
begin
    FDoctor.Free;
    inherited;
end;

procedure TParticipantObject.SaveToXml(const ANode: IXmlNode);
var
    DoctorNode: IXMLNode;
begin
    DoctorNode := ANode.AddChild('b:Doctor');
    if Doctor = nil
    then TXmlWriter.WriteNull(DoctorNode)
    else Doctor.SaveToXml(DoctorNode);
    TXmlWriter.WriteIntegerNullable(ANode.AddChild('b:IdRole'), IdRole);
end;

end.
