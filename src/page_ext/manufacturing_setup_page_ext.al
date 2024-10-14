

pageextension 50102 ManufacturingSetupPageExt extends "Manufacturing Setup"
{
    layout
    {
        addafter("Default Dampener %")
        {
            field("Mod Production Setup"; Rec."Mod Production Setup")
            {
                Caption = 'Mod Production Setup';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}