namespace GetUse.Academy.Bookstore.InterfaceList;

interface "Check Step"
{
    procedure Execute(RecRef: RecordRef): Text;
    procedure GetSequence(): Integer;
    procedure IsEnabled(RecRef: RecordRef): Boolean;
}