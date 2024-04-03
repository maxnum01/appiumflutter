*** Variables ***
# Header Menu
${HeaderMenuTitlePaybill}    billAndPayPayMyBill/headerNavigation/headerText    #Header Pay Bill
${HeaderMenubtnBillHistory}    billAndPayPayMyBill/headerNavigation/chmSmallButton/textButton    #Button Bill History
${HeaderMenuiconBillHistory}    billAndPayPayMyBill/headerNavigation/chmSmallButton/chmIcon/suffix    #Icon Bill History
# บิลของฉัน
${PaymentBtnMyBill}    billAndPayPayMyBill/tabsMyBillAndOtherBill/chmFixedTabs/label/0    # Tab บิลของฉัน
${PaymentBtnPayForOther}    billAndPayPayMyBill/tabsMyBillAndOtherBill/chmFixedTabs/label/1    #Tab จ่ายบิลให้หมายเลขอื่น
${PaymentLblAmountTextHeaderTitle}    billAndPayPayMyBill/allBill/chmSubTitle/subTitle/titleLabel    #Text ยอดที่ต้องชำระด้านบนสุด
${PaymentLblSelectAllTextHeaderTitle}    billAndPayPayMyBill/allBill/chmSubTitle/subTitle/additionalText    #Text เลือกทั้หมด
${PaymentChkboxSelectAllHeader}    billAndPayPayMyBill/allBill/chmSubTitle/subTitle/chmCheckBox    #CheckBox เลือกทั้งหมด
${PaymentImgAvatar}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmAvatar    #Avatar ประจำตัว
${PaymentLblNumberAsset}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/labelText    #เบอร์,ชื่อ บัญชีนี้
${PaymentLblNumberBill}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/titleText    #เบอร์ของบิลที่ชำระ
${PaymentChkboxSelectCard}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmCheckBox    #CheckBox เลือกเบอร์ที่จะชำระ
${PaymentCardAlertWarning}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmAlert    #การ์ดแจ้งเตือน สีเหลือง , สีแดง กรอบใหญ่
${PaymentCardAlertWarningIcon}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmAlert/chmIcon    #Icon เครื่องหมายตกใจ ในการ์ดแจ้งเตือน
${PaymentCardAlertWarningTextHeading}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmAlert/headingText    #หัวข้อในการ์ดแจ้งเตือน
${PaymentCardAlertWarningTextSupport}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/chmAlert/supporting    #รายละเอียดในการ์ดแจ้งเตือน
${PaymentLblAmountToPayRequestTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/descriptionText    #Text ยอดที่ต้องชำระ
${PaymentLblAmountToPayRequestTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionUser/unitText    #ตัวเลข ยอดที่ต้องชำระ
${PaymentImgBillCycle}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListConten/0/icon    #ไอคอน รอบบิล
${PaymentLblBillCycleTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/0/labelText    #Text รอบบิล
${PaymentLblBillCycleTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/0/supportText    #Text รายละเอียดรอบบิล
${PaymentImgDueDate}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListConten/1/icon    #ไอคอน กำหนดชำระ
${PaymentLblDueDateTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/labelText    #Text กำหนดชำระ
${PaymentLblDueDateTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/1/supportText    #Text รายละเอียดกำหนดชำระ
${PaymentLblDueDateTextAlert}    -    #Text เตือนเกินกำหนดชำระ
${PaymentImgTotal}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListConten/2/icon    #ไอคอน ทั้งหมด
${PaymentLblCardTotalTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/2/labelText    #Text ทั้งหมด
${PaymentLblCardTotalTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/chmListContent/2/supportText    #Text รายระเอียดทั้งหมด
${PaymentLblAmountActivateSignalTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/chmListContent/labelText    #Text ยอดชำระเพิ่มเพื่อเปิดสัญญาณ
${PaymentLblAmountActivateSignalTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/chmListContent/supportText    #Text รายระเอียดยอดชำระเพื่อเปิดสัญญาณ
${PaymentLblAmountTextTopic}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionLabelWithIcon/titleText    #Text ยอดชำระ
${PaymentLblAmountTextDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionLabelWithIcon/amountText    #Text รายระเอียดยอกชำระ
${PaymentBtnEditTotalText}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionLabelWithIcon/chmIcon    #ปุ่ม แก้ไขจำนวนเงิน
${PaymentBtnBillDetail}    billAndPayPayMyBill/allBill/chmCardPayBill/0    #ปุ่ม รายละเอียดบิล ด้านล่างของ Asset
${PaymentLblBillDetailText}    billAndPayPayMyBill/allBill/chmCardPayBill/0/textButton    #Text ปุ่มรายระเอียด
${PaymentImgBillDetailIcon}    billAndPayPayMyBill/allBill/chmCardPayBill/0/chmIcon/suffix    #Icon > หลัง Text รายระเอียด
${PaymentLblTotalTextTopic}    billAndPayPayMyBill/stickyButtonAmountToPay/chmContentDisplay/headingText    #Text ยอดชำระ ล่างสุด
${PaymentLblTotalTextDetail}    billAndPayPayMyBill/stickyButtonAmountToPay/labelText    #Text ตัวเลข ยอดชำระ ล่างสุด
${PaymentBtnPayBill}    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/primary    #ปุ่ม ชำระเงิน
${PaymentLblPayBillTextTopic}    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/primary/textButton    #Text ชำระเงิน
${PaymentImgTermAndConditionicon}    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/secondary/chmIcon/prefix    #Icon เงื่อนไขการใช้บริการ
${PaymentLblTermAndConditionTextTopic}    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/secondary/textButton    #Text เงือรไขการใช้บริการ
${PaymentBtnTermAnnCondition}    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/secondary    #ปุ่ม เงื่อนไขการใช้บริการ
${PaymentBtnBackPayBill}    billAndPayPayMyBill/headerNavigation/chmIcon
# จ่ายบิลให้หมายเลขอื่น
#Member
${PaymentLblMemberTitle}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/subTitleWithList/subTitle    #2 หมายเลข
${PaymentLblMemberSupport}    billAndPayPayMyBill/allBill/chmCardPayBill/0/sectionContentAllDetail/0/subTitleWithList/0/chmListContent/labelText    #080xxxxxxx
#เลือกช่องทางการชำระเงิน
${PaymentlblHeaderSelectPaymentTitle}    xxx    #Header เลือกช่องทางการชำระ
${PaymentlblPaymentMethodTitle}    xxx    #Text ช่องทางการชำระ
${PaymentlblWalletTitle}    xxx    #Text Wallet
${PaymentlblMobileBankingTitle}    xxx    #Text แอปธนาคาร
${PaymentlblCreditCardTitle}    xxx    #Text Credit Card
${PaymentlblOtherTitle}    xxx    #Text อื่นๆ
${PaymentbtnUseAnotherCardButton}    1    #ปุ่มใช้บัตรอื่นๆ
${PaymentlblTotalPriceTitle}    1    #Text ยอดชำระ
${PaymentlblTotalPriceNumberTitle}    2    #Text เลขยอดชำระ
${PaymentbtnSelectPaymentLinePayButton}    1    #Line Pay Radiobutton
${PaymentlblSelectPaymentLinePayText}    1    #Line Pay Text
${PaymentbtnSelectPaymentKPlusButton}    2    #K Plus Radiobutton
${PaymentlblSelectPaymentKPlusText}    2    #K PlusText
${PaymentbtnSelectPaymentSCBButton}    3    #SCB Radiobutton
${PaymentlblSelectPaymentSCBText}    3    #SCB Text
${PaymentbtnSelectPaymentNEXTButton}    4    #NEXT Radiobutton
${PaymentlblSelectPaymentNEXTText}    4    #NEXT Text
${PaymentbtnSelectPaymentKMAButton}    5    #KMA Radiobutton
${PaymentlblSelectPaymentKMAText}    5    #KMA Text
${PaymentbtnSelectPaymentBualuangMButton}    6    #BualuangM Radiobutton
${PaymentlblSelectPaymentBualuangMText}    6    #BualuangM Text
${PaymentbtnSelectPaymentCreditCardButton}    7    #Credit Radiobutton
${PaymentlblSelectPaymentCreditCardText}    7    #Credit Text
${PaymentbtnSelectPaymentPromptPayButton}    8    #พร้อมเพย์ Radiobutton
${PaymentlblSelectPaymentPromptPayText}    8    #พร้อมเพย์ Text