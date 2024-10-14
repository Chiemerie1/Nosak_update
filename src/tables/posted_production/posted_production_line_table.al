

table 50103 "Posted Production Line"
{
    DataClassification = ToBeClassified;
    Extensible = true;

    fields
    {

        field(50106; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting Date';
            Editable = False;
        }

        field(50111; "Entry Type"; Enum EntryType)
        {
            DataClassification = ToBeClassified;
            // OptionMembers = "Positive Adjmt","Negative Adjmt";
            Caption = 'Entry Type';
            Editable = False;
        }

        field(50101; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
            Editable = False;
            // TableRelation = ProductionHeader."No.";
        }

        field(50102; "Line No."; Integer) // NEW Field for uniqueness
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            AutoIncrement = true;
            Editable = False;
        }

        field(50103; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
            Editable = False;

        }
        field(50104; Description; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
            Editable = False;

        }

        field(50112; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Code';
            TableRelation = Location.Code;
            Editable = False;

        }

        field(50105; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
            Editable = False;

        }

        field(50108; "Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit of Measure';
            TableRelation = Item."Base Unit of Measure";
            Editable = False;
        }

        field(50107; "General Bus. Prod. Posting"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'General Bus. Prod. Posting';
            TableRelation = "Manufacturing Setup";
        }

    }

    keys
    {
        key(key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {

    }

    var
        ItemRec: Record Item;

}


