namespace GetUse.Academy.Bookstore.InterfaceList;
using System.Reflection;

codeunit 50105 "Check Pipeline"
{
    procedure ProcessPipeline(Variant: Variant)
    var
        DataTypeManagement: Codeunit "Data Type Management";
        RecRef: RecordRef;
    begin
        if not DataTypeManagement.GetRecordRef(Variant, RecRef) then
            exit;
        ProcessPipeline(RecRef);
    end;

    procedure ProcessPipeline(RecRef: RecordRef)
    var
        Steps: List of [Interface "Check Step"];
        Step: Interface "Check Step";
        ResultTxt: Text;
        TxtBuilder: TextBuilder;
    begin
        CollectStep(Steps, RecRef);
        SortSteps(Steps);

        foreach Step in Steps do
            if Step.IsEnabled(RecRef) then begin
                ResultTxt := Step.Execute(RecRef);
                if ResultTxt <> '' then
                    TxtBuilder.AppendLine();
            end;
        if TxtBuilder.Length() > 0 then
            Message(TxtBuilder.ToText());
    end;

    local procedure CollectStep(var Steps: List of [Interface "Check Step"]; RecRef: RecordRef)
    begin
        OnRegisterCheckSteps(Steps, RecRef);
    end;

    local procedure SortSteps(var Steps: List of [Interface "Check Step"])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnRegisterCheckSteps(var Steps: List of [Interface GetUse.Academy.Bookstore.InterfaceList."Check Step"]; RecRef: RecordRef)
    begin
    end;
}