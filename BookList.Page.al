
namespace GetUse.Academy.Bookstore;

using GetUse.Academy.Bookstore.Interface;
using GetUse.Academy.Bookstore.Tools;

page 50101 "Book List"
{
    Caption = 'Books';
    PageType = List;
    SourceTable = Book;
    Editable = false;
    CardPageId = "Book Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Books)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = 'de-DE=Nr.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(ISBN; Rec.ISBN)
                {
                    ToolTip = 'Specifies the value of the ISBN field.';
                }
                field(Author; Rec.Author)
                {
                    ToolTip = 'Specifies the value of the Author field.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No. of Pages"; Rec."No. of Pages")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the No. of Pages field.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links) { ApplicationArea = RecordLinks; }
            systempart(Notes; Notes) { ApplicationArea = Notes; }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CreateBooks)
            {
                Caption = 'Create Books';
                Image = CreateDocuments;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Books action.';
                RunObject = codeunit "Create Books";
            }
            action(SalesProcessSimple)
            {
                Caption = 'Simple Process';
                Image = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Simple Process action.';

                trigger OnAction()
                var
                    BookTypeHardcoverImpl: Codeunit "Book Type Hardcover Impl.";
                    BookTypePaperbackImpl: Codeunit "Book Type Paperback Impl.";
                    IsHandled: Boolean;
                begin
                    OnBeforeProcessBook(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "Book Type"::Hardcover:
                            begin
                                BookTypeHardcoverImpl.StartDeployBook();
                                BookTypeHardcoverImpl.StartDeliverBook();
                            end;
                        "Book Type"::Paperback:
                            begin
                                BookTypePaperbackImpl.StartDeployBook();
                                BookTypePaperbackImpl.StartDeliverBook();
                            end;
                    end;
                end;
            }
            action(SalesProcessWithInterface)
            {
                Caption = 'Sales Process with Interface';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Sales Process with Interface action.';

                trigger OnAction()
                var
                    BookTypeDefaultImpl: Codeunit "Book Type Default Impl.";
                    BookTypeHardcoverImpl: Codeunit "Book Type Hardcover Impl.";
                    BookTypePaperbackImpl: Codeunit "Book Type Paperback Impl.";
                    IsHandled: Boolean;
                    BookTypeProcess: Interface "Book Type Process";
                begin
                    this.OnBeforeProcessBook(Rec, IsHandled);
                    if IsHandled then
                        exit;

                    case Rec.Type of
                        "Book Type"::" ":
                            BookTypeProcess := BookTypeDefaultImpl;
                        "Book Type"::Hardcover:
                            BookTypeProcess := BookTypeHardcoverImpl;
                        "Book Type"::Paperback:
                            BookTypeProcess := BookTypePaperbackImpl;
                    end;

                    BookTypeProcess.StartDeployBook();
                    BookTypeProcess.StartDeliverBook();
                end;
            }
        }
        area(Reporting)
        {
            action(BookList)
            {
                Caption = 'Book List';
                Image = PrintReport;
                RunObject = report "Book - List";
                ToolTip = 'Executes the Book List report.';
            }
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnBeforeProcessBook(var Rec: Record Book; var IsHandled: Boolean)
    begin
    end;
}