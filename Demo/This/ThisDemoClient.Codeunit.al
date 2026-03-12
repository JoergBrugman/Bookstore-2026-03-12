namespace GetUse.Academy.Bookstore.Demo.This;

codeunit 50102 "This-Demo Client"
{
    procedure ThisClientProcedure(ThisDemo: Codeunit "This-Demo")
    begin
        Message('In Client-CU: %1', ThisDemo.GetStateVar());
        ThisDemo.SetStateVar('Level 3 (Client)');
        Message('In Client-CU: %1', ThisDemo.GetStateVar());
    end;
}