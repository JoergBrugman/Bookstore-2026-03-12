namespace GetUse.Academy.Bookstore.Interface;

codeunit 50103 "Book Type Paperback Impl." implements "Book Type Process V2"
{
    procedure StartDeployBook()
    begin
        Message('Print on Demand');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit DPD versenden');
    end;

    procedure CheckQuality()
    begin
        Message('E-Book Qualität OK');
    end;
}