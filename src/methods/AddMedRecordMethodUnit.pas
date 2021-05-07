unit AddMedRecordMethodUnit;

interface

uses
    System.Classes, Xml.XmlDoc, Xml.XmlIntf, EmkServiceMethodUnit, MedRecordUnit;

type
    TAddMedRecordMethod = class(TEmkServiceMethod)
    private
        FIdPatientMis: String;
        FIdCaseMis: String;
        FMedRecord: TMedRecordObject;
    protected
        procedure CreateRequestStream; override;
    public
        property MedRecord: TMedRecordObject read FMedRecord;
        constructor Create(const AGuid, AIdLpu, AIdPatientMis, AIdCaseMis: String; const AMedRecord: TMedRecordObject);
        destructor Destroy; override;
    end;

implementation

uses XmlWriterUnit;

{ TAddMedRecordMethod }

constructor TAddMedRecordMethod.Create(const AGuid, AIdLpu, AIdPatientMis, AIdCaseMis: String; const AMedRecord: TMedRecordObject);
begin
    inherited Create(AGuid, AIdLpu);
    FSoapAction := '"http://tempuri.org/IEmkService/AddMedRecord"';
    FIdPatientMis := AIdPatientMis;
    FIdCaseMis := AIdCaseMis;
    FMedRecord := AMedRecord;
end;

destructor TAddMedRecordMethod.Destroy;
begin
    FMedRecord.Free;
    inherited;
end;

procedure TAddMedRecordMethod.CreateRequestStream;
var
    XmlDoc: IXMLDocument;
    Root: IXmlNode;
    Node: IXmlNode;
begin
    XmlDoc := TXmlDocument.Create(nil);
    try
        XmlDoc.Active := True;
        XmlDoc.Version := '1.0';
        XmlDoc.Encoding := 'utf-8';

        // ENVELOPE
        Root := XmlDoc.AddChild('soapenv:Envelope');
        TXmlWriter.WriteAttrString(Root, 'xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        TXmlWriter.WriteAttrString(Root, 'xmlns:tem', 'http://tempuri.org/');
        TXmlWriter.WriteAttrString(Root, 'xmlns:b', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto');
        TXmlWriter.WriteAttrString(Root, 'xmlns:a', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto.Case');
        TXmlWriter.WriteAttrString(Root, 'xmlns:s', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto.Step');
        TXmlWriter.WriteAttrString(Root, 'xmlns:m', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto.MedRec');
        TXmlWriter.WriteAttrString(Root, 'xmlns:md', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto.MedRec.Diag');
        TXmlWriter.WriteAttrString(Root, 'xmlns:mm', 'http://schemas.datacontract.org/2004/07/N3.EMK.Dto.MedRec.MedDoc');
        TXmlWriter.WriteAttrString(Root, 'xmlns:i', 'http://www.w3.org/2001/XMLSchema-instance');

        // HEADER
        Node := Root.AddChild('soapenv:Header');

        // BODY
        Node := Root.AddChild('soapenv:Body');

        // ADDMEDRECORD
        Node := Node.AddChild('tem:AddMedRecord');

        TXmlWriter.WriteString(Node.AddChild('tem:guid'), FGuid);
        TXmlWriter.WriteString(Node.AddChild('tem:idLpu'), FIdLpu);
        TXmlWriter.WriteString(Node.AddChild('tem:idPatientMis'), FIdPatientMis);
        TXmlWriter.WriteString(Node.AddChild('tem:idCaseMis'), FIdCaseMis);

        Node := Node.AddChild('tem:medRecord');

        MedRecord.SaveToXml(Node);

        XmlDoc.SaveToStream(FRequestStream);

    finally
        XmlDoc := nil;
    end;
end;

end.
