page 50102 "Item Customer Pref"
{
    PageType = ListPart;
    SourceTable = Item;
    ApplicationArea = All;
    RefreshOnActivate = true;

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
                            if not CustItemPref.Get(OwnerType, OwnerNo, Rec."No.") then begin
                                CustItemPref.Init();
                                CustItemPref."Owner Type" := OwnerType;
                                CustItemPref."Owner No." := OwnerNo;
                                CustItemPref."Item No." := Rec."No.";
                                CustItemPref."Item Description" := Rec.Description;
                                CustItemPref."Preferred" := true;
                                CustItemPref.Insert();
                            end else
                                CustItemPref."Preferred" := true;
                            CustItemPref.Modify();
                        end else
                            // To Update preference to false
                            if CustItemPref.Get(OwnerType, OwnerNo, Rec."No.") then begin
                                CustItemPref."Preferred" := false;
                                CustItemPref.Modify();
                            end;
                    end;
                }
            }
        }
    }

    var
        OwnerType: Enum "Owner Type";
        OwnerNo: Code[20];
        Preferred: Boolean;

    trigger OnAfterGetRecord()
    var
        CustItemPref: Record "Customer Item Preferences";
    begin
        // To check if the current item is already marked as preferred for this customer
        Preferred := false; // Initialize to false for new customers
        if CustItemPref.Get(OwnerType, OwnerNo, Rec."No.") then
            Preferred := CustItemPref."Preferred";

    end;

    procedure SetOwnerInfo(NewOwnerType: Enum "Owner Type"; NewOwnerNo: Code[20])
    begin
        OwnerType := NewOwnerType;
        OwnerNo := NewOwnerNo;
        //Message('OwnerType: %1, OwnerNo: %2', OwnerType, OwnerNo); // Debugging
    end;


}
