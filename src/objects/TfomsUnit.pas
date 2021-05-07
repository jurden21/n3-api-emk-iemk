{***************************************************************************************************
* Тип TfomsInfo
* Комплексный тип TfomsInfo предназначен для передачи данных о выполненных медицинских стандартах в разрезе учета ТФОМС. Описание
* параметров типа TfomsInfo представлено в таблице.
* Count        1..1  Integer  Количество выполненных стандартов учета оказания медицинской помощи
* IdTfomsType  1..1  String   Идентификатор услуги регионального справочника ТФОМС. (Справочник OID: 1.2.643.2.69.1.1.1.63
* Tariff       0..1  Decimal  Тариф
***************************************************************************************************}
unit TfomsUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit;

type
    TTfomsObject = class (TMedRecordObject)
    private
        FCount: Integer;
        FIdTfomsType: String;
        FTariff: Real;
    public
        property Count: Integer read FCount;
        property IdTfomsType: String read FIdTfomsType;
        property Tariff: Real read FTariff;
        constructor Create(const ACount: Integer; const AIdTfomsType: String; const ATariff: Real);
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TTfomsObject }

constructor TTfomsObject.Create(const ACount: Integer; const AIdTfomsType: String; const ATariff: Real);
begin
    FCount := ACount;
    FIdTfomsType := AIdTfomsType;
    FTariff := ATariff;
end;

procedure TTfomsObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:TfomsInfo');
    TXmlWriter.WriteInteger(ANode.AddChild('m:Count'), Count);
    TXmlWriter.WriteString(ANode.AddChild('m:IdTfomsType'), IdTfomsType);
    TXmlWriter.WriteFloatNullable(ANode.AddChild('m:Tariff'), Tariff);
end;

end.
