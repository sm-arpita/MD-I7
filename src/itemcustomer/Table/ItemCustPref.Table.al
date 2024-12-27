table 50100 "Customer Item Preferences"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
            Caption = 'Customer No.';
        }

        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            Caption = 'Item No.';
        }

        field(3; "Preferred"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred';
        }

        field(4; "Item Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred';
        }
    }

    keys
    {
        key(PK; "Customer No.", "Item No.")
        {
            Clustered = true;
        }
    }
}
