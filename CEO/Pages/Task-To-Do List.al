page 50730 "To-Do List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "User Tasks";
    CardPageId = "To-Do Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                /*  field(No; Rec.No)
                 {
                     Caption = 'No.';
                     ApplicationArea = All;
                     Editable = false;                    
                 } */

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field("Assign To"; Rec."Assign To")
                {
                    Caption = 'Assigned To';
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;

                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;

                }
                field("Due Time"; Rec."Due Time")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Feedback; Rec.Feedback)
                {
                    ApplicationArea = All;

                }

                field("Task Details"; Rec."Task Details")
                {
                    ApplicationArea = All;

                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;

                }
                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}