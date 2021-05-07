{***************************************************************************************************
* Тип PaymentInfo
* Комплексный тип PaymentInfo предназначен для передачи сведений об оплате оказанных медицинских услуг. Описание параметров типа
* PaymentInfo приведено в таблице.
* HealthCareUnit  1..1  Integer  Идентификатор единицы учета медицинской помощи (Справочник OID: 1.2.643.5.1.13.2.1.1.80)
* IdPaymentType   1..1	Integer  Идентификатор источника финансирования (Справочник OID: 1.2.643.5.1.13.2.1.1.104)
* PaymentState    1..1	Integer  Идентификатор статуса оплаты услуги (Справочник OID: 1.2.643.5.1.13.2.7.1.41)
* Quantity        1..1	Integer  Количество выполненных (оказанных) услуг данного типа
* Tariff          1..1	Decimal  Сведения о тарифе (значение должно быть больше 0)
*
* Тип Service
* Комплексный тип Service предназначен для передаче данных о выполненных (оказанных) услугах в рамках эпизода случая обслуживания. Описание
* параметров типа Service представлено в таблице.
* DateEnd        1..1  DateTime     Дата окончания оказания услуги
* DateStart      1..1  DateTime     Дата начала оказания услуги
* IdServiceType  1..1  String       Код услуги по региональной номенклатуре(Справочник OID: 1.2.643.2.69.1.1.1.88)
* PaymentInfo    0..1  PaymentInfo  Информация об оплате услуги
* Performer      1..1  Participant  Сведения об исполнителе услуги
* ServiceName    1..1  String       Наименование услуги
***************************************************************************************************}
unit ServiceUnit;

interface

uses
    Xml.XmlDoc, Xml.XmlIntf, MedRecordUnit, ParticipantUnit;

type
    TPaymentInfoObject = class
    private
        FHealthCareUnit: Integer;
        FIdPaymentType: Integer;
        FPaymentState: Integer;
        FQuantity: Integer;
        FTariff: Real;
    public
        property HealthCareUnit: Integer read FHealthCareUnit;
        property IdPaymentType: Integer read FIdPaymentType;
        property PaymentState: Integer read FPaymentState;
        property Quantity: Integer read FQuantity;
        property Tariff: Real read FTariff;
        constructor Create(const AHealthCareUnit, AIdPaymentType, APaymentState, AQuantity: Integer; const ATariff: Real);
        procedure SaveToXml(const ANode: IXmlNode);
    end;

    TServiceObject = class (TMedRecordObject)
    private
        FDateStart: TDateTime;
        FDateEnd: TDateTime;
        FIdServiceType: String;
        FServiceName: String;
        FPaymentInfo: TPaymentInfoObject;
        FPerformer: TParticipantObject;
    public
        property DateStart: TDateTime read FDateStart;
        property DateEnd: TDateTime read FDateEnd;
        property IdServiceType: String read FIdServiceType;
        property ServiceName: String read FServiceName;
        property PaymentInfo: TPaymentInfoObject read FPaymentInfo;
        property Performer: TParticipantObject read FPerformer;
        constructor Create(const ADateStart, ADateEnd: TDateTime; const AIdServiceType, AServiceName: String;
            const APaymentInfo: TPaymentInfoObject; const APerformer: TParticipantObject);
        destructor Destroy; override;
        procedure SaveToXml(const ANode: IXmlNode); override;
    end;

implementation

uses XmlWriterUnit;

{ TPaymentInfoObject }

constructor TPaymentInfoObject.Create(const AHealthCareUnit, AIdPaymentType, APaymentState, AQuantity: Integer; const ATariff: Real);
begin
    FHealthCareUnit := AHealthCareUnit;
    FIdPaymentType := AIdPaymentType;
    FPaymentState := APaymentState;
    FQuantity := AQuantity;
    FTariff := ATariff;
end;

procedure TPaymentInfoObject.SaveToXml(const ANode: IXmlNode);
begin
    TXmlWriter.WriteInteger(ANode.AddChild('m:HealthCareUnit'), HealthCareUnit);
    TXmlWriter.WriteInteger(ANode.AddChild('m:IdPaymentType'), IdPaymentType);
    TXmlWriter.WriteInteger(ANode.AddChild('m:PaymentState'), PaymentState);
    TXmlWriter.WriteInteger(ANode.AddChild('m:Quantity'), Quantity);
    TXmlWriter.WriteFloat(ANode.AddChild('m:Tariff'), Tariff);
end;

{ TServiceObject }

constructor TServiceObject.Create(const ADateStart, ADateEnd: TDateTime; const AIdServiceType, AServiceName: String;
    const APaymentInfo: TPaymentInfoObject; const APerformer: TParticipantObject);
begin
    FDateStart := ADateStart;
    FDateEnd := ADateEnd;
    FIdServiceType := AIdServiceType;
    FServiceName := AServiceName;
    FPaymentInfo := APaymentInfo;
    FPerformer := APerformer;
end;

destructor TServiceObject.Destroy;
begin
    FPerformer.Free;
    FPaymentInfo.Free;
    inherited;
end;

procedure TServiceObject.SaveToXml(const ANode: IXmlNode);
var
    PaymentInfoNode, PerformerNode: IXmlNode;
begin
    TXmlWriter.WriteAttrString(ANode, 'i:type', 'm:Service');

    TXmlWriter.WriteDateTime(ANode.AddChild('m:DateStart'), DateStart);
    TXmlWriter.WriteDateTime(ANode.AddChild('m:DateEnd'), DateEnd);
    TXmlWriter.WriteString(ANode.AddChild('m:IdServiceType'), IdServiceType);
    TXmlWriter.WriteString(ANode.AddChild('m:ServiceName'), ServiceName);

    PaymentInfoNode := ANode.AddChild('m:PaymentInfo');
    if PaymentInfoNode = nil
    then TXmlWriter.WriteNull(PaymentInfoNode)
    else PaymentInfo.SaveToXml(PaymentInfoNode);

    PerformerNode := ANode.AddChild('m:Performer');
    if Performer = nil
    then TXmlWriter.WriteNull(PerformerNode)
    else Performer.SaveToXml(PerformerNode);
end;

end.
