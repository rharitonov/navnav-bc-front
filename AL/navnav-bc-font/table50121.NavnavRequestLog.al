table 50121 "Navnav Request Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }

        field(10; "User"; Text[60])
        {
            DataClassification = ToBeClassified;

        }

        field(20; "Remote Host"; Text[60])
        {
            DataClassification = ToBeClassified;

        }

        field(30; "Get Original Object"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Get Xliff Data"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(40; "To Convert Object ID"; Text[10])
        {
            DataClassification = ToBeClassified;

        }

        field(50; "Reqest Datetime"; DateTime)
        {
            DataClassification = ToBeClassified;

        }


        field(60; Status; Option)
        {
            OptionMembers = Ok,Error;
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}