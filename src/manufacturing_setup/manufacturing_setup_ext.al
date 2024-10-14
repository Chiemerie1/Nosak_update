tableextension 50101 ManufacturingSetupTableExt extends "Manufacturing Setup"
{
    fields
    {
        field(50101; "Mod Production Setup"; Code[20])
        {
            DataClassification = ToBeClassified;
            caption = 'Modified Production Setup';
            TableRelation = "Gen. Business Posting Group";
        }
    }

    keys
    {
        key(Key2; "Mod Production Setup")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}