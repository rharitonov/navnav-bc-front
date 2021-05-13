page 50121 "Navnav Request Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Navnav Request Log";
    SourceTableView = order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                }

                field(User; Rec.User)
                {
                    ApplicationArea = All;

                }

                field("To Convert Object ID"; Rec."To Convert Object ID")
                {
                    ApplicationArea = All;

                }
                field("Reqest Datetime"; Rec."Reqest Datetime")
                {
                    ApplicationArea = All;

                }
                field("Get Original Object"; Rec."Get Original Object")
                {
                    ApplicationArea = All;

                }

                field("Get Translations"; Rec."Get Translations")
                {
                    ApplicationArea = All;

                }

                field("Remote Host"; Rec."Remote Host")
                {
                    ApplicationArea = All;

                }

                field(Status; Rec.Status)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}