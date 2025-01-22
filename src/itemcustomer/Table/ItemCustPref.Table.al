table 50101 "Customer Item Preferences"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Owner Type"; Enum "Owner Type")
        {
            Caption = 'Owner Type';
        }

        field(2; "Owner No."; Code[20])
        {
            Caption = 'Owner No.';
            TableRelation = IF ("Owner Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Owner Type" = CONST(Vendor)) Vendor."No.";
        }

        field(3; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'Item No.';
        }

        field(4; "Preferred"; Boolean)
        {
            Caption = 'Preferred';
        }

        field(5; "Item Description"; Text[200])
        {
            Caption = 'Item Description';
        }
    }

    keys
    {
        key(PK; "Owner Type", "Owner No.", "Item No.")
        {
            Clustered = true;
        }
    }
}
