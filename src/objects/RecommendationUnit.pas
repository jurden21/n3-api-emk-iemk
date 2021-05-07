{***************************************************************************************************
* Тип Recommendation
* Комплексный тип Recommendation предназначен для передачи данных о рекомендациях по лечению пациента.
* Date    1..1  DateTime      Дата назначения рекомендации
* Doctor  1..1  MedicalStaff  Информация о медицинском работнике
* Text    1..1  String        Текст рекомендации
***************************************************************************************************}
unit RecommendationUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedicalStaffUnit;

type
    TRecommendationObject = class
    private
        FDate: TDateTime;
        FText: String;
        FDoctor: TMedicalStaffObject;
    public
        property Date: TDateTime read FDate;
        property Text: String read FText;
        property Doctor: TMedicalStaffObject read FDoctor;
        constructor Create(const ADate: TDateTime; const AText: String; const ADoctor: TMedicalStaffObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode);
    end;

implementation

uses XmlWriterUnit;

{ TRecommendationObject }

constructor TRecommendationObject.Create(const ADate: TDateTime; const AText: String; const ADoctor: TMedicalStaffObject);
begin
    FDate := ADate;
    FText := AText;
    FDoctor := ADoctor;
end;

destructor TRecommendationObject.Destroy;
begin
    FDoctor.Free;
    inherited;
end;

procedure TRecommendationObject.SaveToXml(const ANode: IXmlNode);
var
    DoctorNode: IXmlNode;
begin
    TXmlWriter.WriteDateTime(ANode.AddChild('Date'), Date);
    TXmlWriter.WriteString(ANode.AddChild('Text'), Text);
    DoctorNode := ANode.AddChild('Doctor');
    if Doctor = nil
    then TXmlWriter.WriteNull(DoctorNode)
    else Doctor.SaveToXml(DoctorNode);
end;

end.
