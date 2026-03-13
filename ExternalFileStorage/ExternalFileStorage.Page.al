namespace GetUse.Academy.Bookstore.ExternalFileStorage;
using System.ExternalFileStorage;
using System.IO;

page 50103 "External File Storage"
{
    Caption = 'WN26 External File Storage';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Processing)
        {
            action(UploadToFileStorage)
            {
                Caption = 'Upload to File Storage';
                Image = Export;
                ToolTip = 'Executes the Upload to File Storage action.';

                trigger OnAction()
                var
                    ExternalFileStorage: Codeunit "External File Storage";
                    FileManagement: Codeunit "File Management";
                    Extension: Text;
                    FileName: Text;
                    InStr: InStream;
                    FilePath: Text;
                    NameOnly: Text;
                begin
                    if not UploadIntoStream('Select File', '', 'All Files (*.*)|*.*', FileName, InStr) then
                        exit;

                    NameOnly := FileManagement.GetFileNameWithoutExtension(FileName);
                    Extension := FileManagement.GetExtension(FileName);
                    ExternalFileStorage.Initialize("File Scenario"::WhatsNewBC26);
                    FilePath := ExternalFileStorage.SaveFile('', NameOnly, Extension, 'Save as');
                    ExternalFileStorage.CreateFile(FilePath, InStr);
                end;
            }
        }
        area(Navigation)
        {
            action(FileAccounts)
            {
                Caption = 'File Accounts';
                Image = Account;
                ToolTip = 'Executes the File Accounts action.';
                RunObject = page "File Accounts";
            }
        }
    }
}