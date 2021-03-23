codeunit 50120 "Navnav API"
{
    trigger OnRun()
    begin

    end;

    procedure GimmeAL(JsonParam: Text; ToConvertObjectID: Text; var ConvertedObject: Text; var OriginalObject: Text; var XliffData: Text) Result: Text
    var
        ObjCache: Record "Navnav Object Cache";
        Log: Record "Navnav Request Log";
        InStream1: InStream;
        OutStream1: OutStream;
        ff: File;
        InputFile: Label 'c:\Users\Administrator\src\navnav\txt\input.txt', Locked = true;
        OutputFile: Label 'c:\Users\Administrator\src\navnav\txt\output.txt', Locked = true;
    begin
        CreateLogEntry(Log, JsonParam, ToConvertObjectID);

        if not ObjCache.get(ToConvertObjectID) then
            Error('Object %1 does not exist', ToConvertObjectID)
        else begin
            ObjCache.CalcFields("Source Code");
            if not ObjCache."Source Code".HasValue then
                Error('There is no source code')
            else begin
                if Log."Get Original Object" then begin
                    ObjCache."Source Code".CreateInStream(InStream1, TextEncoding::MSDos);
                    InStream1.Read(OriginalObject);
                end;
                ObjCache."Source Code".CreateInStream(InStream1, TextEncoding::MSDos);
                ff.Create(InputFile, TextEncoding::MSDos);
                ff.CreateOutStream(OutStream1);
                CopyStream(OutStream1, InStream1);
                ff.Close();

                RunConverter();

                ff.Open(OutputFile, TextEncoding::UTF8);
                ff.CreateInStream(InStream1);
                InStream1.Read(ConvertedObject);

            end;
        end;

        Log.Status := Log.Status::Ok;
        Log.Modify;
        Result := 'Navnav 0.5.1. Copyright by HR:)';
    end;



    local procedure RunConverter()
    var
        PS: DotNet PowerShellRunner;
        PSCmd: Text;
        ScriptFile: Label 'C:\Users\Administrator\src\navnav-bc-front\AL\navnav-bc-font\RunConverter.ps1', Locked = true;
    begin
        PS := PS.CreateInSandbox;
        PS.WriteEventOnError(true);

        PSCmd := StrSubstNo('$ScriptPath = ''%1''; Invoke-Expression "$ScriptPath"', ScriptFile);
        PS.AddCommand('Invoke-Expression');
        PS.AddParameter('Command', PSCmd);
        PS.BeginInvoke();
        if IsNull(PS.Results) then;
        if PS.HadErrors() then
            Error('PS running errors occured. See system log.');
    end;


    local procedure CreateLogEntry(var NavnavLog: Record "Navnav Request Log"; JSONRequestParam: Text; ObjectID: Text)
    var
        JObject: JsonObject;
        JToken: JsonToken;
        EntryNo: Integer;
    begin
        if not JObject.ReadFrom(JSONRequestParam) then
            Error('Invalid JSON input parameter.');

        NavnavLog.Reset();
        if not NavnavLog.FindLast() then
            EntryNo := 1
        else
            EntryNo := NavnavLog."Entry No." + 1;
        NavnavLog.Init();
        NavnavLog."Entry No." := EntryNo;
        NavnavLog.User := GetJsonValueAsText(JObject, 'User');
        NavnavLog."Remote Host" := GetJsonValueAsText(JObject, 'RemoteHost');
        NavnavLog."Get Original Object" := GetJsonValueAsBool(JObject, 'GetOriganalObject');
        NavnavLog."Get Xliff Data" := GetJsonValueAsBool(JObject, 'GetXliffData');
        NavnavLog."To Convert Object ID" := ObjectID;
        NavnavLog."Reqest Datetime" := CurrentDateTime;
        NavnavLog.Status := NavnavLog.Status::Error;
        NavnavLog.Insert;

    end;

    local procedure GetJsonValueAsText(JObject: JsonObject; path: text) Result: Text
    var
        JToken: JsonToken;
    begin
        Result := '';
        JObject.SelectToken(path, JToken);
        if not JToken.AsValue().IsNull() then
            Result := JToken.AsValue().AsText();
    end;

    local procedure GetJsonValueAsBool(JObject: JsonObject; path: text) Result: Boolean
    var
        JToken: JsonToken;
    begin
        Result := false;
        JObject.SelectToken(path, JToken);
        if not JToken.AsValue().IsNull() then
            Result := JToken.AsValue().AsBoolean();
    end;

}