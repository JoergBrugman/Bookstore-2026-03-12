namespace GetUse.Academy.Bookstore.Interface;

codeunit 50110 "Book Type Hardcover Impl." implements "Book Type Process"
{
    procedure StartDeployBook()
    begin
        Message('Aus Lager entnehmen');
    end;

    procedure StartDeliverBook()
    begin
        Message('Mit UPS versenden');
    end;
}