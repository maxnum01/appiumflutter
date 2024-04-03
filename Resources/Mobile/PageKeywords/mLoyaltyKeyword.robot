*** Settings ***
Resource          ../../../Configuration/Mobile/GlobalConfig/AllResource.robot

*** Keywords ***
mCheckXPathVisible
    [Arguments]    ${locator}    ${amount}=3
    [Documentation]    *Description*
    ...
    ...    Check if any xPath is detected within the page. If any xPath is not found 3 times, it will fail and it will show the message "Application Not Showing xPath"
    ...
    ...    *Format keyword*
    ...    | ${locator} | ${AmountLoop} |
    ...
    ...    *Example keyword*
    ...    | ${locator} | ${amount}=3 |
    ${CountFail}    Set Variable    0
    FOR    ${i}    IN RANGE    ${amount}
        ${xPathVisible}    Run Keyword And Return Status    mWaitUntilElement    ${locator}
        ${CountFail}    Run Keyword If    '${xPathVisible}'=='False'    Evaluate    ${CountFail}+1
        Run Keyword If    ${CountFail} == 3    Fail    <font style="color:#FFCC00" size="3">Application did not showing xpath in ${amount} times
        Run Keyword If    '${xPathVisible}'=='False'    Run Keywords    mClickWebElement    ${HeaderbtnClose}
        ...    AND    mSwipedownToElement    ${LifeStyleandServiceimgBanner1}
        ...    AND    mFindLifeStyleandServiceMenu    ช้อปปิ้ง
        ...    AND    mClickWebElement    ${LifeStyleandServiceimgBanner1}
        Exit For Loop If    '${xPathVisible}'=='True'
    END

mSkipPopup
    [Documentation]    *Description*
    ...
    ...    Press the 'Skip' button on the top right corner of the Collect Discount Popup.
    ...
    ...    *Format keyword*
    ...    -
    ...
    ...    *Example keyword*
    ...    -
    ${StatusPopup}    Run Keyword And Return Status    mWaitUntilElement    ${RetaillblPopupDetail}
    Run Keyword If    "${StatusPopup}"=="True"    mClickWebElement    ${RetailbtnPopupSkip}

mSkipPopupAndCheckXPathVisible
    [Arguments]    ${locator}    ${amount}=3
    [Documentation]    *Description*
    ...
    ...    Press the 'Skip' button on the top-right corner of the Popup. Collect the discount and check if any xPath is detected within the page. If any xPath is not found 3 times, it will fail and it will show the message "Application Not Showing xPath"
    ...
    ...    *Format keyword*
    ...    | ${locator} | ${AmountLoop} |
    ...
    ...    *Example keyword*
    ...    | ${locator} | ${amount}=3 |
    ${CountFail}    Set Variable    0
    FOR    ${i}    IN RANGE    ${amount}
        mSkipPopup
        mSwipedownToElement    ${locator}
        ${xPathVisible}    Run Keyword And Return Status    mWaitUntilElement    ${locator}
        ${CountFail}    Run Keyword If    '${xPathVisible}'=='False'    Evaluate    ${CountFail}+1
        Run Keyword If    ${CountFail} == 3    Fail    <font style="color:#FFCC00" size="3">&#9679</font>Application did not showing xpath in ${amount} times
        Run Keyword If    '${xPathVisible}'=='False'    Run Keywords    mClickWebElement    ${HeaderbtnClose}
        ...    AND    mSwipedownToElement    ${LifeStyleandServiceimgBanner2}
        ...    AND    mFindLifeStyleandServiceMenu    ช้อปปิ้ง
        ...    AND    mClickWebElement    ${LifeStyleandServiceimgBanner2}
        Exit For Loop If    '${xPathVisible}'=='True'
    END

mValidateCampaign
    [Arguments]    ${CampaignName}
    [Documentation]    *Description*
    ...
    ...    Check the display of campaign name, campaign image, campaign details. and product category that show different results in each campaign
    ...
    ...    *Format keyword*
    ...    | ${CampaignName} |
    ...
    ...    *Example keyword*
    ...    | ${CampaignName} |
    # Validate Title Campaign
    mWaitUntilElement    ${RetaillblCampaignTitle}
    mVerifyText    ${RetaillblCampaignTitle}    ${Retaillbl${CampaignName}Title_Expected${Language}}
    # Validate Image Campaign
    mWaitUntilElement    ${RetailimgCampaignCard}
    # Validate Description Campaign
    mWaitUntilElement    ${RetaillblCampaignDetail}
    mVerifyText    ${RetaillblCampaignDetail}    ${Retaillbl${CampaignName}TitleDetail_Expected${Language}}
    # Validate Tag Campaign
    mWaitUntilElement    ${RetailareaCategory}

mValidateTermsAndConditions
    [Documentation]    *Description*
    ...
    ...    Check message Terms and conditions
    ...
    ...    *Format keyword*
    ...    -
    ...
    ...    *Example keyword*
    ...    -
    # Validate Terms & Condition
    ${RunningIndex1}    Set Variable    1
    ${AmountTextDisappear}    Set Variable    0
    mVerifyText    ${RetaillblConditiontitle}    ${RetaillblConditiontitle_Expected${Language}}
    FOR    ${i}    IN RANGE    99
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]    0.05s
        ${AmountTextDisappear}    Run Keyword If    '${TextAppear}'=='False'    Evaluate    ${AmountTextDisappear}+1
        ...    ELSE    Set Variable    ${AmountTextDisappear}
        ${RunningIndex1}    Run Keyword If    '${TextAppear}'=='False'    Evaluate    ${RunningIndex1}+1
        ...    ELSE    Set Variable    ${RunningIndex1}
        Run Keyword If    '${TextAppear}'=='False' and ${AmountTextDisappear}<2    Continue For Loop
        Exit For Loop If    ${AmountTextDisappear}==2
        Run Keyword If    '${TextAppear}'=='True'    mGetTextinParagraph    ${RunningIndex1}
        ${RunningIndex1}    Evaluate    ${RunningIndex1}+1
        log    %{DetailTextActual}
        Run Keyword If    '${TextAppear}'=='True'    mSwipedownToElement    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]    1
        Exit For Loop If    '${TextAppear}'=='False'
    END
    ${ConditionDetailActual}    Remove String    %{DetailTextActual}    ;
    ${ConditionDetailActual}    Replace String    ${ConditionDetailActual}    \u00a0    ${EMPTY}
    ${ConditionDetailActual}    Replace String    ${ConditionDetailActual}    \u202f    ${SPACE}
    Comment    ${ConditionDetailActual}    Replace String    ${ConditionDetailActual}    ${SPACE}    ${EMPTY}
    Comment    ${ConditionDetailActual}    Replace String    ${ConditionDetailActual}    \u202f    ${EMPTY}
    ${ConditionDetailActual}    Set Variable    ${ConditionDetailActual}
    log    ${ConditionDetailActual}
    Should Be Equal    ${ConditionDetailActual}    ${RetaillblConditionDetail_Expected${Language}}
    # Validate More Condition
    mVerifyText    ${RetaillblForMoreDetail}    ${RetaillblForMoreDetail_Expected${Language}}
    mVerifyText    ${RetaillinkForMoreDetail}    ${RetaillinkForMoreDetail_Expected[0]}

mGetTextinParagraph
    [Arguments]    ${RunningIndex1}
    [Documentation]    *Description*
    ...
    ...    Get text in a paragraph, then append into variables for further use.
    ...
    ...    *Format keyword*
    ...    | ${RunningIndex1} |
    ...
    ...    *Example keyword*
    ...    | ${RunningIndex1} |
    ${RunningIndex2}    Set Variable    1
    ${AmountTextDisappear}    Set Variable    0
    FOR    ${i}    IN RANGE    99
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]    0.05s
        ${AmountTextDisappear}    Run Keyword If    '${TextAppear}'=='False'    Evaluate    ${AmountTextDisappear}+1
        ...    ELSE    Set Variable    ${AmountTextDisappear}
        ${RunningIndex2}    Run Keyword If    '${TextAppear}'=='False'    Evaluate    ${RunningIndex2}+1
        ...    ELSE    Set Variable    ${RunningIndex2}
        Exit For Loop If    ${AmountTextDisappear}==2
        ${DetailText}    mGetText    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]
        log    ${DetailText}
        ${DetailText}    Run Keyword If    '${DetailText}'=='None' or '${DetailText}'=='${EMPTY}'    mGetText    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]/*
        ...    ELSE    Set Variable    ${DetailText}
        ${DetailText}    Run Keyword If    '${DetailText}'=='None' or '${DetailText}'=='${EMPTY}'    mGetTextinSubParagraph    ${RunningIndex1}    ${RunningIndex2}
        ...    ELSE    Set Variable    ${DetailText}
        ${RunningIndex2}    Evaluate    ${RunningIndex2}+1
        Run Keyword If    '${TextAppear}'=='False' and ${AmountTextDisappear}<2    Continue For Loop
        Append To Environment Variable    DetailTextActual    ${DetailText}
    END

mGetTextinSubParagraph
    [Arguments]    ${RunningIndex1}    ${RunningIndex2}
    [Documentation]    *Description*
    ...
    ...    Get text in a sub-paragraph, then append into variables for further use.
    ...
    ...    *Format keyword*
    ...    | ${RunningIndex1} | ${RunningIndex2} |
    ...
    ...    *Example keyword*
    ...    | ${RunningIndex1} | ${RunningIndex2} |
    ${RunningIndex3}    Set Variable    1
    ${AmountTextDisappear}    Set Variable    0    \    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]
    FOR    ${i}    IN RANGE    99
        mSwipedownToElement    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]/*[@index="${RunningIndex3}"]/*[@index="1"]    1
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]/*[@index="${RunningIndex3}"]/*[@index="1"]    0.05s
        Exit For Loop If    '${TextAppear}'=='False'
        ${DetailText}    mGetText    xpath=//android.view.View[@resource-id="retail-web"]/android.widget.ListView[@index="12"]/*[@index="${RunningIndex1}"]/*[@index="${RunningIndex2}"]/*[@index="${RunningIndex3}"]/*[@index="1"]
        Append To Environment Variable    DetailTextActual    ${DetailText}
        ${RunningIndex3}    Evaluate    ${RunningIndex3}+1
    END

mValidateProductCategory
    [Arguments]    ${ProductCategoryExpected}    ${AmountClick}
    [Documentation]    *Description*
    ...
    ...    Check the display of product categories. which show different results for each campaign.
    ...
    ...    *Format keyword*
    ...    | ${ProductCategoryExpected} | ${AmountClick} |
    ...
    ...    *Example keyword*
    ...    | ${ProductCategoryExpected} | ${AmountClick} |
    mSwipedownToElement    ${RetailbtnMoreHide}
    # Click Link Show/Hide
    FOR    ${i}    IN RANGE    ${AmountClick}
        mClickWebElement    ${RetailbtnMoreHide}
    END
    # Validate Product Category
    mClickWebElement    xpath=//android.widget.ListView[@resource-id="mat-chip-list-0"]
    mClickWebElement    xpath=//android.widget.ListView[@resource-id="mat-chip-list-0"]/*[@index="0"]
    ${RunningIndex}    Set Variable    0
    ${ProductCategoryActual}    Create List
    FOR    ${i}    IN RANGE    99
        ${Status}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.widget.ListView[@resource-id="mat-chip-list-0"]/*[@index="${RunningIndex}"]    0.5s
        Exit For Loop If    "${Status}"=="False"
        ${Text}    Get Text    xpath=//android.widget.ListView[@resource-id="mat-chip-list-0"]/*[@index="${RunningIndex}"]
        Append To List    ${ProductCategoryActual}    ${Text}
        ${RunningIndex}    Evaluate    ${RunningIndex}+1
    END
    log    ${ProductCategoryActual}
    ${statusListProduct}    Run Keyword And Return Status    Lists Should Be Equal    ${ProductCategoryActual}    ${ProductCategoryExpected}
    Run Keyword If    '${statusListProduct}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Product count or sorting in category is incorrect

mGetTextDeleteNewLineAndValidate
    [Arguments]    ${Locator}    ${Expected}
    [Documentation]    *Description*
    ...
    ...    Get text from xPath, remove line breaks. and take the message to check
    ...
    ...    *Format keyword*
    ...    | ${Locator} | ${Expected} |
    ...
    ...    *Example keyword*
    ...    | ${Locator} | ${Expected} |
    # Get Text
    ${Actual}    mGetText    ${Locator}
    # Customize Text
    ${Actual}    Split To Lines    ${Actual}
    ${Actual}    Convert To String    ${Actual}
    ${Actual}    Replace String    ${Actual}    ', '    ${SPACE}
    ${Actual}    Remove String    ${Actual}    ['
    ${Actual}    Remove String    ${Actual}    ']
    # Validate Text
    ${statusListProduct}    Run Keyword And Return Status    Should Be Equal    ${Actual}    ${Expected}
    Run Keyword If    '${statusListProduct}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Text not match : ${Actual} != ${Expected}

mValidatePopupDefault
    [Arguments]    ${StatusCode1}    ${StatusCode2}
    [Documentation]    *Description*
    ...
    ...    Check the display of the Popup, press to receive a discount code. Check Title Header, Close Button, Skip Button, Title Popup and details of both discount codes in the specified status (Available / Unavailable).
    ...
    ...    *Format keyword*
    ...    | ${StatusCode1} | ${StatusCode2} |
    ...
    ...    *Example keyword*
    ...    | ${StatusCode1} | ${StatusCode2} |
    mCheckXPathVisible    ${RetailbtnPopupSkip}
    # Validate Title Header
    mWaitUntilElement    ${HeaderlblTitle}
    mVerifyTextTitle    ${HeaderlblTitle}    ${RetaillblHeaderTitle_Expected${Language}}
    # Validate X Close Button
    mWaitUntilElement    ${HeaderbtnClose}
    # Validate Skip Button
    mVerifyText    ${RetailbtnPopupSkip}    ${RetaillblPopupSkip_Expected${Language}}
    # Validate Title Popup
    mGetTextDeleteNewLineAndValidate    ${RetaillblPopupDetail}    ${RetaillblPopupDetail_Expected${Language}}
    # Validate Dis. Code 1
    mGetTextDeleteNewLineAndValidate    ${RetaillblPopupDiscount1}    ${RetaillblPopupDiscount1_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount1Line1}    ${RetaillblPopupDiscount1Line1_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount1Line2}    ${RetaillblPopupDiscount1Line2_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount1Line3}    ${RetaillblPopupDiscount1Line3_Expected${Language}}
    Comment    mVerifyText    ${RetaillblPopupDiscount1Line4}    ${RetaillblPopupDiscount1Line4_Expected${Language}}    มีการลบบรรทัดออก
    mVerifyText    ${RetaillblPopupSelectDiscount1}    ${RetaillblPopupSelectDiscount1${StatusCode1}_Expected${Language}}
    # Validate Dis. Code 2
    mGetTextDeleteNewLineAndValidate    ${RetaillblPopupDiscount2}    ${RetaillblPopupDiscount2_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount2Line1}    ${RetaillblPopupDiscount2Line1_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount2Line2}    ${RetaillblPopupDiscount2Line2_Expected${Language}}
    mVerifyText    ${RetaillblPopupDiscount2Line3}    ${RetaillblPopupDiscount2Line3_Expected${Language}}
    Comment    mVerifyText    ${RetaillblPopupDiscount2Line4}    ${RetaillblPopupDiscount2Line4_Expected${Language}}    มีการลบบรรทัดออก
    mVerifyText    ${RetaillblPopupSelectDiscount2}    ${RetaillblPopupSelectDiscount2${StatusCode2}_Expected${Language}}

mValidatePopupRedeem
    [Arguments]    ${DiscountNo.}
    [Documentation]    *Description*
    ...
    ...    Check the Popup display when receiving the discount code, Check the Close Popup button, the display of the picture. and details of various discount codes
    ...
    ...    *Format keyword*
    ...    | ${DiscountNumber} |
    ...
    ...    *Example keyword*
    ...    | ${DiscountNo.} |
    # Click Keep Code
    mClickWebElement    ${RetaillblPopupSelectDiscount${DiscountNo.}}
    # Validadte btn Close
    mWaitUntilElement    ${RetailbtnPopupRedeemClose}
    # Validadte Image
    mWaitUntilElement    ${RetailimgPopupRedeem}
    # Validadte Popup Detail
    mGetTextDeleteNewLineAndValidate    ${RetaillblPopupRedeemTitle}    ${RetaillblPopupRedeemDiscount${DiscountNo.}Title_Expected${Language}}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoTitle}    ${RetaillblPopupRedeemDiscount${DiscountNo.}ConfirmInfoTitle_Expected${Language}}
    @{characters}    Split String To Characters    ${Mobilenumber_${MOBILE}_${CampaignName}}
    ${characters[3]}    Set Variable    X
    ${characters[4]}    Set Variable    X
    ${characters[5]}    Set Variable    X
    ${MobileNumberPrivacy}    Set Variable    ${characters[0]}${characters[1]}${characters[2]}-${characters[3]}${characters[4]}${characters[5]}-${characters[6]}${characters[7]}${characters[8]}${characters[9]}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoMobileNumber}    ${MobileNumberPrivacy}
    mWaitUntilElement    ${RetailimgPopupRedeemConfirmInfoDuration}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoDurationStart}    ${RetaillblPopupRedeemDiscount${DiscountNo.}ConfirmInfoDurationStart_Expected${Language}}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoDurationBetween}    ${RetaillblPopupRedeemDiscount${DiscountNo.}ConfirmInfoDurationBetween_Expected${Language}}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoDurationEnd}    ${RetaillblPopupRedeemDiscount${DiscountNo.}ConfirmInfoDurationEnd_Expected${Language}}
    mWaitUntilElement    ${RetailimgPopupRedeemConfirmInfoShopAt}
    mVerifyText    ${RetaillblPopupRedeemConfirmInfoShopAt}    ${RetaillblPopupRedeemDiscount${DiscountNo.}ConfirmInfoShopAt_Expected${Language}}
    mVerifyText    ${RetailbtnPopupRedeemConfirm}    ${RetailbtnPopupRedeemConfirm_Expected${Language}}
    mClickWebElement    ${RetailbtnPopupRedeemClose}

mValidatePopupCode
    [Arguments]    ${DiscountNo.}
    [Documentation]    *Description*
    ...
    ...    Check the display of the Popup after receiving the discount code. Check the Close Popup button, Title Popup, Image-Text QR Code, Copy button, Barcode image, Number information and Code expiration date.
    ...
    ...    *Format keyword*
    ...    | ${DiscountNumber} |
    ...
    ...    *Example keyword*
    ...    | ${DiscountNo.} |
    # Click Keep Code
    mClickWebElement    ${RetaillblPopupSelectDiscount${DiscountNo.}}
    # Click Confirm Redeem
    mClickWebElement    ${RetailbtnPopupRedeemConfirm}
    # Validate btn Close
    mWaitUntilElement    ${RetailbtnPopupRedeemClose}
    # Validate Title
    mGetTextDeleteNewLineAndValidate    ${RetaillblPopupCodeTitle}    ${RetaillblPopupCodeDiscount${DiscountNo.}Title_Expected${Language}}
    # Validate QR Code Image/Text
    mWaitUntilElement    ${RetailimgPopupCodeQRCode}
    mWaitUntilElement    ${RetaillblPopupCodeQRCode}
    # Validate Icon Copy
    mWaitUntilElement    ${RetailbtnPopupCodeCopy}
    # Validate Barcode
    mWaitUntilElement    ${RetailimgPopupCodeBarCode}
    # Validate By
    @{characters}    Split String To Characters    ${Mobilenumber_${MOBILE}_${CampaignName}}
    ${characters[2]}    Run Keyword If    '${MOBILE}'=='FBB'    Set Variable    X
    ...    ELSE    Set Variable    ${characters[2]}
    ${characters[3]}    Set Variable    X
    ${characters[4]}    Set Variable    X
    ${characters[5]}    Set Variable    X
    ${MobileNumberPrivacy}    Set Variable    ${characters[0]}${characters[1]}${characters[2]}-${characters[3]}${characters[4]}${characters[5]}-${characters[6]}${characters[7]}${characters[8]}${characters[9]}
    ${MobileNumberPrivacy}    Set Variable    ${characters[0]}${characters[1]}${characters[2]}-${characters[3]}${characters[4]}${characters[5]}-${characters[6]}${characters[7]}${characters[8]}${characters[9]}
    ${ByMobileNumber}    Set Variable    ${RetaillblPopupCodeBy_Expected${Language}}${SPACE}${MobileNumberPrivacy}
    mVerifyText    ${RetaillblPopupCodeMobileNumber}    ${ByMobileNumber}
    # Validate Until Date
    mVerifyText    ${RetaillblPopupCodeUntilDate}    ${RetaillblPopupCodeDiscount${DiscountNo.}Until_Expected${Language}}
    # Click Close
    mClickWebElement    ${RetailbtnPopupCodeClose}

mClickAcceptAllCookies
    [Documentation]    *Description*
    ...
    ...    Click the Accept All Cookies button in Popup Cookir Policy
    ...
    ...    *Format keyword*
    ...    -
    ...
    ...    *Example keyword*
    ...    -
    ${Status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${RetailbtnAcceptallCookies}
    Run Keyword If    '${Status}'=='True'    mClickWebElement    ${RetailbtnAcceptallCookies}

mCheckClickFail
    [Arguments]    ${LocatorClick}    ${LocatorCheck}    ${Timeout}=${General_TimeOut}
    ${ResultClick}    BuiltIn.Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${LocatorClick}    ${Timeout}
    ${ResultCheck}    BuiltIn.Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${LocatorCheck}    ${Timeout}
    Run Keyword If    '${ResultClick}'=='True' and '${ResultCheck}'=='False'    Fail    <font style="color:#FFCC00" size="3">&#9679</font>Click success but it not redirect
    Run Keyword If    '${ResultClick}'=='False' and '${ResultCheck}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Element did not appear

mFindLifeStyleandServiceMenu
    [Arguments]    ${Expected}
    ${RunningIndex}    Set Variable    0
    FOR    ${i}    IN RANGE    99
        ${Text}    mGetText    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id='com.ais.mimo.eservice.debug:id/rvBannerCategory']/*[@index='${RunningIndex}']/*/*/android.widget.TextView
        ${Result}    Run Keyword And Return Status    Should Be Equal    ${Text}    ${Expected}
        Run Keyword If    '${Result}'=='True'    mClickWebElement    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id='com.ais.mimo.eservice.debug:id/rvBannerCategory']/*[@index='${RunningIndex}']/*/*/android.widget.TextView
        Run Keyword If    '${Result}'=='True'    Exit For Loop
        Run Keyword If    '${Result}'=='False'    mSwipeLeftOnElement    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id='com.ais.mimo.eservice.debug:id/rvBannerCategory']/*[@index='${RunningIndex}']/*/*/android.widget.TextView
        ${RunningIndex}    Run Keyword If    '${Result}'=='False'    Evaluate    ${RunningIndex}+1
    END

mClickButtonNavagation
    [Arguments]    ${MenuName}
    [Documentation]    *Description*
    ...    คลิกปุ่ม ที่ Button Navigation
    ...
    ...    *Format keyword*
    ...    | mClickButtonNavagation | ${MenuName} |
    ...
    ...
    ...    *Example keyword*
    ...    | mClickButtonNavagation | Home |
    ...    | mClickButtonNavagation | Privileges |
    ...
    ...    *Allow Value for MenuName*
    ...    - Home
    ...    - Privileges
    ...    - Package
    ...    - Profile
    #คลิกปุ่ม ที่ Button Navigation
    Sleep    60s
    Comment    Wait For Element    button_home    60
    Click Element    text=${CommonbtnNavigation${MenuName}${LANGUAGE}}
    Comment    Click Element    text=${MenuName}

mValidateProfileTier
    [Arguments]    ${ProfileTier}
    [Documentation]    *Description*
    ...    ตรวจสอบ Tier ที่หน้า Home Priveleges
    ...
    ...    *Format keyword*
    ...    | mValidateProfileTier | ${ProfileTier} |
    ...
    ...
    ...    *Example keyword*
    ...    | mValidateProfileTier | SerenadeGold |
    ...    | mValidateProfileTier | AISCustomer |
    ...
    ...    *Allow Value for ProfileTier*
    ...    - AISCustomer
    ...    - AISCustomerFiber
    ...    - SerenadeEmerald
    ...    - SerenadeGold
    ...    - SerenadePlatinum
    ${Profile_Actual}    Get Element Text    text_rank1
    Should Be Equal    ${Profile_Actual}    ${LoyaltytxtProfile${ProfileTier}${LANGUAGE}}
