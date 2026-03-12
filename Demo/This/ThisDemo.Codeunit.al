namespace GetUse.Academy.Bookstore.Demo.This;

codeunit 50101 "This-Demo"
{
    trigger OnRun()
    begin
        SetStateVar('Level 1');
        Message('In ürsprünglicher CU: %1', GetStateVar());
        CallThisProcedure(this);
        Message('In ürsprünglicher CU: %1', GetStateVar());
        ThisDemoClient.ThisClientProcedure(this);
        Message('In ürsprünglicher CU: %1', GetStateVar());
    end;

    var
        StateVar: Text;
        ThisDemoClient: Codeunit "This-Demo Client";

    procedure SetStateVar(Txt: Text)
    begin
        StateVar := Txt;
    end;

    procedure GetStateVar(): Text
    begin
        exit(StateVar);
    end;

    local procedure CallThisProcedure(ThisDemo: Codeunit "This-Demo")
    begin
        Message('In Referenz-CU: %1', ThisDemo.GetStateVar());
        ThisDemo.SetStateVar('Level 2');
        Message('In Referenz-CU: %1', ThisDemo.GetStateVar());
    end;
}