unit MedRecordUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf;

type
    TMedRecordObject = class
    public
        procedure SaveToXml(const ANode: IXmlNode); virtual;
    end;

implementation

{ TMedRecordObject }

procedure TMedRecordObject.SaveToXml(const ANode: IXmlNode);
begin

end;

end.
