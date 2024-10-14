


tableextension 50100 SalesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "No."; Code[10])
        {
            TableRelation = "No. Series";
        }
    }
}


pageextension 50100 SalesReceivablesSetupPageExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("No."; Rec."No.")
            {
                Caption = 'Modified Prodution No.';
                ApplicationArea = All;
            }
        }
    }
}


table 50100 ProductionHeader
{
    DataClassification = ToBeClassified;
    Caption = 'Production Header';

    fields
    {
        field(50107; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            // Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(50100; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                itemRec: Record Item;
                manufacturingSetup: Record "Manufacturing Setup";
            begin

                if "Item No." <> '' then begin
                    if itemRec.Get("Item No.") then begin
                        Description := itemRec.Description;
                        if manufacturingSetup.Get() then begin
                            "General Bus. Prod. Posting" := manufacturingSetup."Mod Production Setup";
                        end;
                    end;
                end;



            end;
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
            TableRelation = "Manufacturing Setup";
            Editable = false;
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

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("No.");
            NoSeriesMgt.GetNextNo(SalesSetup."No.");
        end;
        "Created By" := UserId;
        "DateTime Created" := CurrentDateTime;
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