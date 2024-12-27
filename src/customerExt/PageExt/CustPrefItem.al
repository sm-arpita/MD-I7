pageextension 50100 ItemSliderExt extends "Customer Card"
{
    layout
    {
        addlast(Content)
        {
            group(ItemPreferencesGroup)
            {
                Caption = 'Item Preferences';

                // To Add subpage for Customer Item Preferences
                part(CustomerItemPreferencesPart; "Item Customer Pref")
                {
                    ApplicationArea = All;
                    Caption = 'Item Preferences';

                }
            }
        }
    }

    var
        CustomerNo: Code[20];

    trigger OnOpenPage()
    begin
        CustomerNo := Rec."No."; // To Pass the Customer No. from the main page
        CurrPage.CustomerItemPreferencesPart.PAGE.SetCustomerNo(CustomerNo);
    end;

}
