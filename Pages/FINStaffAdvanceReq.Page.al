page 68273 "FIN-Staff Advance Req."
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "FIN-Staff Advance Header";
    SourceTableView = WHERE(Posted = CONST(false),
                            Status = FILTER(<> Cancelled));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = DateEditable;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = GlobalDimension1CodeEditable;
                    ApplicationArea = All;
                }
                field("Function Name"; Rec."Function Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = ShortcutDimension2CodeEditable;
                    ApplicationArea = All;
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Editable = ShortcutDimension3CodeEditable;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Dim3; Rec.Dim3)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = ShortcutDimension4CodeEditable;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Dim4; Rec.Dim4)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = "Currency CodeEditable";
                    ApplicationArea = All;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Editable = "Paying Bank AccountEditable";
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field(Cashier; Rec.Cashier)
                {
                    Caption = 'Requestor ID';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Net Amount LCY"; Rec."Total Net Amount LCY")
                {
                    ApplicationArea = All;
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    Editable = "Payment Release DateEditable";
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Editable = "Pay ModeEditable";
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    Caption = 'Cheque/EFT No.';
                    Editable = "Cheque No.Editable";
                    ApplicationArea = All;
                }
            }
            part(PVLines; "REG-Staff Advance Lines")
            {
                SubPageLink = No = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Payment and Print")
                {
                    Caption = 'Post Payment and Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;

                        Rec.RESET;
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(39005918, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                separator("rep1")
                {
                }
                action("Post Payment")
                {
                    Caption = 'Post Payment';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CheckImprestRequiredItems;
                        PostImprest;
                    end;
                }
                separator(rep2)
                {
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    RunObject = page "Approval Entries";
                    RunPageLink = "Document No." = field("No.");
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    /* trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin
                        // Check Budget First
                        CommitBudget;
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        IF NOT AllFieldsEntered THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                            ERROR('There are some lines that have not been committed');

                        //Release the Imprest for Approval
                        State := State::Open;
                        IF Rec.Status <> Rec.Status::Pending THEN State := State::"Pending Approval";
                        DocType := DocType::"Staff Advance";
                        CLEAR(tableNo);
                        tableNo := 39005638;
                        //IF ApprovalMgt.SendApproval(tableNo, Rec."No.", DocType, State, Rec."Responsibility Center", Rec."Total Payment Amount") THEN;
                    end; */
                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Init Code";
                    begin
                        CommitBudget;
                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');
                        IF NOT AllFieldsEntered THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                        //Ensure No Items That should be committed that are not
                        IF LinesCommitmentStatus THEN
                            ERROR('There are some lines that have not been committed');
                        // ApprovalMgt.OnSendAdvanceforApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                        showmessage: Boolean;
                        ManualCancel: Boolean;
                        State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                        tableNo: Integer;
                    begin

                        CancelCommitment;
                        DocType := DocType::"Staff Advance";
                        showmessage := TRUE;
                        ManualCancel := TRUE;
                        CLEAR(tableNo);
                        tableNo := 39005638;
                        //IF ApprovalMgt.CancelApproval(tableNo, DocType, Rec."No.", showmessage, ManualCancel) THEN;
                    end;
                }
                separator(rep3)
                {
                }
                action("Check Budgetary Availability")
                {
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BCSetup: Record "FIN-Budgetary Control Setup";
                    begin

                        BCSetup.GET;
                        IF NOT BCSetup.Mandatory THEN
                            EXIT;

                        IF NOT LinesExists THEN
                            ERROR('There are no Lines created for this Document');

                        IF NOT AllFieldsEntered THEN
                            ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        //First Check whether other lines are already committed.
                        Commitments.RESET;
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                        Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                        IF Commitments.FIND('-') THEN BEGIN
                            IF CONFIRM('Lines in this Document appear to be committed do you want to re-commit?', FALSE) = FALSE THEN BEGIN EXIT END;
                            Commitments.RESET;
                            Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                            Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                            Commitments.DELETEALL;
                        END;

                        CheckBudgetAvail.CheckStaffAdvance(Rec);
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you Wish to Cancel the Commitment entries for this document', FALSE) = FALSE THEN BEGIN EXIT END;

                        Commitments.RESET;
                        Commitments.SETRANGE(Commitments."Document Type", Commitments."Document Type"::StaffAdvance);
                        Commitments.SETRANGE(Commitments."Document No.", Rec."No.");
                        Commitments.DELETEALL;

                        PayLine.RESET;
                        PayLine.SETRANGE(PayLine.No, Rec."No.");
                        IF PayLine.FIND('-') THEN BEGIN
                            REPEAT
                                PayLine.Committed := FALSE;
                                PayLine.MODIFY;
                            UNTIL PayLine.NEXT = 0;
                        END;
                    end;
                }
                separator(rep4)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF Rec.Status <> Rec.Status::Approved THEN
                            ERROR('You can only print after the document is Approved');
                        Rec.RESET;
                        Rec.SETFILTER("No.", Rec."No.");
                        REPORT.RUN(39005918, TRUE, TRUE, Rec);
                        Rec.RESET;
                    end;
                }
                separator(rep5)
                {
                }
                action("Cancel Document")
                {
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                    begin
                        CancelCommitment;

                        //TESTFIELD(Status,Status::Approved);
                        IF (Rec.Status = Rec.Status::Approved) OR (Rec.Status = Rec.Status::Pending) THEN BEGIN
                            IF CONFIRM(Text000, TRUE) THEN BEGIN
                                //Post Committment Reversals
                                Doc_Type := Doc_Type::Imprest;
                                BudgetControl.ReverseEntries(Doc_Type, Rec."No.");
                                Rec.Status := Rec.Status::Cancelled;
                                Rec.MODIFY;
                            END ELSE
                                ERROR(Text001);

                        END;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Currency CodeEditable" := TRUE;
        DateEditable := TRUE;
        ShortcutDimension2CodeEditable := TRUE;
        GlobalDimension1CodeEditable := TRUE;
        "Cheque No.Editable" := TRUE;
        "Pay ModeEditable" := TRUE;
        "Paying Bank AccountEditable" := TRUE;
        "Payment Release DateEditable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        //check if the documenent has been added while another one is still pending
        TravReqHeader.RESET;
        //TravAccHeader.SETRANGE(SaleHeader."Document Type",SaleHeader."Document Type"::"Cash Sale");
        TravReqHeader.SETRANGE(TravReqHeader.Cashier, USERID);
        TravReqHeader.SETRANGE(TravReqHeader.Status, Rec.Status::Pending);

        IF TravReqHeader.COUNT > 0 THEN BEGIN
            ERROR('There are still some pending document(s) on your account. Please list & select the pending document to use.  ');
        END;
        //*********************************END ****************************************//


        Rec."Payment Type" := Rec."Payment Type"::Imprest;
        Rec."Account Type" := Rec."Account Type"::Customer;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
        //Add dimensions if set by default here
        Rec."Global Dimension 1 Code" := UserMgt.GetSetDimensions(USERID, 1);
        Rec.VALIDATE("Global Dimension 1 Code");
        Rec."Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(USERID, 2);
        Rec.VALIDATE("Shortcut Dimension 2 Code");
        Rec."Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(USERID, 3);
        Rec.VALIDATE("Shortcut Dimension 3 Code");
        Rec."Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(USERID, 4);
        Rec.VALIDATE("Shortcut Dimension 4 Code");

    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FILTERGROUP(0);
        END;
        UpdateControls;
    end;

    var
        PayLine: Record "FIN-Staff Advance Lines";
        PVUsers: Record "FIN-CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "FIN-Payments Header";
        RecPayTypes: Record "FIN-Receipts and Payment Types";
        TarriffCodes: Record "FIN-Tariff Codes";
        GenJnlLine: Record 81;
        DefaultBatch: Record 232;
        CashierLinks: Record "FIN-Cash Office User Template";
        LineNo: Integer;
        Temp: Record "FIN-Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "FIN-Payments Header";
        BankAcc: Record 270;
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record "FIN-Committment";
        UserMgt: Codeunit "User Setup Management BR";
        JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash;
        BudgetControl: Codeunit "Budgetary Control";
        TravReqHeader: Record "FIN-Staff Advance Header";
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Paying Bank AccountEditable": Boolean;
        [InDataSet]
        "Pay ModeEditable": Boolean;
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        BCSetup: Record "FIN-Budgetary Control Setup";
        FINBudgetEntries: Record "FIN-Budget Entries";
        FINStaffAdvanceLines: Record "FIN-Staff Advance Lines";


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "FIN-Budgetary Control Setup";
    begin
        IF BCsetup.GET() THEN BEGIN
            IF NOT BCsetup.Mandatory THEN BEGIN
                Exists := FALSE;
                EXIT;
            END;
        END ELSE BEGIN
            Exists := FALSE;
            EXIT;
        END;
        Exists := FALSE;
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        PayLine.SETRANGE(PayLine.Committed, FALSE);
        PayLine.SETRANGE(PayLine."Budgetary Control A/C", TRUE);
        IF PayLine.FIND('-') THEN
            Exists := TRUE;
    end;


    procedure PostImprest()
    begin

        IF Temp.GET(USERID) THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.DELETEALL;
        END;

        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Rec."Payment Release Date";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."External Document No." := Rec."Cheque No.";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
        GenJnlLine."Account No." := Rec."Account No.";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Description := 'Advance: ' + Rec."Account No." + ':' + Rec.Payee;
        Rec.CALCFIELDS("Total Net Amount");
        GenJnlLine.Amount := Rec."Total Net Amount";
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
        GenJnlLine."Bal. Account No." := Rec."Paying Bank Account";
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        //Added for Currency Codes
        GenJnlLine."Currency Code" := Rec."Currency Code";
        GenJnlLine.VALIDATE("Currency Code");
        GenJnlLine."Currency Factor" := Rec."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        /*
        GenJnlLine."Currency Factor":=Payments."Currency Factor";
        GenJnlLine.VALIDATE("Currency Factor");
        */
        GenJnlLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");

        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;


        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);

        Post := FALSE;
        Post := JournlPosted.PostedSuccessfully();
        IF Post THEN BEGIN
            Rec.Posted := TRUE;
            Rec."Date Posted" := TODAY;
            Rec."Time Posted" := TIME;
            Rec."Posted By" := USERID;
            Rec.Status := Rec.Status::Posted;
            Rec.MODIFY;
        END;

    end;


    procedure CheckImprestRequiredItems()
    begin

        Rec.TESTFIELD("Payment Release Date");
        Rec.TESTFIELD("Paying Bank Account");
        Rec.TESTFIELD("Account No.");
        Rec.TESTFIELD("Account Type", Rec."Account Type"::Customer);

        IF Rec.Posted THEN BEGIN
            ERROR('The Document has already been posted');
        END;

        Rec.TESTFIELD(Status, Rec.Status::Approved);

        /*Check if the user has selected all the relevant fields*/

        Temp.GET(USERID);
        JTemplate := Temp."Advance Template";
        JBatch := Temp."Advance  Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the Staff Advance Template is set up in Cash Office Setup');
        END;

        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the Staff Advance Batch is set up in the Cash Office Setup')
        END;

        IF NOT LinesExists THEN
            ERROR('There are no Lines created for this Document');

    end;


    procedure UpdateControls()
    begin
        IF Rec.Status <> Rec.Status::Approved THEN BEGIN
            "Payment Release DateEditable" := FALSE;
            "Paying Bank AccountEditable" := FALSE;
            "Pay ModeEditable" := FALSE;
            //CurrForm."Currency Code".EDITABLE:=FALSE;
            "Cheque No.Editable" := FALSE;
            //CurrPage.UpdateControls();
        END ELSE BEGIN
            "Payment Release DateEditable" := TRUE;
            "Paying Bank AccountEditable" := TRUE;
            "Pay ModeEditable" := TRUE;
            "Cheque No.Editable" := TRUE;
            //CurrForm."Currency Code".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        END;

        IF Rec.Status = Rec.Status::Pending THEN BEGIN
            GlobalDimension1CodeEditable := TRUE;
            ShortcutDimension2CodeEditable := TRUE;
            //CurrForm.Payee.EDITABLE:=TRUE;
            ShortcutDimension3CodeEditable := TRUE;
            ShortcutDimension4CodeEditable := TRUE;
            DateEditable := TRUE;
            //CurrForm."Account No.".EDITABLE:=TRUE;
            "Currency CodeEditable" := TRUE;
            //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
            //CurrPage.UpdateControls();
        END ELSE BEGIN
            GlobalDimension1CodeEditable := FALSE;
            ShortcutDimension2CodeEditable := FALSE;
            //CurrForm.Payee.EDITABLE:=FALSE;
            ShortcutDimension3CodeEditable := FALSE;
            ShortcutDimension4CodeEditable := FALSE;
            DateEditable := FALSE;
            //CurrForm."Account No.".EDITABLE:=FALSE;
            "Currency CodeEditable" := FALSE;
            //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
            //CurrPage.UpdateControls();
        END
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "FIN-Staff Advance Lines";
    begin
        HasLines := FALSE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            HasLines := TRUE;
            EXIT(HasLines);
        END;
    end;


    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "FIN-Staff Advance Lines";
    begin
        AllKeyFieldsEntered := TRUE;
        PayLines.RESET;
        PayLines.SETRANGE(PayLines.No, Rec."No.");
        IF PayLines.FIND('-') THEN BEGIN
            REPEAT
                IF (PayLines."Account No:" = '') OR (PayLines.Amount <= 0) THEN
                    AllKeyFieldsEntered := FALSE;
            UNTIL PayLines.NEXT = 0;
            EXIT(AllKeyFieldsEntered);
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdateControls();
    end;

    local procedure CommitBudget()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Advance Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINStaffAdvanceLines.RESET;
        FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
        IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Check if budget exists
                FINStaffAdvanceLines.TESTFIELD("Account No:");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                FINBudgetEntries.RESET;
                FINBudgetEntries.SETRANGE("Budget Name", BCSetup."Current Budget Code");
                FINBudgetEntries.SETRANGE("G/L Account No.", FINStaffAdvanceLines."Account No:");
                FINBudgetEntries.SETRANGE("Global Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                FINBudgetEntries.SETFILTER("Transaction Type", '%1|%2|%3', FINBudgetEntries."Transaction Type"::Expense, FINBudgetEntries."Transaction Type"::Commitment
                , FINBudgetEntries."Transaction Type"::Allocation);
                FINBudgetEntries.SETFILTER("Commitment Status", '%1|%2',
                FINBudgetEntries."Commitment Status"::" ", FINBudgetEntries."Commitment Status"::Commitment);
                FINBudgetEntries.SETFILTER(Date, PostBudgetEnties.GetBudgetStartAndEndDates(Rec.Date));
                IF FINBudgetEntries.FIND('-') THEN BEGIN
                    IF FINBudgetEntries.CALCSUMS(Amount) THEN BEGIN
                        IF FINBudgetEntries.Amount > 0 THEN BEGIN
                            IF (FINStaffAdvanceLines.Amount > FINBudgetEntries.Amount) THEN ERROR('Less Funds, Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                            // Commit Budget Here
                            PostBudgetEnties.CheckBudgetAvailability(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
                            FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
                        END ELSE
                            ERROR('No allocation for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
                    END;
                END ELSE
                    ERROR('Missing Budget for  Account:' + GLAccount.Name + ', Department:' + DimensionValue.Name);
            END;
            UNTIL FINStaffAdvanceLines.NEXT = 0;
        END;
    end;

    local procedure ExpenseBudget()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Advance Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINStaffAdvanceLines.RESET;
        FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
        IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                FINStaffAdvanceLines.TESTFIELD("Account No:");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (FINStaffAdvanceLines.Amount > 0) THEN BEGIN
                    // Commit Budget Here
                    PostBudgetEnties.ExpenseBudget(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
                    FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", USERID, TODAY, 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
                END;
            END;
            UNTIL FINStaffAdvanceLines.NEXT = 0;
        END;
    end;

    local procedure CancelCommitment()
    var
        GLAccount: Record 15;
        DimensionValue: Record 349;
        PostBudgetEnties: Codeunit "Post Budget Enties";
    begin
        BCSetup.GET;
        IF NOT ((BCSetup.Mandatory) AND (BCSetup."Advance Budget Mandatory")) THEN EXIT;
        BCSetup.TESTFIELD("Current Budget Code");
        Rec.TESTFIELD("Shortcut Dimension 2 Code");
        //Get Current Lines to loop through
        FINStaffAdvanceLines.RESET;
        FINStaffAdvanceLines.SETRANGE(No, Rec."No.");
        IF FINStaffAdvanceLines.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                // Expense Budget Here
                FINStaffAdvanceLines.TESTFIELD("Account No:");
                GLAccount.RESET;
                GLAccount.SETRANGE("No.", FINStaffAdvanceLines."Account No:");
                IF GLAccount.FIND('-') THEN GLAccount.TESTFIELD(Name);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, Rec."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE("Global Dimension No.", 2);
                IF DimensionValue.FIND('-') THEN DimensionValue.TESTFIELD(Name);
                IF (FINStaffAdvanceLines.Amount > 0) THEN BEGIN
                    // Commit Budget Here
                    PostBudgetEnties.CancelBudgetCommitment(FINStaffAdvanceLines."Account No:", Rec.Date, '', Rec."Shortcut Dimension 2 Code",
                    FINStaffAdvanceLines.Amount, FINStaffAdvanceLines."Account Name", USERID, 'ADVANCE', Rec."No." + FINStaffAdvanceLines."Account No:", Rec.Purpose);
                END;
            END;
            UNTIL FINStaffAdvanceLines.NEXT = 0;
        END;
    end;
}

