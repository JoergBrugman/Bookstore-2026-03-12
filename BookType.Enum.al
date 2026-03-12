namespace GetUse.Academy.Bookstore;

using GetUse.Academy.Bookstore.Interface;
using Microsoft.Inventory.Costing;

enum 50100 "Book Type" implements "Book Type Process"
{
    Extensible = true;
    // DefaultImplementation = "Book Type Process" = "Book Type Default Impl.";
    UnknownValueImplementation = "Book Type Process" = "Book Type Default Impl.";

    value(0; " ")
    {
        Caption = 'None';
        Implementation = "Book Type Process" = "Book Type Default Impl.";
    }
    value(1; Hardcover)
    {
        Caption = 'Hardcover';
        Implementation = "Book Type Process" = "Book Type Hardcover Impl.";
    }
    value(2; Paperback)
    {
        Caption = 'Paperback';
        Implementation = "Book Type Process" = "Book Type Paperback Impl.";
    }
}