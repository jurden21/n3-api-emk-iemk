unit AddStepToCaseMethodUnit;

interface

uses
    System.Classes, Xml.XmlDoc, Xml.XmlIntf, EmkServiceMethodUnit, StepBaseUnit, StepStatUnit, StepAmbUnit;

type
    TAddStepToCaseMethod = class(TEmkServiceMethod)
    private
        FIdPatientMis: String;
        FIdCaseMis: String;
        FStep: TStepBaseObject;
    protected
        procedure CreateRequestStream; override;
    public
        property Step: TStepBaseObject read FStep;
        constructor Create(const AGuid, AIdLpu, AIdPatientMis, AIdCaseMis: String; const AStep: TStepBaseObject);
        destructor Destroy; override;
    end;

implementation

uses XmlWriterUnit;

{ TAddStepToCaseMethod }

constructor TAddStepToCaseMethod.Create(const AGuid, AIdLpu, AIdPatientMis, AIdCaseMis: String; const AStep: TStepBaseObject);
begin
    inherited Create(AGuid, AIdLpu);
    FSoapAction := '"http://tempuri.org/IEmkService/AddStepToCase"';
    FIdPatientMis := AIdPatientMis;
    FIdCaseMis := AIdCaseMis;
    FStep := AStep;
end;

destructor TAddStepToCaseMethod.Destroy;
begin
    FStep.Free;
    inherited;
end;

procedure TAddStepToCaseMethod.CreateRequestStream;
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

        // ADDSTEPTOCASE
        // <CreateCase>
        Node := Node.AddChild('tem:AddStepToCase');

        TXmlWriter.WriteString(Node.AddChild('tem:guid'), FGuid);
        TXmlWriter.WriteString(Node.AddChild('tem:idLpu'), FIdLpu);
        TXmlWriter.WriteString(Node.AddChild('tem:idPatientMis'), FIdPatientMis);
        TXmlWriter.WriteString(Node.AddChild('tem:idCaseMis'), FIdCaseMis);

        Node := Node.AddChild('tem:step');

        Step.SaveToXml(Node);

        XmlDoc.SaveToStream(FRequestStream);

    finally
        XmlDoc := nil;
    end;
end;

end.
