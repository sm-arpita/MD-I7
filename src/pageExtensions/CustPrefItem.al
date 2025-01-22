pageextension 50102 ItemSliderExt extends "Customer Card"
{
    layout
    {
        addlast(Content)
        {
            group("ItemPreferencesGroup")
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

    actions
    {
        addlast(Processing)
        {
            action(ManualRefresh)
            {
                Caption = 'Refresh Item Preference Section';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.Update(false); // Refresh the entire Customer Card page
                end;
            }
        }
    }

    var
        CustomerNo: Code[20];

    trigger OnAfterGetRecord()
    begin
        if Rec."No." <> CustomerNo then begin
            CustomerNo := Rec."No."; // Update the current customer number
            CurrPage.CustomerItemPreferencesPart.PAGE.SetOwnerInfo(Enum::"Owner Type"::Customer, CustomerNo);
            CurrPage.CustomerItemPreferencesPart.PAGE.Update(true);
        end;
    end;



    trigger OnOpenPage()
    begin
        CustomerNo := Rec."No."; // Initialize the customer number when the page opens
        CurrPage.CustomerItemPreferencesPart.PAGE.SetOwnerInfo(Enum::"Owner Type"::Customer, CustomerNo);
        CurrPage.CustomerItemPreferencesPart.PAGE.Update(true);
    end;
}
