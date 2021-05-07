{***************************************************************************************************
* Тип DeathInfo
* В объекте DeathInfo осуществляется передача данных о летальном исходе (причине смерти) в рамках стационарного случая обслуживания.
* MKBCode  1..1  String  Код МКБ-10 основной (первоначальной) причины смерти (OID справочника: 1.2.643.2.69.1.1.1.2)
***************************************************************************************************}
unit DeathInfoUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TDeathInfoObject = class (TMedRecordObject)
    private
        FMkbCode: String;
    public
        property MkbCode: String read FMkbCode;
        constructor Create(const AMkbCode: String);
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TDeathInfoObject }

constructor TDeathInfoObject.Create(const AMkbCode: String);
begin
    FMkbCode := AMkbCode;
end;

procedure TDeathInfoObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:DeathInfo');
    TXmlWriter.WriteString(ANode.AddChild('m:MkbCode'), MkbCode);
end;

end.
