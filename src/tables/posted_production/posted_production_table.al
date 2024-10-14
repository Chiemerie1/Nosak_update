


table 50104 PostedProductionHeader
{
    DataClassification = ToBeClassified;
    Caption = 'Posted Production Header';

    fields
    {
        field(50107; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // Editable = false;

        }
        field(50100; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
            TableRelation = Item."No.";

        }

        field(50101; Description; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Description';
            Editable = false;

        }
        field(50112; "Process Description"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Process Description';
            Editable = false;

        }



        field(50102; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
        }

        field(50103; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }

        field(50104; "Purity Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage produced';

            trigger OnValidate()
            begin
            end;

        }
        field(50105; "Transfer From"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer From';
            TableRelation = Location.Code;


        }
        field(50106; "Transfer To"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transfer To';
            TableRelation = Location.Code;

        }


        field(50108; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(50109; "DateTime Created"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(50110; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
        }

        field(50111; "General Bus. Prod. Posting"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'General Bus. Prod. Posting';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {

    }

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