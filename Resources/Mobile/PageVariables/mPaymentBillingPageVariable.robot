*** Variables ***
@{Staging_MobileNumber_Postpaid1}    0891230221    111111
@{Staging_MobileNumber_Postpaid2}    0815486577    111111
@{Production_MobileNumber_Postpaid1}    0890674411    111111
&{Staging_Postpaid_Account1}    Mobile=0891230221    Email=Automate@gmail.com    PIN=111111
&{Staging_Postpaid_Account2}    Mobile=0937019652    Email=Automate@gmail.com    PIN=111111
&{Production_Postpaid_Account1}    Mobile=0890674411    Email=Automate.qa.teamsqar@gmail.com    PIN=111111
${SuspendBarredRequestHeaderEN}    Number suspended.
${SuspendBarredRequestHeaderTH}    หมายเลขระงับบริการชั่วคราว
${SuspendBarredRequestDetailsEN}    due to an overdue bill. To reactivate the service, please make payment.
${SuspendBarredRequestDetailsTH}    เนื่องจากมีค่าบริการค้างชำระเกินกำหนด    กรุณาชำระค่าบริการเพื่อเปิดสัญญาณ
${SuspendCreditLimittedHeaderEN}    Number Suspended at Your Request
${SuspendCreditLimittedHeaderTH}    หมายเลขระงับสัญญาณชั่วคราว
${SuspendCreditLimittedDetailsEN}    Your number is currently suspended upon your request.To reactivate it, please contact AIS Contact Center 1175 or AIS Shop.
${SuspendCreditLimittedDetailsTH}    หมายเลขของคุณขอระงับสัญญาณชั่วคราวไว้กับ AIS หากต้องการเปิดสัญญาณกรุณาติดต่อ AIS Contact Center 1175 หรือ AIS Shop
${PaymentlblPayBillHeaderExpected}    payment_header_pay_bill    #จ่ายบิล
${PaymentlblPayBillHeaderExpectedEN}    Pay Bill
${PaymentbtnBillHistoryExpected}    billing_tab_bill_history    #บิลย้อนหลัง
${PaymentbtnBillHistoryExpectedEN}    Bill History
${PaymentbtnMyBillsExpected}    payment_tab_my_bills    #บิลของฉัน
${PaymentbtnMyBillsExpectedEN}    My Bills
${PaymentbtnPayForOtherExpected}    payment_tab_pay_for_other    #จ่ายบิลให้หมายเลขอื่น
${PaymentbtnPayForOtherExpectedEN}    Pay for Other
${PaymentLblAmountToPayRequestTextTopicExpected}    payment_title_total_balance    #ยอดที่ต้องการชำระ
${PaymentLblAmountToPayRequestTextTopicExpectedEN}    Amount to pay
${PaymentLblBillCycleTextTopicExpected}    payment_outstanding_label_bill_cycle    #รอบบิล
${PaymentLblBillCycleTextTopicExpectedEN}    Billing cycle
${PaymentLblDueDateTextTopicExpected}    payment_outstanding_label_due_date    #กำหนดชำระ
${PaymentLblDueDateTextTopicExpectedEN}    Due date
${PaymentLblDueDateOverdueTextExpected}    payment_outstanding_label_overdue    #เกินกำหนด
${PaymentLblAmountTextTopicExpectedTH}    ยอดชำระ
${PaymentLblAmountTextTotalExpected}    payment_pay_bill_detail_total    #ทั้งหมด
${PaymentLblAmountTextTopicExpectedEN}    Amount to pay
${PaymentLblPayBillButtonTextExpected}    payment_button_pay_bill    #ชำระเงิน
${PaymentLblPayBillTextTopicExpectedEN}    Pay Bill
${PaymentLblAmountToPayTextExpected}    payment_title_total_balance    #ยอดที่ต้องการชำระ
${PaymentLblAdvancePaymentExpected}    payment_pay_bill_advance    #ชำระล่วงหน้า
${PaymentBtnBillDetailExpected}    payment_outstanding_button_bill_detail    #รายละเอียดบิล
${PaymentBtnBillDetailExpectedEN}    Bill detail
${PaymentLblTotalTextBottomsheetExpected}    billing_title_balance    #ยอดชำระ
${PaymentLblTotalTextTopicExpectedEN}    Total
${PaymentLblTermAndConditionTextExpected}    payment_bottom_term_condition    #เงื่อนไขการใช้บริการ
${PaymentLblTermAndConditionTextTopicExpectedEN}    Terms & Conditions
${PaymentLblCardTotalTextTopicExpectedTH}    ทั้งหมด
${PaymentLblCardTotalTextTopicExpectedEN}    Total
${PaymentLblAdvancePaymentButtomExpected}    payment_outstanding_label_advance_balance    #ชำระล่วงหน้าด้านล่าง
${PaymentLblAdditionalPaymentExpected}    payment_outstanding_label_overdue_balance_to_resume_services    #ยอดชำระเพิ่มเพื่อเปิดสัญญาณ
${PaymentLblWarnningTextExpectedEN}    Amount to pay
${PaymentBtnBillWarningCreditLimitExpected}    payment_outstanding_title_credit_limit
${PaymentBtnBillWarningOverdueExpected}    payment_outstanding_title_overdue
${PaymentBtnBillWarningNumberSuspenedExpected}    payment_outstanding_title_suspend
${PaymentBtnBillWarningNumberSuspenedfraudExpected}    payment_outstanding_title_suspend_fraud
${PaymentBtnBillWarningSuspenedWithYouRequestExpected}    payment_outstanding_title_barred_request
${PaymentBtnBillWarningPayBillToAvoidExpected}    payment_outstanding_overdue_desc
${PaymentBtnBillWarningSuspenedExceededCreditLimitExpected}    payment_outstanding_desc_credit_limit
${PaymentBtnBillWarningForAssistancePleaseContactAISExpected}    payment_outstanding_suspend_fraud_desc
${PaymentBtnBillWarningSuspendedUponYourRequestExpected}    payment_outstanding_desc_barred_request
${PaymentBtnBillWarningDuetoAnOverdueBillExpected}    payment_outstanding_desc_overdue
#Status
${PaymentStatusSuspendFraud}    suspendFraud
${PaymentStatusActive}    active
${PaymentStatusCreditLimitted}    creditLimitted
${PaymentStatusNearToCreditlimited}    neartocreditlimited
#curency
${PaymentlblCurencyExpectedTH}    บาท
${PaymentlblCurencyExpectedEN}    THB
#Warning Keyword
${PaymentStatusKeywordSuspenedWithYouRequest}    Number Suspended at your Request
${PaymentStatusKeywordCreditLimit}    Nearly reach credit limit
${PaymentStatusKeywordOverdue}    Overdue
${PaymentStatusKeywordNumberSuspened}    Number Suspended
${PaymentStatusKeywordNumberSuspenedfraud}    Number Suspenedfraud
#Detail
${PaymentStatusDetailKeywordPayBillToAvoid}    Please pay the bill to avoid
${PaymentStatusDetailKeywordSuspenedExceededCreditLimit}    Suspended due to exceeded credit limit
${PaymentStatusDetailKeywordForAssistancePleaseContactAIS}    For assistance please contact AIS
${PaymentStatusDetailKeywordSuspendedUponYourRequest}    Your number is currently suspended upon
${PaymentStatusDetailKeywordDuetoAnOverdueBill}    due to an overdue bill
