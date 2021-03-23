table 50120 "Navnav Object Cache"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(10; "Source Code"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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