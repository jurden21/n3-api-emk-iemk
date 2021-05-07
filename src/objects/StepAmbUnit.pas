{***************************************************************************************************
* Тип StepAmb
* Комплексный тип StepAmb используется для передачи данных эпизода амбулаторного случая обслуживания. Тип наследуется от StepBase и имеет
* дополнительные параметры. Параметры типа StepAmb приведены в таблице.
* IdVisitPlace    1..1  Integer    Идентификатор места посещения (Справочник OID: 1.2.643.2.69.1.1.1.18)
* IdVisitPurpose  1..1	Integer    Идентификатор цели посещения (Справочник OID: 1.2.643.2.69.1.1.1.19)
* MedRecords      0..*  MedRecord  Массив MedRecord, доступных для эпизода амбулаторного случая обслуживания. Перечень допустимых атрибутов
*                                  приведен в соответствующем разделе документации.
***************************************************************************************************}
unit StepAmbUnit;

interface

uses
    System.Generics.Collections, Xml.XmlDoc, Xml.XmlIntf, StepBaseUnit, MedRecordUnit, MedicalStaffUnit;

type
    TStepAmbObject = class (TStepBaseObject)
    private
        FIdVisitPlace: Integer;
        FIdVisitPurpose: Integer;
        FMedRecords: TObjectList<TMedRecordObject>;
    public
        property IdVisitPlace: Integer read FIdVisitPlace;
        property IdVisitPurpose: Integer read FIdVisitPurpose;
        property MedRecords: TObjectList<TMedRecordObject> read FMedRecords;
        constructor Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
            const ADoctor: TMedicalStaffObject; const AIdStepMis: String; const AIdVisitPlace, AIdVisitPurpose: Integer);
        destructor Destroy; override;
        function AddMedRecord(const AItem: TMedRecordObject): Integer;
        procedure ClearMedRecords;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TStepAmbObject }

constructor TStepAmbObject.Create(const ADateStart, ADateEnd: TDateTime; const AComment: String; const AIdPaymentType: Integer;
    const ADoctor: TMedicalStaffObject; const AIdStepMis: String; const AIdVisitPlace, AIdVisitPurpose: Integer);
begin
    inherited Create(ADateStart, ADateEnd, AComment, AIdPaymentType, ADoctor, AIdStepMis);
    FIdVisitPlace := AIdVisitPlace;
    FIdVisitPurpose := AIdVisitPurpose;
    FMedRecords := TObjectList<TMedRecordObject>.Create(True);
end;

destructor TStepAmbObject.Destroy;
begin
    FMedRecords.Free;
    inherited;
end;

function TStepAmbObject.AddMedRecord(const AItem: TMedRecordObject): Integer;
begin
    Result := FMedRecords.Add(AItem);
end;

procedure TStepAmbObject.ClearMedRecords;
begin
    FMedRecords.Clear;
end;

procedure TStepAmbObject.SaveToXml(const ANode: IXmlNode);
var
    Node: IXmlNode;
    Index: Integer;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 's:StepAmb');

    inherited SaveToXml(ANode);

    TXmlWriter.WriteInteger(ANode.AddChild('s:IdVisitPlace'), IdVisitPlace);
    TXmlWriter.WriteInteger(ANode.AddChild('s:IdVisitPurpose'), IdVisitPurpose);

    Node := ANode.AddChild('s:MedRecords');
    if MedRecords.Count = 0
    then TXmlWriter.WriteNull(Node)
    else begin
        for Index := 0 to MedRecords.Count - 1 do
            MedRecords[Index].SaveToXml(Node.AddChild('MedRecord'));
    end;
end;

end.
