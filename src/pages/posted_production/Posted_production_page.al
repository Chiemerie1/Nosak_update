

page 50100 PostedProductionPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PostedProductionHeader;
    Caption = 'Posted Production';
    Editable = false;


    layout
    {
        area(Content)
        {
            group(General)
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

                field("Process Description"; Rec."Process Description")
                {
                    Caption = 'process Description';
                }

                field("Quantity"; Rec."Quantity")
                {
                    Caption = 'Quantity';
                }
                field("Due Date"; Rec.Date)
                {
                    Caption = 'Date';
                }

                field("Percentage"; Rec."Purity Percentage")
                {
                    Caption = 'Purity Percentage';
                }
                field("Transfer From"; Rec."Transfer From")
                {
                    Caption = 'Transfer From';
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    Caption = 'Transfer To';
                }

                field("General Bus. Prod. Posting"; Rec."General Bus. Prod. Posting")
                {
                    Caption = 'General Bus. Prod. Posting';
                }

            }

            part(ProductionLines; "Posted Production Line List")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }

        }
    }

    actions
    {
        area(Navigation)
        {

            action("Initiate Process")
            {
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                end;
            }

            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin

                end;
            }
        }
    }

    var
        itemRec: Record Item;
        ProductionLine: Record "Production Line 2";
        EndProdRec: Record Item;
        production: Record ProductionHeader;



}