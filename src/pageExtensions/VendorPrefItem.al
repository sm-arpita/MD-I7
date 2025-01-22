pageextension 50103 ItemSliderVendorExt extends "Vendor Card"
{
    layout
    {
        addlast(Content)
        {
            group(ItemPreferencesGroup)
            {
                Caption = 'Item Preferences';

                // To Add subpage for Customer Item Preferences
                part(VendorItemPreferencesPart; "Item Customer Pref")
                {
                    ApplicationArea = All;
                    Caption = 'Item Preferences';

                }
            }
        }
    }

    var
        VendorNo: Code[20];

    trigger OnAfterGetRecord()
    begin
        if Rec."No." <> VendorNo then begin
            VendorNo := Rec."No."; // Update the current customer number
            CurrPage.VendorItemPreferencesPart.PAGE.SetOwnerInfo(Enum::"Owner Type"::Vendor, VendorNo);
            CurrPage.VendorItemPreferencesPart.PAGE.Update(true);

        end;
    end;

    trigger OnOpenPage()
    begin
        VendorNo := Rec."No."; // To Pass the Customer No. from the main page
        CurrPage.VendorItemPreferencesPart.PAGE.SetOwnerInfo(Enum::"Owner Type"::Vendor, VendorNo);
    end;

}