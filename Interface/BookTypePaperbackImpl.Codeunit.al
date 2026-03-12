namespace GetUse.Academy.Bookstore.Interface;

codeunit 50103 "Book Type Paperback Impl." implements "Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DPD versenden');
    end;
}