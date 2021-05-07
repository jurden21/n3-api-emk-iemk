unit CreateCaseMethodUnit;

interface

uses
    System.Classes, Xml.XmlDoc, Xml.XmlIntf, EmkServiceMethodUnit, CaseBaseUnit, CaseStatUnit, CaseAmbUnit;

type
    TCreateCaseMethod = class(TEmkServiceMethod)
    private
        FCase: TCaseBaseObject;
    protected
        procedure CreateRequestStream; override;
    public
        property Casee: TCaseBaseObject read FCase;
        constructor Create(const AGuid, AIdLpu: String; const ACase: TCaseBaseObject);
        destructor Destroy; override;
    end;

implementation

uses XmlWriterUnit;

{ TCreateCaseMethod }

constructor TCreateCaseMethod.Create(const AGuid, AIdLpu: String; const ACase: TCaseBaseObject);
begin
    inherited Create(AGuid, AIdLpu);
    FSoapAction := '"http://tempuri.org/IEmkService/CreateCase"';
    FCase := ACase;
end;

destructor TCreateCaseMethod.Destroy;
begin
    FCase.Free;
    inherited;
end;

procedure TCreateCaseMethod.CreateRequestStream;
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

        // CREATECASE
        // <CreateCase>
        Node := Node.AddChild('tem:CreateCase');
        TXmlWriter.WriteString(Node.AddChild('tem:guid'), FGuid);

        Node := Node.AddChild('tem:createCaseDto');
        Casee.SaveToXml(Node, 'CreateCase');

        XmlDoc.SaveToStream(FRequestStream);

    finally
        XmlDoc := nil;
    end;
end;

end.
