{***************************************************************************************************
* Структура SignData
* Структура SignData представляет собой XML-файл в кодировке UTF-8 и предназначена для передачи содержания медицинских документов с ЭЦП.
* Указанный XML-файл имеет следующую структуру:
* <?xml version="1.0" encoding="utf-8"?>
* <SignData>
*    <Data>...</Data>
*    <PublicKey>...</PublicKey>
*    <Hash>...</Hash>
*    <Sign>...</Sign>
* </SignData>
* Описание атрибутов структуры SingData представлено в таблице.
* Data       1..1  Base64binary  Данные вложения (текст, pdf, html,xml) в формате base64binary
* PublicKey  0..1  String        Публичный ключ сертификата ЭЦП
* Hash       0..1  String        Хеш-сумма данных. Расчет хеш-суммы производится по алгоритму ГОСТ Р 34.10-2012 (ГОСТ Р 34.10-2001). Значение хеш-суммы должно соответствовать данным, передаваемым в элементе Data в формате base64binary
* Sign       0..1  String        ЭЦП по ГОСТ Р 34.10-2012 (ГОСТ Р 34.10-2001)
* Важно:
*     Текстовые файлы должны передаваться в формате UNICODE UTF-16 (aka UCS-2 LE);
*     Набор символов HTML-документа должнен соответствовать utf-8 (charset="utf-8"), сам файл должен передаваться в формате UNICODE UTF-16.
* Если передается неподписанный документ, то поля PublicKey, Hash и Sign не заполняются.
*
* Тип DocumentAttachment
* Комплексный тип DocumentAttachment используется для передачи неструктурированных вложений документов. В таблице представлено описание
* комплексного типа DocumentAttachment.
* Data      0..1  Base64Binary  Cтруктура SignData в формате base64binary
* Hash      0..1  Base64Binary  Хэш данных (не используется для передачи в сервис)
* MimeType	0..1  String        Условно-обязателен (Если параметр Data заполнен). MIME-тип данных файла-вложения, передаваемых в атрибуте
*                               Data структуры SignData. Поддерживаемые MIME-типы: text/html – HTML; text/plain – текст; application/pdf –
*                               PDF; text/xml – XML.
* Url       0..1  String        Адрес (ссылка), где находятся данные (содержимое вложения).
*
* Тип MedDocument
* Комплексный тип MedDocument наследуется от типа MedRecord и является базовым для передачи медицинских документов. Описание параметров
* типа MedDocument приведено в таблице.
* CreationDate         1..1  DateTime            Дата создания документа
* FhirMedDocumentType  0..0  String              Идентификатор типа документа (не используется при передаче данных)
* IdDocumentMis        0..1  String              Идентификатор документа в системе-источнике (МИС)
* IdMedDocument        0..0  Integer             Идентификатор документа в БД (не используется при передаче данных)
* Attachment           0..1  DocumentAttachment  Неструктурированное (бинарное) содержание документа
* Author               1..1  MedicalStaff        Сведения о лице, создавшем документ
* Header               1..1  String              Заголовок документа (краткое описание)
*
* Подтип DischargeSummary
* Комплексный тип DischargeSummary используется для передачи информаци и содержания выписных эпикризов, отражающих сводные медицинские
* сведения стационарного случая обслуживания.
* Параметры типа DischargeSummary полностью соответствуют параметрам родительского типа MedDocument.
*
* Подтип LaboratoryReport
* Комплексный тип LaboratoryReport используется для передачи информации и содержания проведенных лабораторных исследований.
* Параметры типа LaboratoryReport полностью соответствуют параметрам родительского типа MedDocument.
*
* Подтип ConsultNote
* Комплексный тип ConsultNote используется для передачи информации и содержания заключений по результатам консультации или диагностического
* исследования. Объекты данного типа могут передавтьася как в рамках амбулаторного, так и в рамках стационарного случаев обслуживания.
* Параметры типа ConsultNote полностью соответствуют параметрам родительского типа MedDocument.
***************************************************************************************************}
unit MedDocumentUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, MedicalStaffUnit;

type
    TSignDataObject = class
    private
        FData: String;
        FPublicKey: String;
        FHash: String;
        FSign: String;
    public
        property Data: String read FData;
        property PublicKey: String read FPublicKey;
        property Hash: String read FHash;
        property Sign: String read FSign;
        constructor Create(const AData, APublicKey, AHash, ASign: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TDocumentAttachmentObject = class
    private
        FData: String;
        FHash: String;
        FMimeType: String;
        FUrl: String;
    public
        property Data: String read FData;
        property Hash: String read FHash;
        property MimeType: String read FMimeType;
        property Url: String read FUrl;
        constructor Create(const AData, AHash, AMimeType, AUrl: String);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TMedDocumentObject = class (TMedRecordObject)
    private
        FCreationDate: TDateTime;
        FIdDocumentMis: String;
        FAttachment: TDocumentAttachmentObject;
        FAuthor: TMedicalStaffObject;
        FHeader: String;
    public
        property CreationDate: TDateTime read FCreationDate;
        property IdDocumentMis: String read FIdDocumentMis;
        property Attachment: TDocumentAttachmentObject read FAttachment;
        property Author: TMedicalStaffObject read FAuthor;
        property Header: String read FHeader;
        constructor Create(const ACreationDate: TDateTime; const AIdDocumentMis: String; const AAttachment: TDocumentAttachmentObject;
            const AAuthor: TMedicalStaffObject; const AHeader: String);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TDischargeSummaryObject = class (TMedDocumentObject)
    public
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TLaboratoryReportObject = class (TMedDocumentObject)
    public
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

    TConsultNoteObject = class (TMedDocumentObject)
    public
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TSignDataObject }

constructor TSignDataObject.Create(const AData, APublicKey, AHash, ASign: String);
begin
    FData := AData;
    FPublicKey := APublicKey;
    FHash := AHash;
    FSign := ASign;
end;

procedure TSignDataObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteString(ANode.AddChild('mm:Data'), Data);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:PublicKey'), PublicKey);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Hash'), Hash);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Sign'), Sign);
end;

{ TDocumentAttachmentObject }

constructor TDocumentAttachmentObject.Create(const AData, AHash, AMimeType, AUrl: String);
begin
    FData := AData;
    FHash := AHash;
    FMimeType := AMimeType;
    FUrl := AUrl;
end;

procedure TDocumentAttachmentObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Data'), Data);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Hash'), Hash);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:MimeType'), MimeType);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:Url'), Url);
end;

{ TMedDocumentObject }

constructor TMedDocumentObject.Create(const ACreationDate: TDateTime; const AIdDocumentMis: String;
    const AAttachment: TDocumentAttachmentObject; const AAuthor: TMedicalStaffObject; const AHeader: String);
begin
    FCreationDate := ACreationDate;
    FIdDocumentMis := AIdDocumentMis;
    FAttachment := AAttachment;
    FAuthor := AAuthor;
    FHeader := AHeader;
end;

destructor TMedDocumentObject.Destroy;
begin
    FAuthor.Free;
    FAttachment.Free;
    inherited;
end;

procedure TMedDocumentObject.SaveToXml(const ANode: IXmlNode);
var
    AttachmentNode, AuthorNode: IXmlNode;
begin
    TXmlWriter.WriteDateTime(ANode.AddChild('mm:CreationDate'), CreationDate);
    TXmlWriter.WriteStringNullable(ANode.AddChild('mm:IdDocumentMis'), IdDocumentMis);

    AttachmentNode := ANode.AddChild('mm:Attachment');
    if Attachment = nil
    then TXmlWriter.WriteNull(AttachmentNode)
    else Attachment.SaveToXml(AttachmentNode);

    AuthorNode := ANode.AddChild('mm:Author');
    if Author = nil
    then TXmlWriter.WriteNull(AuthorNode)
    else Author.SaveToXml(AuthorNode);

    TXmlWriter.WriteString(ANode.AddChild('mm:Header'), Header);
end;

{ TDischargeSummaryObject }

procedure TDischargeSummaryObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:DischargeSummary');
    inherited SaveToXml(ANode);
end;

{ TLaboratoryReportObject }

procedure TLaboratoryReportObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:LaboratoryReport');
    inherited SaveToXml(ANode);
end;

{ TConsultNoteObject }

procedure TConsultNoteObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'mm:ConsultNote');
    inherited SaveToXml(ANode);
end;

end.
