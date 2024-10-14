
page 50102 "Posted Production Line List"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Posted Production Line";
    Caption = 'Posted Production Line';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // field("Line No."; Rec."Line No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                // field("Document No."; Rec."Document No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("General Bus. Prod. Posting"; Rec."General Bus. Prod. Posting")
                {
                    Caption = 'General Bus. Prod. Posting';
                }
            }
        }
    }

    actions
    {

    }
}
