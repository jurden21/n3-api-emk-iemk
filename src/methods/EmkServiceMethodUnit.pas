unit EmkServiceMethodUnit;

interface

uses
    ServiceMethodUnit;

type
    TEmkServiceMethod = class(TServiceMethod)
    public
        constructor Create(const AGuid, AIdLpu: String);
    end;

implementation

{ TEmkServiceMethod }

constructor TEmkServiceMethod.Create(const AGuid, AIdLpu: String);
begin
    FEndPoint := 'http://r52-rc.zdrav.netrika.ru/EMK3/EMKService.svc';
    inherited Create(AGuid, AIdLpu);
end;

end.
