namespace GetUse.Academy.Bookstore.InterfaceList;
using System.Reflection;
using System.Utilities;

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
                    TxtBuilder.AppendLine(ResultTxt);
            end;
        if TxtBuilder.Length() > 0 then
            Message(TxtBuilder.ToText());
    end;

    local procedure CollectStep(var Steps: List of [Interface "Check Step"]; RecRef: RecordRef)
    begin
        OnRegisterCheckSteps(Steps, RecRef);
    end;

    local procedure SortSteps(var Steps: List of [Interface "Check Step"])
    var
        Integer: Record Integer;
        Step: Interface "Check Step";
        Sorted: List of [Interface "Check Step"];
    begin
        // Vorkommen der Sequences aus der Liste merken
        foreach Step in Steps do begin
            Integer.Get(Step.GetSequence());
            Integer.Mark(true);
        end;
        // Auf die markierten Integers filtern
        Integer.MarkedOnly(true);

        // Die Sequences nacheinander durchgehen
        if Integer.FindSet() then
            repeat
                // Jetzt die Interfaces, die zu einer Sequence gehören, nacheinader in sortierte Liste übertragen
                foreach Step in Steps do
                    if Step.GetSequence() = Integer.Number then
                        Sorted.Add(Step);
            until Integer.Next() = 0;
        Steps := Sorted;
    end;

    local procedure SortStepsBubleSort(var Steps: List of [Interface "Check Step"])
    var
        Temp: Interface "Check Step";
        I, J : Integer;
        Swapped: Boolean;
    begin
        if Steps.Count() <= 1 then
            exit;

        for I := 1 to Steps.Count() - 1 do begin
            Swapped := false;
            for J := 1 to Steps.Count() - I do
                if Steps.Get(J).GetSequence() > Steps.Get(J + 1).GetSequence() then begin
                    Temp := Steps.Get(J);
                    Steps.Set(J, Steps.Get(J + 1));
                    Steps.Set(J + 1, Temp);
                    Swapped := true;
                end;
            if not Swapped then
                break;
        end;
    end;


    [IntegrationEvent(false, false)]
    local procedure OnRegisterCheckSteps(var Steps: List of [Interface GetUse.Academy.Bookstore.InterfaceList."Check Step"]; RecRef: RecordRef)
    begin
    end;

    // 1. Customer Prüfung: Ein ausländischer Debitor soll keinen Rech.-an Debitor haben.
    // 2. Customer Prüfung: Ein ausländischer  Debitor soll immer von Lagerort GELB beliefert werden.
}