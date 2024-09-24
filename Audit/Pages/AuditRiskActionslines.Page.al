page 63209 "Audit Risk Actions lines"
{
    PageType = List;
    SourceTable = 62306;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec.No)
                {
                    Caption = 'Entry No.';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Risk Code"; Rec."Risk Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Treatment Code"; Rec."Treatment Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Risk Treatment"; Rec."Risk Treatment")
                {
                    ApplicationArea = All;
                }
                field("Risk Action"; Rec."Risk Action")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            separator(" ")
            {
            }
            action("Action Steps")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 63210;
                RunPageLink = "Risk Code" = FIELD("Risk Code"),
                              TreatmentCode = FIELD("Treatment Code");
                ApplicationArea = All;
            }
        }
    }
}

