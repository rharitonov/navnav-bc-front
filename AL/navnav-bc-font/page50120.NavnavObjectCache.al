page 50120 "Navnav Object Cache"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Navnav Object Cache";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; rec.ID)
                {
                    ApplicationArea = All;

                }
                field(" Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportFileOfTextObjects)
            {
                Caption = 'Impot file of text objects';
                ApplicationArea = All;



                trigger OnAction();
                var
                    CSVBuffer: Record "CSV Buffer" temporary;
                    ObjCache: Record "Navnav Object Cache";
                    FileName, BaseFolder, ObjID, SrvFilename : Text;
                    InStream1: InStream;
                    OutStream1: OutStream;
                    MaxRowNo, R, C : Integer;
                    FM: Codeunit "File Management";
                    TempBlob: Codeunit "Temp Blob";
                    Wnd: Dialog;
                begin
                    BaseFolder := 'C:\Users\Administrator\YandexDisk-rharitonov\~NavNav\bonava-old-bojects\';
                    If not UploadIntoStream('Select SCV File', BaseFolder, '(*.csv)|*.csv', FileName, InStream1) then
                        exit;

                    Wnd.Open('Import file: #1################ \id: #2################');
                    ObjCache.Reset();
                    ObjCache.DeleteAll();

                    CSVBuffer.LoadDataFromStream(InStream1, ';');
                    MaxRowNo := CSVBuffer.GetNumberOfLines();
                    for R := 1 to MaxRowNo Do begin
                        FileName := CSVBuffer.GetValue(R, 1);
                        ObjID := CopyStr(FileName, 1, StrLen(FileName) - 4);
                        Wnd.Update(1, FileName);
                        Wnd.Update(2, ObjID);
                        if file.Exists(BaseFolder + FileName) then begin
                            C += 1;
                            ObjCache.Init();
                            ObjCache.ID := ObjID;
                            ObjCache."Source Code".Import(BaseFolder + FileName);
                            ObjCache.Insert()
                        end;
                    end;
                    Wnd.Close();
                    ObjCache.FindLast();
                    ObjCache.CalcFields("Source Code");
                    if ObjCache."Source Code".HasValue then
                        Message('OK')
                    else
                        Error('Empty');
                    Message('Imported: %1 of %2', C, MaxRowNo);
                end;

            }
        }
    }
}