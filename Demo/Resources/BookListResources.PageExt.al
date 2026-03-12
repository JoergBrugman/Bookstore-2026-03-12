namespace GetUse.Academy.Bookstore.Demo.Resources;
using GetUse.Academy.Bookstore;
using Microsoft.Sales.Customer;

pageextension 50103 "Book List Resources" extends "Book List"
{
    actions
    {
        addlast(Demo)
        {
            action(ResourceList)
            {
                Caption = 'List Resources';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the List Resources action.';

                trigger OnAction()
                var
                    ResList: List of [Text];
                    Txt: Text;
                    TxtBuilder: TextBuilder;
                begin
                    ResList := NavApp.ListResources();
                    foreach Txt in ResList do
                        TxtBuilder.AppendLine(Txt);
                    Message(TxtBuilder.ToText());
                end;
            }
            action(ResourceReadCSV)
            {
                Caption = 'Resource Read CSV';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Resource Read CSV action.';

                trigger OnAction()
                var
                    ResInStr: InStream;
                    Txt: Text;
                begin
                    NavApp.GetResource('ProgrammingLanguages.csv', ResInStr);
                    while not ResInStr.EOS do begin
                        ResInStr.ReadText(Txt);
                        Message(Txt);
                    end;
                end;
            }
            action(ResourceReadPNG)
            {
                Caption = 'Resource Read PNG';
                ApplicationArea = All;
                Image = Process;
                ToolTip = 'Executes the Resource Read PNG action.';

                trigger OnAction()
                var
                    Customer: Record Customer;
                    ResInStr: InStream;
                begin
                    NavApp.GetResource('Dynamics_365_Business_Central_logo.png', ResInStr);
                    Customer.Init();
                    Customer."No." := '';
                    Customer.Insert(true);
                    Customer.Image.ImportStream(ResInStr, 'Demo Picture');
                    Customer.Modify();
                    Page.Run(Page::"Customer Card", Customer);
                end;
            }
        }
    }
}