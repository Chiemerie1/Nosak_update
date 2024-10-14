

page 50105 ProductionPage
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = ProductionHeader;
    Caption = 'Production';
    Editable = true;


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

            part(ProductionLines; "Production Line List")
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
                    CalculatePercentage();
                    PopulateLine();
                end;
            }

            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()

                begin
                    EffectChange();
                end;
            }
        }
    }

    var
        itemRec: Record Item;
        ProductionLine: Record "Production Line 2";
        EndProdRec: Record Item;
        production: Record ProductionHeader;


    procedure PopulateLine()
    var
        itemRec: Record Item;
        productionLine: Record "Production Line 2";
        maxLineNo: Integer;
        lineNo: Integer;
    begin
        if Rec."Item No." <> '' then begin
            if itemRec.Get(Rec."Item No.") then begin

                if productionLine.FindSet() then begin
                    maxLineNo := 0;
                    repeat
                        if productionLine."Line No." > maxLineNo then
                            maxLineNo := productionLine."Line No.";
                    until productionLine.Next() = 0;
                end;

                for lineNo := 1 to 3 do begin

                    productionLine.Init();

                    productionLine."Posting Date" := Rec.Date;
                    productionLine."Document No." := Rec."No.";
                    productionLine."Line No." := maxLineNo + lineNo;
                    productionLine."Item No." := Rec."Item No.";
                    productionLine.Description := Rec.Description;
                    productionLine."Location Code" := Rec."Transfer From";
                    productionLine.Quantity := Rec.Quantity;
                    productionLine."Unit of Measure" := itemRec."Base Unit of Measure";
                    productionLine."Entry Type" := productionLine."Entry Type"::negative;
                    productionLine."General Bus. Prod. Posting" := Rec."General Bus. Prod. Posting";

                    if lineNo = 2 then begin
                        productionLine."Entry Type" := productionLine."Entry Type"::positive;
                        productionLine."Location Code" := Rec."Transfer To";

                    end
                    else if lineNo = 3 then begin
                        productionLine."Entry Type" := productionLine."Entry Type"::negative;
                        productionLine."Location Code" := Rec."Transfer To";
                        productionLine.Quantity := result;
                    end;

                    productionLine.Insert(true);


                end;
                Message('Insertion completed');
            end;
        end;
    end;


    var
        result: Decimal;

    procedure CalculatePercentage(): Decimal
    var
        percentage: Decimal;
        quantity: Decimal;
        residual_quantity: Decimal;
        ProductionLine: Record "Production Line 2";

    begin
        percentage := Rec."Purity Percentage" / 100;
        quantity := Rec.Quantity * percentage;
        residual_quantity := Rec.Quantity - quantity;
        result := residual_quantity;
        // Message('%1', quantity);
    end;


    procedure EffectChange()
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
        ProductionLine: Record "Production Line 2";
    begin

        CopyToPostedTables();

        If Rec."Item No." <> '' then begin
            if ProductionLine.FindSet() then begin
                repeat

                    if ProductionLine."Entry Type" = ProductionLine."Entry Type"::negative then begin
                        ItemJournalLine.Init();
                        ItemJournalLine."Journal Template Name" := 'ITEM';
                        ItemJournalLine."Journal Batch Name" := 'DEFAULT';
                        ItemJournalLine.Validate("Item No.", ProductionLine."Item No.");
                        ItemJournalLine.Validate("Location Code", ProductionLine."Location Code");
                        ItemJournalLine.Validate(Quantity, -ProductionLine.Quantity);
                        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                        ItemJournalLine."Posting Date" := ProductionLine."Posting Date";
                        ItemJournalLine."Document No." := ProductionLine."Document No.";
                        ItemJournalLine.Description := ProductionLine.Description;
                        ItemJournalLine."Unit of Measure Code" := ProductionLine."Unit of Measure";
                        ItemJournalLine.Validate("Gen. Bus. Posting Group", ProductionLine."General Bus. Prod. Posting");

                        ItemJnlPost.RunWithCheck(ItemJournalLine);
                    end;

                    if ProductionLine."Entry Type" = ProductionLine."Entry Type"::positive then begin
                        ItemJournalLine.Init();
                        ItemJournalLine."Journal Template Name" := 'ITEM';
                        ItemJournalLine."Journal Batch Name" := 'DEFAULT';
                        ItemJournalLine.Validate("Item No.", ProductionLine."Item No.");
                        ItemJournalLine.Validate("Location Code", ProductionLine."Location Code");
                        ItemJournalLine.Validate(Quantity, ProductionLine.Quantity);
                        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
                        ItemJournalLine."Posting Date" := ProductionLine."Posting Date";
                        ItemJournalLine."Document No." := ProductionLine."Document No.";
                        ItemJournalLine.Description := ProductionLine.Description;
                        ItemJournalLine."Unit of Measure Code" := ProductionLine."Unit of Measure";
                        ItemJournalLine.Validate("Gen. Bus. Posting Group", ProductionLine."General Bus. Prod. Posting");

                        ItemJnlPost.RunWithCheck(ItemJournalLine);
                    end;

                until ProductionLine.Next() = 0;



                if ProductionLine.FindSet() then begin
                    repeat
                        ProductionLine.Delete(true);
                    until ProductionLine.Next() = 0;
                end;

                Rec.Delete(true);
            end;

            Message('Adjustments have been successfully posted.');
        end else
            Error('Item No. is missing.');
    end;


    procedure CopyToPostedTables()
    var
        ProductionLine: Record "Production Line 2";
        PostedProductionHeader: Record "PostedProductionHeader";
        PostedProductionLine: Record "Posted Production Line";
        maxLineNo: Integer;
    begin

        PostedProductionHeader.Init();

        PostedProductionHeader."No." := Rec."No.";
        PostedProductionHeader."Item No." := Rec."Item No.";
        PostedProductionHeader.Description := Rec.Description;
        PostedProductionHeader.Quantity := Rec.Quantity;
        PostedProductionHeader."Date" := Rec.Date;
        PostedProductionHeader."Purity Percentage" := Rec."Purity Percentage";
        PostedProductionHeader."Transfer From" := Rec."Transfer From";
        PostedProductionHeader."Transfer To" := Rec."Transfer To";
        PostedProductionHeader."Process Description" := Rec."Process Description";
        PostedProductionHeader."General Bus. Prod. Posting" := Rec."General Bus. Prod. Posting";

        PostedProductionHeader.Insert(true);

        if PostedProductionLine.FindSet() then begin
            maxLineNo := 0;
            repeat
                if PostedProductionLine."Line No." > maxLineNo then
                    maxLineNo := PostedProductionLine."Line No.";
            until PostedProductionLine.Next() = 0;
        end;

        if ProductionLine.FindSet() then begin
            repeat
                if not PostedProductionLine.Get(ProductionLine."Document No.", ProductionLine."Line No.") then begin
                    PostedProductionLine.Init();

                    PostedProductionLine."Posting Date" := ProductionLine."Posting Date";
                    PostedProductionLine."Document No." := ProductionLine."Document No.";
                    PostedProductionLine."Line No." := maxLineNo + 1;
                    PostedProductionLine."Item No." := ProductionLine."Item No.";
                    PostedProductionLine.Description := ProductionLine.Description;
                    PostedProductionLine."Location Code" := ProductionLine."Location Code";
                    PostedProductionLine.Quantity := ProductionLine.Quantity;
                    PostedProductionLine."Unit of Measure" := ProductionLine."Unit of Measure";
                    PostedProductionLine."Entry Type" := ProductionLine."Entry Type";
                    PostedProductionLine."General Bus. Prod. Posting" := ProductionLine."General Bus. Prod. Posting";

                    PostedProductionLine.Insert(true);

                    maxLineNo += 1;
                end;
            until ProductionLine.Next() = 0;
        end;

        Message('Posted production');
    end;


}