*** Settings ***
Resource          ../../../Configuration/Mobile/GlobalConfig/AllResource.robot

*** Keywords ***
mFindButtonUsageHistoryAndClick
    [Arguments]    ${locator}
    FOR    ${i}    IN RANGE    6
        ${Status}    Run Keyword And Return Status    Wait For Element    ${locator}${i}    0.5
        Run Keyword If    ${Status}==True    Run Keywords    Click Element    ${locator}${i}
        ...    AND    Exit For Loop
        ...    ELSE    Continue For Loop
    END

mCheckValidateCardMyBill
    [Arguments]    ${ExpectedInformation}=${EMPTY}    ${ExpectedInformationDetail}=${EMPTY}    ${ExpectedNoMember}=No Member    ${PayAmount}=${EMPTY}
    [Documentation]    ตรวจสอบรายละเอียดการ์ด
    ...    Example :
    ...    | mCheckValidateCard | WarnningHeader | WarnningDetail | No Member | Amount to pay ( ในกรณีที่เป็นคำว่าชำระล่วงหน้า ) |
    ...
    ...    Example :
    ...    | mCheckValidateCard | Number Suspended at your Request | Please pay the bill to avoid | No Member |
    ...
    ...    *WarnningHeader*
    ...    | ${PaymentStatusKeywordSuspenedWithYouRequest} : หมายเลขระงับสัญญาณชั่วคราว |
    ...    | ${PaymentStatusKeywordCreditLimit} : ใกล้เต็มวงเงิน |
    ...    | ${PaymentStatusKeywordOverdue} : เกินกำหนดชำระ |
    ...    | ${PaymentStatusKeywordNumberSuspened} : หมายเลขระงับบริการชั่วคราว |
    ...    | ${PaymentStatusKeywordNumberSuspenedfraud} : หมายเลขระงับบริการชั่วคราว (ในกรณีที่ s เป็นตัวพิมพ์เล็ก) |
    ...
    ...    *WarnningDetail*
    ...    | ${PaymentStatusDetailKeywordPayBillToAvoid} : กรุณาชำระค่าบริการเพื่อหลีกเลี่ยงการถูกระงับสัญญาณ |
    ...    | ${PaymentStatusDetailKeywordSuspenedExceededCreditLimit} : ระงับสัญญาณเนื่องจากใช้งานเกินวงเงินค่าใช้บริการ |
    ...    | ${PaymentStatusDetailKeywordForAssistancePleaseContactAIS} : ข้อมูลเพิ่มเติม \ กรุณาติดต่อ AIS Contact Center 1175 หรือ AIS Shop |
    ...    | ${PaymentStatusDetailKeywordSuspendedUponYourRequest} : หมายเลขของคุณขอระงับสัญญาณชั่วคราวไว้กับ AIS หากต้องการเปิดสัญญาณกรุณาติดต่อ AIS Contact Center 1175 หรือ AIS Shop |
    ...    | ${PaymentStatusDetailKeywordDuetoAnOverdueBill} : เนื่องจากมีค่าบริการค้างชำระเกินกำหนด \ กรุณาชำระค่าบริการเพื่อเปิดสัญญาณ |
    #Validate Avatar
    Wait For Element    ${PaymentImgAvatar}    20
    #Validate Profile Name
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    ${PaymentLblNumberAsset}
    ${ProfileName}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    ${PaymentLblNumberAsset}
    Run Keyword If    '${KeyIDisVisible}'=='True'    Should Not Be Empty    ${ProfileName}
    Comment    ${Masking}    Set Variable    True
    Comment    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    ${PaymentLblNumberAsset}
    Comment    ${PhoneNumber}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    ${PaymentLblNumberAsset}
    Comment    ${Regexp}    Set Variable If    "${Masking}" == "True"    xxx    \\d{3}
    Comment    Run Keyword If    '${KeyIDisVisible}'=='True'    Should Match Regexp    ${PhoneNumber}    ^\\d{3}-?${Regexp}-?\\d{4}$
    #ValidatePhonenum
    ${Masking}    Set Variable    True
    Wait For Element    ${PaymentLblNumberBill}    20
    ${PhoneNumber}    Get Element Text    ${PaymentLblNumberBill}
    Should Be Equal    ${PhoneNumber}    ${MobileNumberOrEmail}[0]${MobileNumberOrEmail}[1]${MobileNumberOrEmail}[2]-${MobileNumberOrEmail}[3]${MobileNumberOrEmail}[4]${MobileNumberOrEmail}[5]-${MobileNumberOrEmail}[6]${MobileNumberOrEmail}[7]${MobileNumberOrEmail}[8]${MobileNumberOrEmail}[9]
    #ValidateWarning
    ${StatusCardWarning}    Run Keyword And Return Status    Wait For Element    ${PaymentCardAlertWarningTextHeading}
    #ValidateWarning 'Nearly reach credit limit'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Nearly reach credit limit'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextHeading}    ${PaymentBtnBillWarningCreditLimitExpected}
    Comment    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Nearly reach credit limit'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    payment_outstanding_overdue_desc
    #ValidateWarning 'Overdue'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Overdue'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextHeading}    ${PaymentBtnBillWarningOverdueExpected}
    #ValidateWarning 'Number Suspended'    payment_outstanding_desc_credit_limit    payment_outstanding_suspend_fraud_desc
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Number Suspended'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextHeading}    ${PaymentBtnBillWarningNumberSuspenedExpected}
    #ValidateWarning 'Number Suspended'    payment_outstanding_desc_credit_limit    payment_outstanding_suspend_fraud_desc    payment_outstanding_title_suspend_fraud
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Number Suspenedfraud'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextHeading}    ${PaymentBtnBillWarningNumberSuspenedfraudExpected}
    #ValidateWarning 'Number Suspended at your Request'    payment_outstanding_desc_barred_request
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformation}'=='Number Suspended at your Request'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextHeading}    ${PaymentBtnBillWarningSuspenedWithYouRequestExpected}
    # ถ้า${ExpectedInformation}ไม่มีข้อความแจ้งเตือนต้องไม่มีข้อความแจ้งเตือน
    Run Keyword If    '${ExpectedInformation}'=='${EMPTY}' and '${StatusCardWarning}'=='True'    Fail    <font style="color:red" size="3">&#9679</font>Wrong Warnning !!
    #ValidateWarning 'Please pay the bill to avoid service suspension. '    payment_outstanding_desc_overdue
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformationDetail}'=='Please pay the bill to avoid'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    ${PaymentBtnBillWarningPayBillToAvoidExpected}
    #ValidateWarning 'Suspended due to exceeded credit limit'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformationDetail}'=='Suspended due to exceeded credit limit'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    ${PaymentBtnBillWarningSuspenedExceededCreditLimitExpected}
    #ValidateWarning 'For assistance please contact AIS'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformationDetail}'=='For assistance please contact AIS'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    ${PaymentBtnBillWarningForAssistancePleaseContactAISExpected}
    #ValidateWarning 'Your number is currently suspended upon'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformationDetail}'=='Your number is currently suspended upon'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    ${PaymentBtnBillWarningSuspendedUponYourRequestExpected}
    #ValidateWarning 'due to an overdue bill'
    Run Keyword If    '${StatusCardWarning}'=='True' and '${ExpectedInformationDetail}'=='due to an overdue bill'    mValidatewithCoreLang    ${PaymentCardAlertWarningTextSupport}    ${PaymentBtnBillWarningDuetoAnOverdueBillExpected}
    #Validate Amount to Pay
    ${AmounttoPayText}    Run Keyword And Return Status    mValidatewithCoreLang    ${PaymentLblAmountToPayRequestTextTopic}    ${PaymentLblAmountToPayTextExpected}
    Run Keyword If    '${AmounttoPayText}'=='False'    mValidatewithCoreLang    ${PaymentLblAmountToPayRequestTextTopic}    ${PaymentLblAdvancePaymentExpected}    #ทำต่อเมื่อแสดงชำระล่วงหน้า
    #Validate Amount to Pay Detail
    mCheckFormatBahtwithUnit    ${PaymentLblAmountToPayRequestTextDetail}
    Set Global Variable    ${countindex}    0
    FOR    ${countindex}    IN RANGE    99
        ${KeyIDVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${countindex}/chmListContent/0/labelText    20    #รอบบิล
        ${LineBottom}    Run Keyword And Return Status    Wait For Element    billAndPayPayMBill/allBill/chmCardPayBill/${countindex}/sectionContentAllDetail/chmDivider
        ${IconVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${countindex}/chmListConten/0/icon    20
        ${TextPayAhead}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${countindex}/sectionLabelWithIcon/titleText    #ยอดชำระ หรือ ชำระล่วงหน้า
        Run Keyword If    '${KeyIDVisible}'=='True' and '${IconVisible}'=='True'    mCheckPayBillDetail    ${countindex}    #${ExpectedOverDue}
        Run Keyword If    '${KeyIDVisible}'=='True' and '${IconVisible}'=='False' and '${PayAmount}'=='Amount to pay'    Run Keywords    mValidatewithCoreLang    ${PaymentLblAmountActivateSignalTextTopic}    ${PaymentLblAdvancePaymentButtomExpected}
        ...    AND    mCheckFormatBahtwithUnit    ${PaymentLblAmountActivateSignalTextDetail}    #ชำระล่วงหน้า
        Run Keyword If    '${KeyIDVisible}'=='True' and '${IconVisible}'=='False'    Run Keywords    mValidatewithCoreLang    ${PaymentLblAmountActivateSignalTextTopic}    ${PaymentLblAdditionalPaymentExpected}
        ...    AND    mCheckFormatBahtwithUnit    ${PaymentLblAmountActivateSignalTextDetail}    #ชำระเพิ่มเมื่อเปิดสัญญาน
        Comment    Run Keyword If    '${LineBottom}'=='True'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/textButton    ${PaymentBtnBillDetailExpected${LANGUAGE}}
        Comment    Run Keyword If    '${TextPayAhead}'=='True' and '${IconVisible}'=='False'    Run Keywords    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/${countindex}/sectionLabelWithIcon/titleText    payment_outstanding_label_advance_balance
        ...    AND    mCheckFormatBahtwithUnit    ${PaymentLblAmountTextDetail}
        Exit For Loop If    '${KeyIDVisible}'=='False' or '${LineBottom}'=='False'
        ${countindex}    Evaluate    ${countindex}+1
    END
    #Validate Member
    ${StatusMember}    Run Keyword And Return Status    Wait For Element    ${PaymentLblMemberTitle}
    Run Keyword If    '${StatusMember}'=='False' and '${ExpectedNoMember}'=='Member'    Fail    <font style="color:red" size="3">&#9679</font>Member not found
    Run Keyword If    '${StatusMember}'=='True' and '${ExpectedNoMember}'=='NoMember'    Fail    <font style="color:red" size="3">&#9679</font>Member should not found

mCheckPayBillDetail
    [Arguments]    ${i}    ${Expected}=${EMPTY}
    #Validate icon Bill Cycle
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/0/icon    20
    #Validate Bill Cycle
    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/labelText    ${PaymentLblBillCycleTextTopicExpected}    #รอบบิล
    Comment    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/labelText    ${PaymentLblBillCycleTextTopicExpected${LANGUAGE}}
    #Validate Month
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/supportText
    ${Text}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/supportText
    Log    ${Text}
    ${clean_Text}    Strip String    ${Text}
    ${pattern}    Set Variable    (?:January|February|March|April|May|June|July|August|September|October|November|December|มกราคม|กุมภาพันธ์|มีนาคม|เมษายน|พฤษภาคม|มิถุนายน|กรกฎาคม|สิงหาคม|กันยายน|ตุลาคม|พฤศจิกายน|ธันวาคม)\\s+\\d{4}
    Should Match Regexp    ${Text}    ${pattern}
    #Validate Icon Due Date
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/1/icon    20
    #Validate Due Date
    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/labelText    ${PaymentLblDueDateTextTopicExpected}    #กำหนดชำระ
    Comment    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/labelText
    #Validate Due Date Detail
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/supportText
    ${Text}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/supportText
    Log    ${Text}
    ${clean_Text}    Strip String    ${Text}
    ${pattern}    Set Variable    (?:0?[1-9]|[1-2][0-9]|3[01])\\s(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|ม\\.ค\\.|ก\\.พ\\.|มี\\.ค\\.|ม\\.ย\\.|พ\\.ค\\.|มิ\\.ย\\.|ก\\.ค\\.|ส\\.ค\\.|ก\\.ย\\.|ต\\.ค\\.|พ\\.ย\\.|ธ\\.ค\\.)\\s+\\d{4}$
    Should Match Regexp    ${Text}    ${pattern}
    #Validate OverDue Text    text สีแดง
    #Get Today Date
    ${CurrentDate}    mGetCurrentDate
    log    ${CurrentDate}
    # Convert Date to Timestamp
    ${ActuralDate}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${0}/chmListContent/1/supportText
    ${ActuralDate}    mConvertToTimestamp    ${ActuralDate}
    #Check OverDue
    mCheckandGetTextOverdue    ${ActuralDate}    ${CurrentDate}    ${i}
    #Validate Icon Total
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/2/icon    20
    log    ${KeyIDisVisible}
    #ValidateTotal
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/labelText    20
    Run Keyword If    '${KeyIDisVisible}'=='True'    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/labelText    ${PaymentLblAmountTextTotalExpected}
    Run Keyword If    '${KeyIDisVisible}'=='True'    mCheckFormatBahtwithUnit    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/supportText

CheckAmountToPayDetails
    [Arguments]    ${i}
    [Documentation]    ตรวจสอบข้อมูลจ่ายบิลของฉัน ในการ์ดยอดที่ต้องชำระ ในส่วน
    ...    รอบบิล
    ...    กำหนดชำระ
    ...    ทั้งหมด
    #Validate icon Bill Cycle
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/0/icon    20
    #Validate Bill Cycle
    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/labelText    payment_outstanding_label_bill_cycle
    Comment    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/labelText    ${PaymentLblBillCycleTextTopicExpected${LANGUAGE}}
    #Validate Month
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/supportText
    ${Text}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/0/supportText
    Log    ${Text}
    ${clean_Text}    Strip String    ${Text}
    ${pattern}    Set Variable    (?:January|February|March|April|May|June|July|August|September|October|November|December|มกราคม|กุมภาพันธ์|มีนาคม|เมษายน|พฤษภาคม|มิถุนายน|กรกฎาคม|สิงหาคม|กันยายน|ตุลาคม|พฤศจิกายน|ธันวาคม)\\s+\\d{4}
    Should Match Regexp    ${Text}    ${pattern}
    #Validate Icon Due Date
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/1/icon    20
    #Validate Due Date
    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/labelText    payment_outstanding_label_due_date
    Comment    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/labelText
    Comment    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/labelText    ${PaymentLblDueDateTextTopicExpected${LANGUAGE}}
    #Validate Due Date Detail
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/supportText
    ${Text}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/supportText
    Log    ${Text}
    ${clean_Text}    Strip String    ${Text}
    ${pattern}    Set Variable    (?:0?[1-9]|[1-2][0-9]|3[01])\\s(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec|ม\\.ค\\.|ก\\.พ\\.|มี\\.ค\\.|ม\\.ย\\.|พ\\.ค\\.|มิ\\.ย\\.|ก\\.ค\\.|ส\\.ค\\.|ก\\.ย\\.|ต\\.ค\\.|พ\\.ย\\.|ธ\\.ค\\.)\\s+\\d{4}$
    Should Match Regexp    ${Text}    ${pattern}
    #Validate OverDue Text    text สีแดง
    ${OverDueText}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/overDueText
    ${OverDue}    Run Keyword If    '${OverDueText}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/overDueText
    ${OverDue}    Run Keyword If    '${OverDueText}'=='True'    Remove String    ${OverDue}    (    )
    log    ${OverDue}
    ${OverdueExpected}    mGetExpectedAPI    ${LANGUAGE}    payment_outstanding_label_overdue
    Run Keyword If    '${OverDueText}'=='True'    Should Be Equal    ${OverDue}    ${OverdueExpected}
    #Validate Icon Total
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListConten/2/icon    20
    log    ${KeyIDisVisible}
    #ValidateTotal
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/labelText    20
    Run Keyword If    '${KeyIDisVisible}'=='True'    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/labelText    payment_pay_bill_detail_total
    Comment    Run Keyword If    '${KeyIDisVisible}'=='True'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/labelText    ${PaymentLblCardTotalTextTopicExpected${LANGUAGE}}
    Comment    #Validate Amount To Pay
    Comment    mValidateTextFlutter    ${PaymentLblAmountTextTopic}    ${PaymentLblAmountTextTopicExpected${LANGUAGE}}
    Run Keyword If    '${KeyIDisVisible}'=='True'    mCheckFormatBahtwithUnit    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/2/supportText

CountandCheckAmountToPay
    [Documentation]    Loop เช็คจำนวนรายละเอียดในส่วนรายละเอียดรายการชำระต่างๆ
    Set Global Variable    ${countindex}    0
    FOR    ${countindex}    IN RANGE    99
        ${KeyIDVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${countindex}/chmListContent/0/labelText    20    #รอบบิล
        ${LineBottom}    Run Keyword And Return Status    Wait For Element    billAndPayPayMBill/allBill/chmCardPayBill/${countindex}/sectionContentAllDetail/chmDivider
        ${IconVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${countindex}/chmListConten/0/icon    20
        ${TextPayAhead}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${countindex}/sectionLabelWithIcon/titleText    #ยอดชำระ หรือ ชำระล่วงหน้า
        Run Keyword If    '${KeyIDVisible}'=='True' and '${IconVisible}'=='True'    CheckAmountToPayDetails    ${countindex}
        Run Keyword If    '${KeyIDVisible}'=='True' and '${IconVisible}'=='False'    Run Keywords    mValidatewithCoreLang    ${PaymentLblAmountActivateSignalTextTopic}    payment_outstanding_label_overdue_balance_to_resume_services
        ...    AND    mCheckFormatBahtwithUnit    ${PaymentLblAmountActivateSignalTextDetail}
        Comment    Run Keyword If    '${LineBottom}'=='True'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/textButton    ${PaymentBtnBillDetailExpected${LANGUAGE}}
        Run Keyword If    '${TextPayAhead}'=='True' and '${IconVisible}'=='False'    Run Keywords    mValidatewithCoreLang    billAndPayPayMyBill/allBill/chmCardPayBill/${countindex}/sectionLabelWithIcon/titleText    payment_outstanding_label_advance_balance
        ...    AND    mCheckFormatBahtwithUnit    ${PaymentLblAmountTextDetail}
        Exit For Loop If    '${KeyIDVisible}'=='False' or '${LineBottom}'=='False'
        ${countindex}    Evaluate    ${countindex}+1
    END

CheckCardPayBill
    [Documentation]    เช็ครายละเอียดภายในการ์ด บิลหมายเลขโทรศัพท์ ส่วนเบอร์โทรและส่วนยอดชำระและรายละเอียดบิล
    #Validate Avatar
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAvatar    20
    #ValidateMaskNumber
    ${Masking}    Set Variable    True
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/labelText
    ${PhoneNumber}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/labelText    #${PaymentLblNumberAsset}
    ${Regexp}    Set Variable If    "${Masking}" == "True"    xxx    \\d{3}
    Run Keyword If    '${KeyIDisVisible}'=='True'    Should Match Regexp    ${PhoneNumber}    ^\\d{3}?${Regexp}?\\d{4}$ || ^\\d{3}-?${Regexp}-?\\d{4}$
    #ValidatePhonenum
    ${Masking}    Set Variable    True
    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/titleText    20
    ${PhoneNumber}    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/titleText
    Should Match Regexp    ${PhoneNumber}    ^\\d{3}-\\d{3}-\\d{4}$
    #ValidateWarning
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAlert/headingText
    ${Text}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAlert/headingText
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAlert/supporting
    ${Text}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAlert/supporting
    #Validate Amount to Pay
    ${PaymentOutsatndingOverdur}    mGetExpectedAPI    ${LANGUAGE}    payment_title_total_balance
    Log    ${PaymentOutsatndingOverdur}
    ${PaymentOutsatnding}    mGetExpectedAPI    ${LANGUAGE}    payment_outstanding_label_advance_balance
    Log    ${PaymentOutsatnding}
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/descriptionText
    ${Text}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/descriptionText
    Run Keyword If    '${Text}'=='${PaymentOutsatndingOverdur}'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/descriptionText    ${PaymentOutsatndingOverdur}
    Run Keyword If    '${Text}'=='${PaymentOutsatnding}'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/descriptionText    ${PaymentOutsatnding}
    mCheckFormatBahtwithUnit    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/unitText
    #Count Amount to Pay Details
    CountandCheckAmountToPay
    #Validate bottom Card
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionContentAllDetail/chmListContent/labelText
    ${Text}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionContentAllDetail/chmListContent/labelText
    Run Keyword If    '${KeyIDisVisible}'=='True'    log    ${Text}
    #Validate Bill Detail
    ${BillDetailExpected}    mGetExpectedAPI    ${LANGUAGE}    payment_outstanding_button_bill_detail
    Log    ${BillDetailExpected}
    ${LineBottom}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/chmDivider
    Log    ${BillDetailExpected}
    Run Keyword If    '${LineBottom}'=='True'    mValidateTextFlutter    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/textButton    ${BillDetailExpected}

mValidateHeaderPayment
    #Validate Header
    Comment    Wait For Element    billAndPayPayMyBill/headerNavigation/headerText    #${PaymentLblAmountToPayRequestTextTopic}    PayBillHeader
    ${PayBillCoreLanguageExpected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentlblPayBillHeaderExpected}
    Log    ${PayBillCoreLanguageExpected}
    mValidateTextFlutter    ${HeaderMenuTitlePaybill}    ${PayBillCoreLanguageExpected}
    #Validate Bill History
    ${BillHistoryCoreLanguage_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentbtnBillHistoryExpected}
    mValidateTextFlutter    ${HeaderMenubtnBillHistory}    ${BillHistoryCoreLanguage_Expected}
    #Check Icon Bill History btn Visible
    Wait For Element    ${HeaderMenuiconBillHistory}    #iconBillHistory
    #Validate Tab My Bills
    ${MyBills_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentbtnMyBillsExpected}
    Log    ${MyBills_Expected}
    mValidateTextFlutter    ${PaymentBtnMyBill}    ${MyBills_Expected}
    #Validate Tab Pay For Other
    ${PayForOther_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentbtnPayForOtherExpected}
    Log    ${PayForOther_Expected}
    mValidateTextFlutter    ${PaymentBtnPayForOther}    ${PayForOther_Expected}

mValidateFooterPayment
    #ButtonSheet
    #Total Text
    ${BillinglblBalance_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentLblTotalTextBottomsheetExpected}    #ยอดชำระ
    Log    ${BillinglblBalance_Expected}
    mValidateTextFlutter    ${PaymentLblTotalTextTopic}    ${BillinglblBalance_Expected}    30
    Wait For Element    ${PaymentLblTotalTextDetail}    10    # X,XXX บาท
    ${amount}    Get Element Text    ${PaymentLblTotalTextDetail}
    ${pattern}    Set Variable    ^([0-9]{0,3},)?([0-9]{1,3}).([0-9]{2})
    ${clean_amount}    Strip String    ${amount}
    Should Match Regexp    ${clean_amount}    ${pattern}
    #Button Pay Bill
    Wait For Element    ${PaymentBtnPayBill}    10    #ชำระเงิน
    ${PaymentbtnPayBill_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentLblPayBillButtonTextExpected}
    Log    ${PaymentbtnPayBill_Expected}
    mValidateTextFlutter    ${PaymentLblPayBillTextTopic}    ${PaymentbtnPayBill_Expected}    30    #null/stickyButtonAmountToPay/chmButtonSet/chmButtoon/primary/textButton
    #Button Condition
    Wait For Element    ${PaymentImgTermAndConditionicon}    10    # icon เงื่อนไขการใช้บริการ
    ${PaymentBtnTermCondition_Expected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentLblTermAndConditionTextExpected}
    Log    ${PaymentBtnTermCondition_Expected}
    mValidateTextFlutter    ${PaymentLblTermAndConditionTextTopic}    ${PaymentBtnTermCondition_Expected}

RedirectPaymentByPackageAndCheckKey
    #Click Package ButtonNav
    Wait For Element    button_package
    AppiumFlutterLibrary.Click Element    button_package
    #Click Paybill
    Wait For Element    ${PackageTariffTBtnPayBill}
    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
    #Pop up Detect    ${PackageTariffTPayBillSuspendPayBil}    null/chmBotton/primary/textButton
    ${PopupisVisible}    Run Keyword And Return Status    Wait For Element    ${PackageTariffTPayBillSuspendPayBil}    10
    ${PopupisVisible2}    Run Keyword And Return Status    Wait For Element    myaisPackageMainScreenUsageAndPackageMaskFailed/chmModalGeneral/chmButton/primary/textButton
    Run Keyword If    '${PopupisVisible}'=='True'    AppiumFlutterLibrary.Click Element    ${PackageTariffTPayBillSuspendPayBil}
    Run Keyword If    '${PopupisVisible2}'=='True'    AppiumFlutterLibrary.Click Element    myaisPackageMainScreenUsageAndPackageMaskFailed/chmModalGeneral/chmButton/primary/textButton
    Comment    Run Keyword If    '${PopupisVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    ${PackageTariffTPayBillSuspendPayBil}
    ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
    #IF card Paybill Doesnt Visible Refresh Page
    ${count}    Set Variable    0
    FOR    ${count}    IN RANGE    3
        ${KeyIDVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0
        Exit For Loop If    '${KeyIDVisible}'=='True'
        Run Keyword If    '${KeyIDVisible}'=='False' and '${PopupisVisible}'=='False' and '${PopupisVisible2}'=='False'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        Run Keyword If    '${KeyIDVisible}'=='False' and '${PopupisVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTPayBillSuspendPayBil}
        Run Keyword If    '${KeyIDVisible}'=='False' and '${PopupisVisible2}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ...    AND    AppiumFlutterLibrary.Click Element    myaisPackageMainScreenUsageAndPackageMaskFailed/chmModalGeneral/chmButton/primary/textButton
        Comment    Run Keyword If    '${KeyIDVisible}'=='False' and '${PopupisVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTPayBillSuspendPayBil}
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ${count}    Evaluate    ${count}+1
        Run Keyword If    '${count}'>3    Fail
    END

mCheckandGetTextOverdue
    [Arguments]    ${ActuralDate}    ${CurrentDate}    ${i}
    [Documentation]    นำวันที่ปัจจุบันมาลบกลับรอบบิลเพื่อเช็คว่าใกล้ถึงกำหนดหรือเกินกำหนดแสดง
    ...
    ...    โดยเมื่อระยะห่างระหว่าง 2 วันน้อยกว่า 3 วันจะแสดงข้อความ
    #Check OverDue
    ${dayleft}    Set Variable    4
    ${TextOverdue}    mCheckOverDue    ${ActuralDate}    ${CurrentDate}
    ${days}    Convert To Integer    ${TextOverdue}
    ${status}    Run Keyword And Return Status    Should Be True    ${days}<${dayleft}
    Run Keyword If    '${status}'=='False'    Should Not Contain    \    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/overDueText
    Run Keyword If    '${status}'=='True'    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/overDueText
    ${OverDue}    Run Keyword If    '${status}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/${i}/chmListContent/1/overDueText
    Comment    Run Keyword If    '${status}'=='False'    Should Not Contain    \    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/overDueText
    Comment    Run Keyword If    '${status}'=='True'    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/overDueText    30
    Comment    ${OverDue}    Run Keyword If    '${status}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/overDueText
    Comment    ${OverDue}    Run Keyword If    '${status}'=='True'    Get Element Text    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/overDueText
    Comment    ${OverDueExpected}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${PaymentLblDueDateOverdueTextExpected}
    ${OverDue}    Run Keyword If    '${status}'=='True'    Remove String    ${OverDue}    (    )
    Run Keyword If    '${status}'=='True'    Should Not Be Empty    ${OverDue}

mCheckOverDue
    [Arguments]    ${ActuralDate}    ${CurrentDate}
    [Documentation]    เปรียบเทียบจำนวนวันเพื่อคำนวน ว่าระยะห่างวันเลยกำนหนกหรือไม่
    #Check OverDue
    ${Overdue}    Run Keyword If    '${CurrentDate}'<'${ActuralDate}'    Subtract Date From Date    ${ActuralDate}    ${CurrentDate}    verbose    exclude_millis=True
    ...    ELSE    Subtract Date From Date    ${ActuralDate}    ${CurrentDate}    verbose    exclude_millis=True
    log    ${Overdue}
    ${Overdue}    Split String    ${Overdue}
    ${Overdue}    Run Keyword If    '${CurrentDate}'<'${ActuralDate}'    Set Variable    ${Overdue}[0]
    ...    ELSE    Set Variable    ${Overdue}[0] ${Overdue}[1]
    log    ${Overdue}
    [Return]    ${Overdue}
