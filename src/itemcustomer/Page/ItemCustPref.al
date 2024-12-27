page 50101 "Item Customer Pref"
{
    PageType = ListPart;
    SourceTable = Item;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(ItemPreferencesRepeater)
            {
                field("Item Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                    Editable = false;
                }

                field(Preferred; Preferred)
                {
                    ApplicationArea = All;
                    Caption = 'Preferred';

                    trigger OnValidate()
                    var
                        CustItemPref: Record "Customer Item Preferences";
                    begin
                        if Preferred then begin
                            // To Insert or update Customer Item Preference table
                            if not CustItemPref.Get(CustomerNo, Rec."No.") then begin
                                CustItemPref.Init();
                                CustItemPref."Customer No." := CustomerNo;
                                CustItemPref."Item No." := Rec."No.";
                                CustItemPref."Item Description" := Rec.Description;
                                CustItemPref."Preferred" := true;
                                CustItemPref.Insert();
                            end else begin
                                CustItemPref."Preferred" := true;
                                CustItemPref.Modify();
                            end;
                        end else begin
                            // To Update preference to false
                            if CustItemPref.Get(CustomerNo, Rec."No.") then begin
                                CustItemPref."Preferred" := false;
                                CustItemPref.Modify();
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        CustomerNo: Code[20];
        Preferred: Boolean;

    trigger OnAfterGetRecord()
    var
        CustItemPref: Record "Customer Item Preferences";
    begin
        // To check if the current item is already marked as preferred for this customer
        Preferred := false;
        if CustItemPref.Get(CustomerNo, Rec."No.") then
            Preferred := CustItemPref."Preferred";
    end;

    trigger OnOpenPage()
    begin
        // To ensure the Customer No. is passed from the parent page
        if CustomerNo = '' then
            Error('Customer No. must be set.');
    end;

    procedure SetCustomerNo(NewCustomerNo: Code[20])
    begin
        CustomerNo := NewCustomerNo; // Store the passed customer number
    end;
}
