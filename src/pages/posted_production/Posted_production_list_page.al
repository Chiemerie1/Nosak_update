
page 50101 PostedProductionListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PostedProductionHeader;
    CardPageId = PostedProductionPage;
    Caption = 'Posted Production List';

    layout
    {
        area(Content)
        {
            repeater(control1)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field("Quantity"; Rec."Quantity")
                {
                    Caption = 'Quantity';
                }
                field("Due Date"; Rec."Date")
                {
                    Caption = 'Date';
                }

                field("Percentage"; Rec."Purity Percentage")
                {
                    Caption = 'Purity Percentage';
                    ApplicationArea = All;
                }
                field("Transfer From"; Rec."Transfer From")
                {
                    Caption = 'Transfer From';
                    ApplicationArea = All;
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    Caption = 'Transfer To';
                    ApplicationArea = All;
                }
                field("General Bus. Prod. Posting"; Rec."General Bus. Prod. Posting")
                {
                    Caption = 'General Bus. Prod. Posting';
                }

            }
            // group(GroupName)
            // {
            //     field(Name; NameSource)
            //     {

            //     }
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}