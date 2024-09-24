page 68919 "PRL-Payroll Role Center"
{
    Caption = ' Payroll Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }

            part("Approvals1"; "Approvals Activities Initial")
            {
                ApplicationArea = Suite;
            }
            part("Approvals2"; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }
            part("Approvals3"; "Approvals Activities Two")
            {
                ApplicationArea = Suite;


            }
            part("Approvals4"; "Approvals Activities Three")
            {
                ApplicationArea = Suite;

            }
            part("Approvals5"; "Approvals Activities Four")
            {
                ApplicationArea = Suite;

            }
            part("Approvals6"; "Approvals Activities Five")
            {
                ApplicationArea = Suite;

            }
            part("Approvals7"; "Approvals Activities six")
            {
                ApplicationArea = Suite;
            }
            part("Approvals8"; "Approvals Activities seven")
            {
                ApplicationArea = Suite;
            }
            part("Approvals9"; "Approvals Activities Eight")
            {
                ApplicationArea = Suite;
            }
            part("Approvals10"; "Approvals Activities Nine")
            {
                ApplicationArea = Suite;
            }
            part("Approvals11"; "Approvals Activities Ten")
            {
                ApplicationArea = Suite;
            }
        }
    }
    actions
    {
        area(reporting)
        {
            group(Reports2)
            {
                Caption = 'Payroll Reports';
                Image = Payables;
                action(Payslips)
                {
                    ApplicationArea = all;
                    Caption = 'Payslips';
                    Image = Report;

                    RunObject = Report "Individual Payslips mst";
                }
                action("Master Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Master Payroll Summary';
                    Image = Report;

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                action("Payroll Summary2")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Summary';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                action("Deductions Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";

                    //todo RunObject = Report "PRL-Deductions Summary 2";
                }
                action("Earnings Summary 2")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";

                    //todo  RunObject = Report "PRL-Payments Summary 2";
                }
                action("vew payslip")
                {
                    ApplicationArea = all;
                    Caption = 'vew payslip';
                    Image = "Report";

                    RunObject = Report "Individual Payslips mst";
                }
                action("Payroll summary")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll summary';
                    Image = "Report";

                    RunObject = Report "Payroll Summary 2";
                }
                action("Deductions Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = "Report";

                    //RunObject = Report "PRL-Deductions Summary";
                }
                action("Earnings Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = "Report";

                    //RunObject = Report "PRL-Earnings Summary";
                }
                action("Staff pension")
                {
                    ApplicationArea = all;
                    Caption = 'Staff pension';
                    Image = "Report";

                    //RunObject = Report "prStaff Pension Contrib";
                }
                action("Gross Netpay")
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = "Report";
                    RunObject = Report prGrossNetPay;
                }
                action("Third Rule")
                {
                    Caption = 'Third Rule';
                    Image = "Report";
                    RunObject = Report "A third Rule Report";
                    ApplicationArea = All;
                }
                action("P9 Report")
                {
                    ApplicationArea = all;
                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action("Co_op Remittance")
                {
                    ApplicationArea = all;
                    Caption = 'Co_op Remittance';
                    Image = "Report";
                    RunObject = Report "prCoop remmitance";
                }
                action(Transactions)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";
                    RunObject = Report "pr Transactions";
                }
                action("bank Schedule2")
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";
                    RunObject = Report "pr Bank Schedule";
                }

            }
            /*  group("Payroll Journals")
             {
                 action("Journals")
                 {
                     Image = JobJournal;
                     
                     RunObject = report prPayrollJournalTransfer;
                 }
             } */
        }
        area(sections)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = SNInfo;
                action("Salary Card")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Card';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    RunPageView = WHERE(Status = FILTER(Normal));
                }
                action("Inactive Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Inactive Employees';
                    Image = Employee;

                    RunObject = Page "HRM-Employee-List";
                    RunPageView = WHERE(Status = FILTER(<> Normal));
                }


                /* action("Payroll Mass Changes")
                {
                    Caption = 'Payroll Mass Changes';
                    Image = AddAction;
                    
                    RunObject = Page "HRM-Import Emp. Trans Buff";
                } */


                action("Payroll Approval")
                {
                    ApplicationArea = All;
                    RunObject = page 61842;
                }
            }

            group(Casual)
            {
                Caption = 'Casual Payroll';
                Image = Payroll;
                action(CasualEmpList)
                {
                    Caption = 'Casual Employee List';
                    Image = CustomerList;
                    RunObject = Page "HRM-Casual Pay List";
                    ApplicationArea = All;
                }
                action(CasualWorkDays)
                {
                    Caption = 'Casual Worked Days';
                    Image = Workdays;
                    RunObject = Page "PRL-Casual Worked Days";
                    ApplicationArea = All;
                }
                action(CasualPayrollPeriods)
                {
                    Caption = 'Casual Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "PRL-Casual Payroll Periods";
                    ApplicationArea = All;
                }

            }
            group("Salary Increaments")
            {
                Caption = 'Salary Increaments';
                Image = Intrastat;
                action("Salary Increament Process")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                }
                action("Salary Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Afected Salary Increaments")
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action("Leave Allowance Buffer")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Allowance Buffer';
                    Image = Bins;

                    RunObject = Page "HRM-Leave Allowance Buffer";
                }
            }
            group(SalaryAdvance)
            {
                Caption = 'Salary Advance';
                action(SalaryAdvance2)
                {
                    Caption = 'Salary Advance';
                    ApplicationArea = all;
                    RunObject = page "FIN-Staff Advance List";

                }

                action(SalaryAdvance3)
                {
                    Caption = 'Salary Advance(Retiring)';
                    ApplicationArea = all;
                    RunObject = page "FIN-Staff Advance Surr. List";

                }
            }

            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }
            }
            group("Common Requisitions")
            {
                action(ImprestRequisition)
                {
                    Caption = 'Imprest Requisition';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "FIN-Imprests List";
                }
                action("Staff Claims")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "FIN-Staff Claim List";
                }

                action("Purchase Requisition")
                {
                    ApplicationArea = All;
                    RunObject = page "FIN-Purchase Requisition";
                }
                action("Stores Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Memo Application")
                {
                    ApplicationArea = All;
                    Image = ManualExchangeRate;
                    RunObject = page "FIN-Memo Header List";
                }

            }
        }
        area(Embedding)
        {
            action("employeeupload")
            {
                RunObject = xmlport "Employee Upload";
                Caption = 'Employee Details bulk upload';
                ApplicationArea = all;


            }

            action("salarygrade")
            {
                RunObject = xmlport "Salary Grades";
                Caption = 'import salary grades';
                ApplicationArea = all;


            }
        }
        area(creation)
        {
            group(Payroll_Setups)
            {
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action("Payroll Period")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "PRL-Payroll Periods";
                }

                action("Pr Rates")
                {
                    ApplicationArea = all;
                    Caption = 'Pr Rates';
                    Image = SetupColumns;

                    RunObject = Page "PRL-Rates & Ceilings";
                }
                action("paye Setup")
                {
                    ApplicationArea = all;
                    Caption = 'paye Setup';
                    Image = SetupPayment;

                    RunObject = Page "PRL-P.A.Y.E Setup";
                }
                action(Action7)
                {
                    ApplicationArea = all;
                    Caption = 'Transcation Codes';
                    Image = Setup;

                    RunObject = Page "PRL-Transaction Codes List";
                }
                action(Action6)
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;

                    RunObject = Page "PRL-NHIF SetUp";
                }
                action("NSSF Setup")
                {
                    ApplicationArea = All;
                    Image = SetupPayment;
                    RunObject = page "PRL-NSSF";
                }
                action("Hr Employee Card")
                {
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "HRM-Employee (C)";
                }
                action("Bank Structure")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Structure';
                    Image = Bank;

                    RunObject = Page "PRL-Bank Structure (B)";
                }
                action("control information")
                {
                    ApplicationArea = all;
                    Caption = 'control information';
                    Image = CompanyInformation;

                    RunObject = Page "GEN-Control-Information";
                }
                action("Salary Grades")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;

                    RunObject = Page "PRL-Salary Grades";
                }
                action("posting group")
                {
                    ApplicationArea = all;
                    Caption = 'posting group';
                    Image = PostingEntries;

                    RunObject = Page "PRL-Employee Posting Group";
                }
                action(Action69)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Process';
                    Image = AddAction;

                    RunObject = Page "HRM-Emp. Categories";
                }
                action(Action68)
                {
                    ApplicationArea = all;
                    Caption = 'Salary Increament Register';
                    Image = Register;

                    RunObject = Page "HRM-Salary Increament Register";
                }
                action(Action66)
                {
                    ApplicationArea = all;
                    Caption = 'Un-Afected Salary Increaments';
                    Image = UndoCategory;

                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                action(Action9)
                {
                    ApplicationArea = all;
                    Caption = 'Payment Vouchers';
                    RunObject = Page "FIN-Payment Vouchers";
                }
                action("Staff Welfare Loan Tires")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Welfare Loan Tires';
                    RunObject = Page "HRM Welfare Loan Tiers";
                }
                /* action("PRL TRansaction Codes")
                {
                    ApplicationArea = All;
                    RunObject = page "PRL-Employee Transactions List";
                }
                action("Prl Period Transactions")
                {
                    ApplicationArea = All;
                    RunObject = Page "PRL-PeriodTransaction List";
                } */

            }
            group(PayRepts2)
            {
                Caption = 'Individual Payroll Reports';
                Image = ResourcePlanning;
                action("Individual Payslip")
                {
                    ApplicationArea = all;
                    Caption = 'Individual Payslip 1';
                    Image = Report2;

                    RunObject = Report "Individual Payslips V.1.1.3";
                }
                action("Individual Payslip 2")
                {
                    ApplicationArea = all;
                    Caption = 'Individual Payslip 2';
                    Image = Report2;

                    RunObject = Report "Individual Payslips mst";
                }
                action("Detailed Payroll Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Detailed Payroll Summary';
                    Image = Report2;

                    RunObject = Report "Payroll Summary 3";
                }

                action("Departmental Summary")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Departmental Summary';
                    Image = "Report";

                    //RunObject = Report "Payroll Summary (Depts)";
                }

                action(Action1000000047)
                {
                    ApplicationArea = all;
                    Caption = 'Company Payslip';
                    Image = "Report";

                    RunObject = Report "PRL-Company Payroll Summary 3";
                }
                /*  action("Company Payslip")
                 {
                     ApplicationArea = all;
                     Caption = 'Company Payslip 2';
                     Image = "Report";
                     
                     RunObject = Report "PRL-Company Payslip";
                 } */

                action(Action1000000044)
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary';
                    Image = DepositSlip;
                    RunObject = Report "PRL-Earnings Summary 5";
                }
                action(Action1000000042)
                {
                    ApplicationArea = all;
                    Caption = 'Earnings Summary 2';
                    Image = "Report";

                    RunObject = Report "PRL-Payments Summary 2 a";
                }
                action(Action1000000043)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary 2';
                    Image = "Report";

                    RunObject = Report "PRL-Deductions Summary 2 a";
                }
                action(Action1000000045)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions Summary';
                    Image = Report;
                    RunObject = Report "PRL-Deductions Summary1";
                }
                action(Action1000000041)
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Staff pension';
                    Image = Aging;
                    //RunObject = Report "prStaff Pension Contrib";
                }

            }
            group(PayrollPeoro)
            {
                Caption = 'Company Payroll Reports';
                Image = RegisteredDocs;
                action(Action1000000038)
                {
                    ApplicationArea = all;
                    Caption = 'P9 Report';
                    Image = PrintForm;

                    RunObject = Report "P9 Report (Final)";
                }
                action(Action1000000037)
                {
                    ApplicationArea = all;
                    Caption = 'Transactions';
                    Image = "Report";

                    RunObject = Report "pr Transactions";
                }
                action(Action1000000040)
                {
                    ApplicationArea = all;
                    Caption = 'Gross Netpay';
                    Image = Giro;
                    RunObject = Report prGrossNetPay;
                }
                action(Action1000000035)
                {
                    ApplicationArea = all;
                    Caption = 'bank Schedule';
                    Image = "Report";

                    RunObject = Report "pr Bank Schedule";
                }
                action("Employer Certificate")
                {

                    Caption = 'Employer Certificate';
                    Image = "Report";
                    ApplicationArea = All;

                    //RunObject = Report "Employer Certificate P.10 mst";
                }
                action("P.10")
                {
                    ApplicationArea = all;
                    Caption = 'P.10';
                    Image = "Report";

                    //RunObject = Report "P.10 A mst";
                }
                action("Paye Scheule")
                {
                    ApplicationArea = all;
                    Caption = 'Paye Schedule';
                    Image = "Report";

                    RunObject = Report "prPaye Schedule mst";
                }
                action("NHIF Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Schedult';
                    Image = "Report";

                    //RunObject = Report "prNHIF mst";
                }
                action("NSSF Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Schedule';
                    Image = "Report";

                    RunObject = Report "prNSSF mst";
                }
                action(Action1000000029)
                {
                    ApplicationArea = all;
                    Caption = 'Third Rule';
                    Image = AddWatch;
                    RunObject = Report "A third Rule Report";
                }
                action(Action1000000028)
                {

                    Caption = 'Co_op Remittance';
                    Image = CreateForm;
                    RunObject = Report "prCoop remmitance";
                    ApplicationArea = All;
                }
                /* action("payroll Journal Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Journal Transfer';
                    Image = Journals;
                    
                    RunObject = Report prPayrollJournalTransfer;
                } */

                action("Pension Report")
                {
                    ApplicationArea = all;
                    Caption = 'Pension Report';
                    Image = PrintForm;

                    RunObject = Report "PRL-Pension Report";
                }
                action("Bank Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Schedule';
                    Image = "Report";

                    RunObject = Report "PRL-Bank Schedule";
                }
                action("NHIF Report")
                {
                    ApplicationArea = all;
                    Caption = 'NHIF Report';
                    Image = "Report";

                    RunObject = Report "PRL-NHIF Report";
                }
                action("SACCO Report")
                {
                    ApplicationArea = all;
                    Caption = 'SACCO Report';
                    Image = "Report";

                    RunObject = Report "PRL-Welfare Report";
                }
                action("HELB Report")
                {
                    ApplicationArea = all;
                    Caption = 'HELB Report';
                    Image = "Report";

                    RunObject = Report "PRL-HELB Report";
                }
                action("NSSF Report (A)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (A)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report (A)";
                }
                action("NSSF Report (B)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (B)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report (B)";
                }
                action("NSSF Report (Combined)")
                {
                    ApplicationArea = all;
                    Caption = 'NSSF Report (Combined)';
                    Image = "Report";

                    RunObject = Report "PRL-NSSF Report Combined";
                }


            }
            group(prlComparision)
            {
                action(CumAll)
                {
                    ApplicationArea = all;
                    Caption = 'Cummulative Allowances';
                    Image = Aging;
                    //RunObject = Report "PRL-Cummulative Allowances";
                }
                action(cumDed)
                {
                    ApplicationArea = all;
                    Caption = 'Cummulative Allowances';
                    Image = Aging;
                    //RunObject = Report "PRL-Cummulative Deductions";
                }
                action(payrollvar)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Summary variance';
                    Image = Aging;
                    //RunObject = Report "PR Payroll Summary - Variance";
                }
                action(payrollvariace)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll variance';
                    Image = Aging;
                    //RunObject = Report "PRL-Payroll Variance Report2";
                }
                action(payrollvar2)
                {
                    ApplicationArea = all;
                    Caption = 'Payroll Variance 2';
                    Image = Aging;
                    //RunObject = Report "Payroll Variance Report";
                }
                action(DetPayVar)
                {
                    ApplicationArea = all;
                    Caption = 'Details Payroll Variance';
                    Image = Aging;
                    //RunObject = Report "PRL-Detailed Payroll Variance";
                }
                action(DetailedSimplifiedReport)
                {
                    ApplicationArea = all;
                    Caption = 'Detailed Simplified Payroll Report';
                    Image = Aging;
                    //RunObject = Report "PRL Detailed simplified Report";
                }
            }
        }
    }
}

