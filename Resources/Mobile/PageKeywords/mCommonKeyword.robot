*** Settings ***
Resource          ../../../Configuration/Mobile/GlobalConfig/AllResource.robot

*** Keywords ***
Get Devices
    [Arguments]    ${SelectDevices}    ${ConfigPath}
    [Documentation]    *Description*
    ...
    ...    This Keyword for get Devices Detail From Jsonfile
    ...
    ...    *Format keyword*
    ...    | Get Devices | ${SelectDevices} | ${ConfigPath} |
    ...
    ...    *Example keyword*
    ...    | Get Devices | ${devicesName} | ${configPath} |
    ${Json}    Get File    ${JsonfilePath}
    ${Obj}    Evaluate    json.loads("""${Json}""")    json
    ${Data}    Set Variable    ${Obj['Data']}
    ${Len}    Get Length    ${Data}
    FOR    ${i}    IN RANGE    0    ${Len}
        Log    ${Data[${i}]}
        ${Key}    Get Dictionary Keys    ${Data[${i}]}
        Log    "${Key[0]}" : "${SelectDevices}"
        ${Devices_Detail}    Run Keyword And Return If    "${Key[0]}"=="${SelectDevices}"    mPrint Detail Selected Device    ${Data[${i}]}    ${SelectDevices}
    END
    [Return]    ${Devices_Detail}

mChangLanguage
    #Click Button 'Profile'
    Comment    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    1m
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]
    Comment    Sleep    3s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    Comment    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout/*/*/*/*/*/*/*/*/*/android.widget.ImageView[@index='0']    1m
    ${SelectConfigLanguage}    Run Keyword If    '${LANGUAGE}' == 'TH'    Set Variable    ภาษาไทย
    ...    ELSE IF    '${LANGUAGE}' == 'EN'    Set Variable    English
    ${ConfigLanguage}    Run Keyword If    '${LANGUAGE}' == 'TH'    Set Variable    หน้าหลัก
    ...    ELSE IF    '${LANGUAGE}' == 'EN'    Set Variable    Home
    Comment    ${ConfigLanguage}    Run Keyword If    '${LANGUAGE}' == 'TH'    Set Variable    ภาษาไทย
    ...    ELSE IF    '${LANGUAGE}' == 'EN'    Set Variable    English
    #Swipe to menu Permission
    mSwipedownToElement    xpath=//android.widget.ImageView[@content-desc="Terms and Conditions" or @content-desc="ข้อกำหนดและเงื่อนไขการให้บริการ"]    8
    #Get Current Language    xpath=//android.widget.ImageView[starts-with(@content-desc,'ภาษา') or starts-with(@content-desc,'Language')]
    ${ActualLanguage}    Get Element Attribute    //android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="2"]    content-desc
    log    ${ActualLanguage}
    ${ActualLanguage}    Split To Lines    ${ActualLanguage}
    ${CheckLanguage}    Run Keyword And Return Status    Should Be Equal    ${ConfigLanguage}    ${ActualLanguage}[0]
    #Change Language
    Comment    Run Keyword If    '${CheckLanguage}'=='False'    Run Keywords    AppiumLibrary.Click Element    xpath=//android.widget.ImageView[starts-with(@content-desc,'ภาษา') or starts-with(@content-desc,'Language')]
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout/*/*/*/android.view.View[@index='0']/android.view.View[@index='1']    30s
    ...    AND    AppiumLibrary.Click Element    xpath=//android.widget.ImageView[@content-desc="${ConfigLanguage}"]
    ...    AND    Sleep    3s
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout/*/*/*/*/*/android.widget.Button[@index='0']    20s
    ...    AND    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout/*/*/*/*/*/android.widget.Button[@index='0']
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.ScrollView/android.view.View[@index='0']    5s
    Run Keyword If    '${CheckLanguage}'=='False'    Run Keywords    AppiumLibrary.Click Element    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]
    ...    AND    mSwipedownToElement    xpath=//android.widget.ImageView[@content-desc="Terms and Conditions" or @content-desc="ข้อกำหนดและเงื่อนไขการให้บริการ"]
    ...    AND    AppiumLibrary.Click Element    xpath=//android.widget.ImageView[starts-with(@content-desc,'ภาษา') or starts-with(@content-desc,'Language')]
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout/*/*/*/*/*/android.view.View[@index='1']    30s
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc=" \ \ \ \ ${SelectConfigLanguage}"]    10s
    ...    AND    AppiumLibrary.Click Element    xpath=//android.widget.ImageView[@content-desc=" \ \ \ \ ${SelectConfigLanguage}"]
    ...    AND    Sleep    3s
    ...    AND    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout/*/*/*/*/*/android.widget.Button[@index='0']    20s
    ...    AND    sleep    3s
    ...    AND    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout/*/*/*/*/*/android.widget.Button[@index='0']
    ...    AND    Wait Until Element Is Visible    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    10s
    #Swipe to Button Login
    mSwipeupToElement    xpath=//*[@content-desc="Login" or @content-desc="เข้าสู่ระบบ"]

mChangelanguageLogin
    [Arguments]    ${Language}
    mClickWebElement    xpath=//android.widget.ImageView[@resource-id='${AppPackagemyAIS}:id/headerHamburger']
    ${CatagoryTab}    Run Keyword And Return Status    mWaitUntilElement    xpath=//myais.l2.c[@index='1']
    Run Keyword If    '${CatagoryTab}'=='True'    mClickWebElement    xpath=//myais.l2.c[@index='1']
    mClickWebElement    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id='${AppPackagemyAIS}:id/recyclerView']/*/*[@resource-id='${AppPackagemyAIS}:id/menuTextView'][@text='ตั้งค่า'] | //androidx.recyclerview.widget.RecyclerView[@resource-id='${AppPackagemyAIS}:id/recyclerView']/*/*[@resource-id='${AppPackagemyAIS}:id/menuTextView'][@text='Setting']
    mClickWebElement    xpath=//android.view.ViewGroup[@resource-id='${AppPackagemyAIS}:id/use_passcode_to_sign_section']
    #Language
    log    ${Language}
    Run Keyword If    '${Language}'=='TH'    mClickWebElement    xpath=//android.view.ViewGroup[@index='1']
    ...    ELSE IF    '${Language}'=='EN'    mClickWebElement    xpath=//android.view.ViewGroup[@index='2']
    mClickWebElement    xpath=//android.widget.ImageButton[@resource-id='${AppPackagemyAIS}:id/imageButton2']

mCheckConsentDetail
    ${StatusConsentForm}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']
    Run Keyword If    '${StatusConsentForm}'=='True'    mVerifyText    ${ConsentlblTitle}    ${ConsentlblTitle_Expected}
    ${RunningIndex}    Evaluate    0
    ${DetailTextActual}    Set Variable    ${EMPTY}
    ${ConfirmButton}    Set Variable    False
    FOR    ${i}    IN RANGE    99
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    0.05s
        ${DetailText}    Run Keyword If    '${TextAppear}'=='True'    mGetText    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.TextView[@index='${RunningIndex}'] | //android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    0.5s
        ${DetailText}    Run Keyword If    '${DetailText}'=='${EMPTY}'    Get Element Attribute    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    content-desc
        ...    ELSE    Set Variable    ${DetailText}
        log    ${DetailText}
        Run Keyword If    '${DetailText}'!='None'    Append To Environment Variable    DetailTextActual    ${DetailText}
        ${RunningIndex}    Evaluate    ${RunningIndex}+1
        log    %{DetailTextActual}
        Run Keyword If    '${TextAppear}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
        ${ConfirmButton}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']    0.05s
        ${BtnInfoCompany}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']    0.05s
        Run Keyword If    '${BtnInfoCompany}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
        Exit For Loop If    '${BtnInfoCompany}'=='True' and '${ConfirmButton}'=='True'
    END
    ${DetailTextActual}    Remove String    %{DetailTextActual}    ;
    ${DetailTextActual}    Remove String    ${DetailTextActual}    ข้อมูลเพิ่มเติมกลุ่มบริษัท AIS
    ${DetailTextExpected}    Set Variable    ${ConsenttxtTitleCardDetail1_Expected}${ConsenttxtDescriptionCardDetail1-1_Expected}${ConsenttxtDescriptionCardDetail1-2_Expected}${ConsenttxtDescriptionCardDetail1-3_Expected}${ConsenttxtTitleCardDetail2_Expected}${ConsenttxtDescriptionCardDetail2-1_Expected}${ConsenttxtDescriptionCardDetail2-2_Expected}${ConsenttxtDescriptionCardDetail2-3_Expected}
    log    ${DetailTextActual}
    Should Be Equal    ${DetailTextActual}    ${DetailTextExpected}
    Run Keyword If    '${StatusConsentForm}'=='True'    mSwipedownToElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.TextView[@index='0']    ${ConsentlblTopic1}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='1']    ${ConsentradioAgree}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='2']    ${ConsentradioDecline}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.TextView[@index='3']    ${ConsentlblTopic2}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='4']    ${ConsentradioAgree}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='5']    ${ConsentradioDecline}
    mVerifyText    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']    ${ConsentbtnConfirm}

mCheckConsentDetailAndSelectStatus
    [Arguments]    ${StatusConsent1}    ${StatusConsent2}
    [Documentation]    Choose 'Agree' or 'Decline' for Status Consent Topic 1 and Topic 2
    ${StatusConsentForm}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']
    Run Keyword If    '${StatusConsentForm}'=='True'    mVerifyText    ${ConsentlblTitle}    ${ConsentlblTitle_Expected}
    ${RunningIndex}    Evaluate    0
    ${DetailTextActual}    Set Variable    ${EMPTY}
    ${ConfirmButton}    Set Variable    False
    FOR    ${i}    IN RANGE    99
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    0.05s
        ${DetailText}    Run Keyword If    '${TextAppear}'=='True'    mGetText    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.TextView[@index='${RunningIndex}'] | //android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    0.5s
        ${DetailText}    Run Keyword If    '${DetailText}'=='${EMPTY}'    Get Element Attribute    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    content-desc
        ...    ELSE    Set Variable    ${DetailText}
        log    ${DetailText}
        Run Keyword If    '${DetailText}'!='None'    Append To Environment Variable    DetailTextActual    ${DetailText}
        ${RunningIndex}    Evaluate    ${RunningIndex}+1
        log    %{DetailTextActual}
        Run Keyword If    '${TextAppear}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
        ${ConfirmButton}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']    0.05s
        ${BtnInfoCompany}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']    0.05s
        Run Keyword If    '${BtnInfoCompany}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
        Exit For Loop If    '${BtnInfoCompany}'=='True' and '${ConfirmButton}'=='True'
    END
    ${DetailTextActual}    Remove String    %{DetailTextActual}    ;
    ${DetailTextActual}    Remove String    ${DetailTextActual}    ข้อมูลเพิ่มเติมกลุ่มบริษัท AIS
    ${DetailTextExpected}    Set Variable    ${ConsenttxtTitleCardDetail1_Expected}${ConsenttxtDescriptionCardDetail1-1_Expected}${ConsenttxtDescriptionCardDetail1-2_Expected}${ConsenttxtDescriptionCardDetail1-3_Expected}${ConsenttxtTitleCardDetail2_Expected}${ConsenttxtDescriptionCardDetail2-1_Expected}${ConsenttxtDescriptionCardDetail2-2_Expected}${ConsenttxtDescriptionCardDetail2-3_Expected}
    log    ${DetailTextActual}
    Should Be Equal    ${DetailTextActual}    ${DetailTextExpected}
    Run Keyword If    '${StatusConsentForm}'=='True'    mSwipedownToElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']
    Run Keyword If    '${StatusConsent1}'=='Agree'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='1']
    Run Keyword If    '${StatusConsent1}'=='Decline'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='2']
    Run Keyword If    '${StatusConsent2}'=='Agree'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='4']
    Run Keyword If    '${StatusConsent2}'=='Decline'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='5']
    Comment    Run Keyword If    '${StatusConsentForm}'=='True'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='1']
    Comment    Run Keyword If    '${StatusConsentForm}'=='True'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/*/android.widget.Button[@index='4']
    Comment    Run Keyword If    '${StatusConsentForm}'=='True'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']

mCheckConsentDetailPartnerList
    ${StatusConsentForm}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']
    Run Keyword If    '${StatusConsentForm}'=='True'    mVerifyText    ${ConsentlblTitle}    ${ConsentlblTitle_Expected}
    ${RunningIndex}    Set Variable    15
    Comment    ${ConfirmButton}    Set Variable    False
    Comment    FOR    ${i}    IN RANGE    99
    Comment    \    ${ButtonInfoAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    0.05s
    Comment    \    ${DetailText}    Run Keyword If    '${ButtonInfoAppear}'=='True'    mGetText    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.TextView[@index='${RunningIndex}'] | //android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    0.5s
    Comment    \    ${DetailText}    Run Keyword If    '${DetailText}'=='${EMPTY}'    Get Element Attribute    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    content-desc
    ...    ELSE    Set Variable    ${DetailText}
    Comment    \    ${BeforeButtonInfo}    Run Keyword If    '${DetailText}'!='None'    Set Variable    ${DetailText}
    Comment    \    Run Keyword If    '${BeforeButtonInfo}'=='AIS'    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']
    Comment    \    Exit For Loop If    '${BeforeButtonInfo}'=='AIS'
    Comment    \    Run Keyword If    '${ButtonInfoAppear}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
    Comment    \    ${RunningIndex}    Evaluate    ${RunningIndex}+1
    Comment    END
    mSwipedownInConsentDetail    2
    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']
    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']
    ${PartnerListActual}    Set Variable    ${EMPTY}
    ${RunningIndex}    Evaluate    1
    mWaitUntilElement    xpath=//android.view.View[@resource-id='myNav']/android.widget.TextView[@index='${RunningIndex}']
    FOR    ${i}    IN RANGE    17
        ${PartnerList}    Get Text    xpath=//android.view.View[@resource-id='myNav']/android.widget.TextView[@index='${RunningIndex}']
        Append To Environment Variable    PartnerListActual    ${PartnerList}
        ${RunningIndex}    Evaluate    ${RunningIndex}+1
    END
    ${PartnerListActual}    Remove String    %{PartnerListActual}    ;
    ${PartnerListExpected}    Set Variable    ${ConsenttxtPartnerList_Expected}
    Should Be Equal    ${PartnerListActual}    ${PartnerListExpected}

mCheckConsentDetailPrivacyLink
    ${StatusConsentForm}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']
    Run Keyword If    '${StatusConsentForm}'=='True'    mVerifyText    ${ConsentlblTitle}    ${ConsentlblTitle_Expected}
    ${RunningIndex}    Evaluate    0
    ${DetailTextActual}    Set Variable    ${EMPTY}
    ${ConfirmButton}    Set Variable    False
    FOR    ${i}    IN RANGE    99
        ${TextAppear}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    0.05s
        ${DetailText}    Run Keyword If    '${TextAppear}'=='True'    mGetText    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.TextView[@index='${RunningIndex}'] | //android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    0.5s
        ${DetailText}    Run Keyword If    '${DetailText}'=='${EMPTY}'    Get Element Attribute    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.view.View[@index='${RunningIndex}']    content-desc
        ...    ELSE    Set Variable    ${DetailText}
        log    ${DetailText}
        ${PrivacyLink}    Run Keyword And Return Status    Should Be Equal    ${DetailText}    ${ConsenttxtPrivacyLink}
        Exit For Loop If    '${PrivacyLink}'=='True'
        ${RunningIndex}    Evaluate    ${RunningIndex}+1
        Run Keyword If    '${TextAppear}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
        ${ConfirmButton}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='4']    0.05s
        ${BtnInfoCompany}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/android.widget.Image[@index='${RunningIndex}']    0.05s
        Run Keyword If    '${BtnInfoCompany}'=='True'    mSwipedownToElementInConsentDetail    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']    1
    END
    mClickWebElement    xpath=//android.view.View[@resource-id='consent-web']/android.view.View[@index='2']/*[@index='${RunningIndex}']
    mWaitUntilElement    xpath=//android.view.View[@resource-id='container']/*/*/*[@index='0']
    mVerifyText    xpath=//android.view.View[@resource-id='container']/*/*/*[@index='0']    ${ConsentlblPrivacyTitle}

mClickDeleteMsg
    #Click hold
    Long Press    xpath=//android.widget.TextView[@text='AIS']
    #Click icon bin
    mClickWebElement    ${AppMoodbtnDelete}
    #Click Yes
    mClickWebElement    ${AppMoodPopupDeletebtnYes}

mClickWebElementCenter
    [Arguments]    ${locator}
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${CenterX}    Evaluate    (${bounds[0]}+${bounds[2]})/2
    ${CenterY}    Evaluate    (${bounds[1]}+${bounds[4]})/2
    Click Element At Coordinates    ${CenterX}    ${CenterY}

mCloseAunjaiPopup
    ${Status}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//*[@resource-id='${AppPackagemyAIS}:id/askAunJaiFullLayout' or @resource-id='${AppPackagemyAIS}:id/askAunJaiView']
    Run Keyword If    '${Status}'=='True'    mClickWebElement    xpath=//android.widget.ImageButton[@resource-id='${AppPackagemyAIS}:id/closeFullButton' or @resource-id='${AppPackagemyAIS}:id/closeMiniButton']

mDeleteMsgAIS
    #Open App Mood
    mOpenApplication    ${MobileSeries}    ${JsonfilePath}    ${AppPackageMood}    ${AppActivityMood}
    ${StatusSMS}    Run Keyword And Return Status    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text='AIS']
    Run Keyword If    '${StatusSMS}'=='True'    mClickDeleteMsg
    ...    ELSE IF    '${StatusSMS}'=='False'    Close Application

mGetOTP
    #Open AppMood
    mOpenApplication    ${MobileSeries}    ${JsonfilePath}    ${AppPackageMood}    ${AppActivityMood}
    #Click sms AIS
    mClickWebElement    xpath=//*[@resource-id='com.calea.echo:id/name'][@text='AIS']
    #Get OTP
    ${TextActualOTP}    mGetText    xpath=//android.widget.TextView[@resource-id='com.calea.echo:id/imm_text']
    ${Removetext}    Remove String    ${TextActualOTP}    ${SPACE}รหัส
    ${RemoveDot}    Remove String    ${Removetext}    .
    ${TextOTP}    Fetch From Right    ${RemoveDot}    myAIS OTP
    log    ${TextOTP}
    ${SplitOTP}    Split String    ${TextOTP}
    ${OTP}    Set Variable    ${SplitOTP[0]}
    log    ${OTP}
    [Return]    ${OTP}

mImportDataJSONandReturnDataCount
    [Arguments]    ${JsonfilePathCategory}
    ${Json}    Get File    ${JsonfilePathCategory}
    ${Obj}    Evaluate    json.loads("""${Json}""")    json
    ${Len}    Get Length    ${Obj}
    ${Count}    Set Variable    0
    ${TotalDataCount}    Set Variable    0
    FOR    ${i}    IN RANGE    ${Len}
        ${Data}    Set Variable    ${Obj[${i}]}
        ${Count}    Get Length    ${Data['content']}
        ${TotalDataCount}    Evaluate    ${TotalDataCount}+${Count}
    END
    [Return]    ${TotalDataCount}    ${Obj}

mLoginmyAIS
    [Arguments]    ${LoginType}    &{LoginProfileCurrentUse}
    [Documentation]    *Description*
    ...
    ...    Login to myAIS
    ...
    ...    *Format keyword*
    ...    | mLoginmyAIS | ${LoginType} | &{ENV_MobileType_Account} |
    ...
    ...    *Example keyword*
    ...    | mLoginmyAIS | PinTel | &{Staging_Postpaid_Account1} |
    ...    | mLoginmyAIS | PinEmail | &{Production_Prepaid_Account2} |
    ...
    ...    *Allow Value for '${LoginType}'*
    ...    - OTP
    ...    - PINTel
    ...    - PINEmail
    ...    - Auto
    ...    - None
    ...
    ...    *Format Dictionary for '&{ENV_MobileType_Account}'*
    ...    | &{Staging_Postpaid_Account1} | Mobile=089123xxxx | Email=Autoxxx@gmail.com | PIN=111xxx |
    #Click Button 'Profile'
    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    1m
    mClickWebElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]
    Sleep    2s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*/*/android.view.View[@index='0']    1m
    sleep    5s    #เนื่องจากมี element ที่โหลดช้าทำให้เกิดผลกระทบกับ keyword อื่น ๆ
    #Click Login
    ${LoginVisible}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.view.View[@content-desc="Login"] | //android.view.View[@content-desc="เข้าสู่ระบบ"]
    log    ${LoginStatus}
    Run Keyword If    '${LoginStatus}'=='NoneLogin' and '${LoginVisible}'=='True'    Run Keywords    mChangLanguage
    ...    AND    mClickWebElement    xpath=//android.view.View[@content-desc="Login"] | //android.view.View[@content-desc="เข้าสู่ระบบ"]
    ...    ELSE IF    '${LoginStatus}'=='NoneLogin' or '${LoginStatus}'=='Success' and '${LoginVisible}'=='False'    Run Keywords    mChangLanguage
    ...    AND    mLogoutmyAIS
    ...    AND    mClickWebElement    xpath=//*[@content-desc="Login" or @content-desc="เข้าสู่ระบบ"]
    Comment    #เอาไปต่อบรรทัดบน xpath มีปัญหายังไม่สามารถ Logout    Runkeywords    AppiumLibrary.Close All Applications    # AND \ \ \ Return From Keyword
    mWaitUntilElement    xpath=//android.widget.EditText[@resource-id="username"]    20s
    #Switch Context
    Comment    @{all_contexts}    Get Contexts
    Comment    Log Many    @{all_contexts}
    Comment    Switch To Context    ${all_contexts}[1]
    Comment    Wait Until Element Is Visible    //input[@name="username"]
    Comment    AppiumLibrary.Input Text    //input[@name="username"]    ${MobileNumberOrEmail}[0]
    Comment    AppiumLibrary.Click Element    //button[@id="btn_register"]
    #Enter PIN
    ${MobileNumberOrEmail}    Set Variable If    "${LoginType}"=="PINTel"    ${LoginProfileCurrentUse}[Mobile]    ${LoginProfileCurrentUse}[Email]
    log    ${MobileNumberOrEmail}
    mInputPhoneNumberAndPin    ${MobileNumberOrEmail}    ${LoginProfileCurrentUse}[PIN]
    #Set Variable
    Set Global Variable    ${LoginStatus}    Success
    Set Global Variable    ${LoginProfileLastUse}    ${MobileNumberOrEmail}
    log    ${LoginProfileLastUse}
    #Wait Avatar Profile Display
    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    1m
    AppiumLibrary.Close All Applications

mOpenApplicationAndLogin
    [Arguments]    ${LoginType}=${LOGIN}    &{LoginProfileCurrentUse}
    [Documentation]    *Description*
    ...
    ...    Open Application And Login
    ...
    ...    *Format keyword*
    ...    | ApplicationAndLogin | ${LoginType} | &{ENV_MobileType_Account} |
    ...
    ...    *Example keyword*
    ...    | mOpenApplicationAndLogin | PinTel | &{Staging_Postpaid_Account1} |
    ...    | mOpenApplicationAndLogin | PinEmail | &{Production_Prepaid_Account3} |
    ...
    ...    *Allow Value for '${LoginType}'*
    ...    - OTP
    ...    - PINTel
    ...    - PINEmail
    ...    - Auto
    ...    - None
    ...
    ...    *Format Dictionary for '&{ENV_MobileType_Account}'*
    ...    | &{Staging_Postpaid_Account1} | Mobile=0891230221 | Email=Automate.qa.teamsqar@gmail.com \ \ \ \ | PIN=111111 |
    Comment    Run Keyword If    '${ENV}' == 'Production' and '${LOGIN}' == 'otp'    mDeleteMsgAIS
    log    ${LoginProfileCurrentUse}
    log    ${LoginType}
    ${CurrentProfile}    Set Variable If    "${LoginType}"=="PINTel"    ${LoginProfileCurrentUse}[Mobile]    ${LoginProfileCurrentUse}[Email]
    ${SameProfile}    Run Keyword And Return Status    Should Be Equal    ${CurrentProfile}    ${LoginProfileLastUse}
    ${IsSetLoginStatus}    Get Variable Value    ${LoginStatus}
    Run Keyword If    "${IsSetLoginStatus}" == "${NONE}"    Set Global Variable    ${LoginStatus}    NoneLogin
    ...    ELSE    Set Global Variable    ${LoginStatus}
    Run Keyword If    "${SameProfile}" == "True"    mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Flutter
    ...    ELSE IF    '${SameProfile}'=='False'    Run Keywords    mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Native
    ...    AND    mLoginmyAIS    ${LoginType}    &{LoginProfileCurrentUse}
    ...    AND    mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Flutter
    Comment    ${PopupAlert}    Run Keyword And Return Status    mWaitUntilElement    ${HomepagePopupAlert}    2s
    Comment    Run Keyword If    '${PopupAlert}' == 'true'    mClickWebElement    ${HomepagePopupAlert}
    Comment    Run Keyword If    '${LOGIN}' == 'auto'    mChangelanguageLogin    ${Language}
    ...    ELSE    mChangelanguage    ${Language}
    Comment    Run Keyword If    '${LOGIN}' == 'otp'    mOTPMessage

mOTPMessage
    log    ${Mobilenumber_${MOBILE}_${CampaignName}}
    mLoginmyAIS    ${Mobilenumber_${MOBILE}_${CampaignName}}
    ${OTP}    Run Keyword If    '${ENV}' == 'Production'    mGetOTP
    ...    ELSE    Set Variable    0000
    Run Keyword If    '${ENV}' == 'Production'    mSwitchApp
    mInputText    ${HomepagefieldInputOTP}    ${OTP}
    mClickWebElement    ${HomepagebtnConfirm}
    mSkipConsent    ปฏิเสธ    ปฏิเสธ

mOpenApplication
    [Arguments]    ${AppPackage}    ${AppActivity}    ${AppPlatform}=Flutter    ${noReset}=false    ${ShouldTerminateApp}=true
    [Documentation]    *Description*
    ...
    ...    Open Application by Platform
    ...
    ...    *Format keyword*
    ...    | mOpenApplication | ${AppPackage} | ${AppActivity} | ${AppPlatform}=Flutter |
    ...
    ...    *Example keyword*
    ...    | mOpenApplication | com.ais.mimo.eservice.inhouse1 | com.adl.mfaf.MainActivity |
    ...    | mOpenApplication | ${AppPackagemyAIS} | ${AppActivitymyAIS} | Native |
    ...
    ...    *Allow Value for AppPlatform*
    ...    - Flutter
    ...    - Native
    ${Library}    Set Variable If    "${AppPlatform}" == "Native"    AppiumLibrary    AppiumFlutterLibrary
    ${AutomationName}    Set Variable If    "${AppPlatform}" == "Native"    UiAutomator2    flutter
    #Set Property Device
    ${SerialNumber}    Run Process    adb    shell    getprop    ro.serialno
    ${PlatformVersion}    Run Process    adb    shell    getprop    ro.build.version.release
    #Config Remote URL
    ${RemoteURL}    Run Keyword If    "${DEVICE}"=="BrowserStack"    Set Variable    http://hub.browserstack.com/wd/hub
    ...    ELSE    Set Variable    http://127.0.0.1:4723/wd/hub
    #Open in Real Device
    Run Keyword If    "${DEVICE}"=="Real"    ${Library}.Open Application    ${RemoteURL}    platformName=${OS}    platformVersion=${PlatformVersion.stdout}    deviceName=${SerialNumber.stdout}    appPackage=${AppPackage}    appActivity=${AppActivity}    unicodeKeyboard=true    noReset=${noReset}    shouldTerminateApp=${ShouldTerminateApp}    automationName=${AutomationName}    ignoreHiddenApiPolicyError=true
    #Open in Visual Device
    Run Keyword If    "${DEVICE}"=="Visual"    ${Library}.Open Application    ${RemoteURL}    platformName=${OS}    deviceName=${SerialNumber.stdout}    newCommandTimeout=5000    appPackage=${AppPackage}    appActivity=${AppActivity}    unicodeKeyboard=true    noReset=${noReset}    shouldTerminateApp=${ShouldTerminateApp}    automationName=${AutomationName}    ignoreHiddenApiPolicyError=true    autoGrantPermissions=true    app=${APPPATH}
    #Open in Browser Stack
    ${SUITE}    Split String From Right    ${SUITE NAME}    .    1
    ${CurrentDate}    Get Current Date    result_format=%d-%m-%Y
    ${CapabilitiesBrowserStack}    Run Keyword If    "${DEVICE}"=="BrowserStack"    Create Dictionary    buildName=${SUITE NAME} ${CurrentDate}    sessionName=${TEST NAME}    userName=juralakp_p2Vx0U    accessKey=PPed2Tj3ZNZqaGw6kLyw    interactiveDebugging=True    appiumVersion=2.0.1    timezone=Bangkok
    Run Keyword If    "${DEVICE}"=="BrowserStack"    ${Library}.Open Application    ${RemoteURL}    platformName=android    platformVersion=13.0    deviceName=Samsung Galaxy S23    noReset=${noReset}    unicodeKeyboard=true    newCommandTimeout=5000    autoAcceptAlerts=true    app=bs://b5dd4956cf3805c278c9c71a661820366834f6dc    bstack:options=${CapabilitiesBrowserStack}    automationName=${AutomationName}    autoGrantPermissions=true    appPackage=${AppPackage}    appActivity=${AppActivity}
    [Teardown]

mPrint Detail Selected Device
    [Arguments]    ${i}    ${DeviceName}
    [Documentation]    *Description*
    ...
    ...    This Keyword for Print Detail Devices
    ...
    ...    *Format keyword*
    ...    | mPrint Detail Selected Device | ${i} | ${DeviceName} |
    ...
    ...    *Example keyword*
    ...    | mPrint Detail Selected Device | ${Data[${i}]} | ${SelectDevices} |
    ${Set_New_Var}    Set Variable    ${i}
    ${Set_New_Var}    Set Variable    ${set_New_Var['${DeviceName}']}
    ${Set_New_Var}    Set Variable    ${Set_New_Var[0]}
    [Return]    ${Set_New_Var}

mSkipConsent
    [Arguments]    ${RadioButton}    ${RadioButton2}
    ${status}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.widget.LinearLayout[@resource-id='${AppPackagemyAIS}:id/layout_consent1']/android.widget.TextView[@resource-id='${AppPackagemyAIS}:id/consent1']
    Run Keyword If    '${status}' == 'True'    mSwipedownToElement    xpath=//android.widget.TextView[@resource-id='${AppPackagemyAIS}:id/info_ais']
    Run Keyword If    '${status}' == 'True' and '${RadioButton}'=='ยินยอม'    mClickWebElement    xpath=//android.widget.RadioButton[@resource-id='${AppPackagemyAIS}:id/acceptRadioButton']
    Run Keyword If    '${status}' == 'True' and '${RadioButton}'=='ปฏิเสธ'    mClickWebElement    xpath=//android.widget.RadioButton[@resource-id='${AppPackagemyAIS}:id/refuseRadioButton']
    Run Keyword If    '${status}' == 'True' and '${RadioButton2}'=='ยินยอม'    mClickWebElement    xpath=//android.widget.RadioButton[@resource-id='${AppPackagemyAIS}:id/acceptRadioButton2']
    Run Keyword If    '${status}' == 'True' and '${RadioButton2}'=='ปฏิเสธ'    mClickWebElement    xpath=//android.widget.RadioButton[@resource-id='${AppPackagemyAIS}:id/refuseRadioButton2']
    Run Keyword If    '${status}' == 'True'    mClickWebElement    xpath=//android.widget.Button[@resource-id='com.ais.mimo.eservice.debug:id/continueBtn']

mSwipeLeftOnElement
    [Arguments]    ${locator}    ${amount}=1
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${bounds[2]}    Evaluate    ${bounds[2]}-20
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    ${bounds[2]}    ${bounds[1]}    ${bounds[0]}    ${bounds[1]}    3000
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipeLeftOnElementToEdge
    [Arguments]    ${locator}    ${amount}=1
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${bounds[2]}    Evaluate    ${bounds[2]}-20
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    ${bounds[2]}    ${bounds[3]}    0    ${bounds[3]}    3000
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipeRightOnElement
    [Arguments]    ${locator}    ${amount}=1
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${bounds[0]}    Evaluate    ${bounds[0]}+20
    ${bounds[2]}    Evaluate    ${bounds[2]}-20
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    ${bounds[0]}    ${bounds[1]}    ${bounds[2]}    ${bounds[1]}
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipeRightOnElementToEdge
    [Arguments]    ${locator}    ${amount}=1
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    0    ${bounds[1]}    ${bounds[2]}    ${bounds[1]}
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipedown
    [Arguments]    ${amount}=1
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    100    800    0    0
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipedownOnElement
    [Arguments]    ${locator}    ${amount}=1
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${bounds[2]}    Evaluate    ${bounds[2]}-20
    FOR    ${i}    IN RANGE    ${amount}
        Swipe    ${bounds[0]}    ${bounds[3]}    ${bounds[0]}    ${bounds[1]}    3000
        Exit For Loop If    '${i}'=='${amount}'
    END

mSwipedownToElement
    [Arguments]    ${locator}    ${count}=5
    FOR    ${i}    IN RANGE    ${count}
        ${StatusElement}    Run Keyword And Return Status    Wait Until Page Contains Element    ${locator}    1s
        Run Keyword If    '${StatusElement}'=='True'    Exit For Loop
        ...    ELSE    Swipe    100    800    0    0
        Exit For Loop If    '${i}'=='${count}'
    END

mSwipetoBannerLogin
    [Documentation]    เลื่อนลงมาหา Lifrstyle & Servies Banner
    mSwipedownToElement    xpath=//android.widget.LinearLayout[@resource-id='${AppPackagemyAIS}:id/bannerIndicator']/android.view.View

mSwipetoBannerNonLogin
    Wait Until Page Contains Element    //*[@resource-id='${AppPackagemyAIS}:id/bannerRecyclerView']    ${Max_Timeout}
    Swipe    960    1453    960    676    1000
    Wait Until Page Contains Element    //*[@resource-id='${AppPackagemyAIS}:id/bannerRecyclerView']    ${Max_Timeout}
    Swipe    920    1321    910    812    1000

mSwipeupToElement
    [Arguments]    ${locator}
    ${count}    Set Variable    10
    FOR    ${i}    IN RANGE    ${count}
        ${StatusElement}    Run Keyword And Return Status    Wait Until Page Contains Element    ${locator}    0.1s
        Run Keyword If    '${StatusElement}'=='True'    Exit For Loop
        ...    ELSE    Swipe    0    300    0    1000
        Exit For Loop If    '${i}'=='${count}'
    END

mSwitchApp
    sleep    2s
    Press Keycode    187
    sleep    3s
    ${Status}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.TextView[@text='myAIS']
    log    ${Status}
    Run Keyword If    '${Status}'=='True'    mClickWebElement    xpath=//android.widget.TextView[@text='myAIS']
    ...    ELSE IF    '${Status}'=='False'    mClickWebElement    xpath=//android.widget.FrameLayout[@content-desc="myAIS"]/android.view.View

mSwitchAppMood
    Press Keycode    187
    BuiltIn.Sleep    1s
    mClickWebElement    //android.widget.FrameLayout[@content-desc="#Mood Mood"]/android.view.View[1]

mVerifyTextTitle
    [Arguments]    ${Locator}    ${Expected}
    Comment    Sleep    4s
    mVerifyText    ${Locator}    ${Expected}
    Comment    ${Title}    Create List
    Comment    FOR    ${i}    IN RANGE    4
    Comment    \    ${TitleReload}    Get Text    ${Locator}
    Comment    \    Append To List    ${Title}    ${TitleReload}
    Comment    \    log many    ${Title}
    Comment    END
    Comment    Should Be Equal As Strings    ${Title[3]}    ${Expected}

wLoginWebpoint
    #Login with Token
    Selenium2Library.Open Browser    ${WebsiteUrl}    ff
    Go to    ${WebsiteUrl}
    #Input Data and Click Login
    wInputWebText    ${LoginfieldUsername}    ${Username}
    wInputWebText    ${LoginfieldPassword}    ${Password}
    wClickWebButton    ${LoginbtnSubmit}
    Sleep    5s

wRefundRedeemNumber
    [Arguments]    ${Number}    ${TextMessage}
    #Refund Redeem
    Selenium2Library.Input Text    //input[@id='mobile_no']    ${Number}
    wClickWebElement    xpath=//button[@class='button w-full success']
    ${result}    BuiltIn.Run Keyword And Return Status    Selenium2Library.Wait Until Element Is Visible    xpath=//tr[@class='h-14 border border-gray-200 ng-star-inserted'][1]/td[@class='text-center'][5]
    ${TextRefund}    Run Keyword If    '${result}'=='True'    Selenium2Library.Get Text    xpath=//tr[@class='h-14 border border-gray-200 ng-star-inserted'][1]/td[@class='text-center'][5]
    log    ${TextRefund}
    Run Keyword If    '${TextRefund}'=='Complete'    wClickWebElement    xpath=//tr[@class='h-14 border border-gray-200 ng-star-inserted'][1]/*/button[@class='p-button-primary p-button-rounded p-button-plain p-button p-component p-button-icon-only']
    Run Keyword If    '${TextRefund}'=='Complete'    Selenium2Library.Input Text    //textarea[@id='reason']    ${TextMessage}
    Run Keyword If    '${TextRefund}'=='Complete'    wClickWebElement    xpath=//div[@class='grid grid-cols-4 gap-2']/div[*][2]/*/button[@class='button w-full success']
    #Refund code
    Run Keyword If    '${TextRefund}'=='Complete'    wClickWebElement    xpath=//tr[@class='h-14 border border-gray-200 ng-star-inserted'][1]/*/button[@class='p-button-secondary p-button-rounded p-button-plain p-button p-component p-button-icon-only']
    ${result2}    BuiltIn.Run Keyword And Return Status    Selenium2Library.Wait Until Element Is Visible    xpath=//app-button[@class='px-2 w-36']/button[@class='button w-full success']    3s
    Run Keyword If    '${TextRefund}'=='Complete' and '${result2}'=='True'    wClickWebElement    xpath=//app-button[@class='px-2 w-36']/button[@class='button w-full success']

mInputPhoneNumberAndPin
    [Arguments]    ${PhoneNumber}    ${PinNumber}
    mWaitUntilElement    xpath=//android.widget.EditText[@index="1"]    30s
    Comment    Run Keyword If    Wait Until Element Is Visible    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    AppiumLibrary.Click Element    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]
    ...    ELSE    AppiumLibrary.Input Text    xpath=//android.widget.EditText[@resource-id="username"]    ${PhoneNumber}
    ${StatusX}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    Run Keyword If    '${StatusX}'=='True'    mClickWebElement    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    mClickWebElement    xpath=//android.widget.EditText[@index="1"]    30s
    mInputText    xpath=//android.widget.EditText[@index="1"]    ${PhoneNumber}
    Sleep    2s    #เนื่องจากหน้าโหลดช้า
    Comment    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="btn_register"]
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index="0"]
    #Xpath login by this email    xpath=//android.view.View[@resource-id='login_fbb_id']/android.widget.Button[@index='0']
    #Check button login by this email
    FOR    ${i}    IN RANGE    10
        ${StatusPin}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    1s
        ${StatusLoginByEmail}    Run Keyword If    '${StatusPin}'=='False'    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    Sleep    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']
        Exit For Loop If    '${StatusPin}'=='True'
    END
    #PIN    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]
    Comment    AppiumLibrary.Wait Until Element Is Visible    //android.view.View[@resource-id="login_numbers"]/*/*/*[@text="${PinNumber}[0]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    30s
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[1]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[2]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[3]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[4]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[5]"]
    [Teardown]    mCaptureAppium

mInputPhoneNumberAndPinIos
    [Arguments]    ${PhoneNumber}    ${PinNumber}
    mClickWebElement    xpath=//XCUIElementTypeOther[@name="My ID Journey"]/XCUIElementTypeTextField    30s
    AppiumLibrary.Input Text    xpath=//XCUIElementTypeOther[@name="My ID Journey"]/XCUIElementTypeTextField    ${PhoneNumber}
    Sleep    2s    #เนื่องจากหน้าโหลดช้า
    mClickWebElement    xpath=//XCUIElementTypeOther[@name="My ID Journey"]/XCUIElementTypeButton[2]
    #PIN
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[0]"]    30s
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[1]"]
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[2]"]
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[3]"]
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[4]"]
    mClickWebElement    //XCUIElementTypeButton[@name="${PinNumber}[5]"]

mConvertDateToString
    [Arguments]    ${input_date}    ${LANGUAGE}=${LANGUAGE}
    [Documentation]    *Description*
    ...
    ...
    ...    *Format keyword*
    ...    ${input_date}
    ...
    ...
    ...    *Example keyword*
    ...    | ${result} | Convert To Thai Date | ${input_date} |
    ...
    ...    *รองรับ date ที่ได้มาจาก API เท่านั้น เช่น 2022-03-02 23:59:59*
    ${DateLong}    Convert Date    ${input_date}    result_format=datetime
    ${Year}    Run Keyword If    "${LANGUAGE}"=="TH"    Set Variable    ${DateLong.year+543}
    ...    ELSE    Set Variable    ${DateLong.year}
    #Convert Month to Thai Month
    ${MonthsList}    Create Dictionary    Jan=ม.ค.    Feb=ก.พ.    Mar=มี.ค.    Apr=เม.ย.    May=พ.ค.    Jun=มิ.ย.    Jul=ก.ค.    Aug=ส.ค.    Sep=ก.ย.    Oct=ต.ค.    Nov=พ.ย.    Dec=ธ.ค.
    ${MonthThai}    Get From Dictionary    ${MonthsList}    ${DateLong.strftime('%b')}
    ${Month}    Run Keyword If    "${LANGUAGE}"=="TH"    Set Variable    ${MonthThai}
    ...    ELSE    Set Variable    ${DateLong.strftime('%b')}
    #Merge Date
    ${Result}    Set Variable    ${DateLong.day} ${Month} ${Year}
    [Return]    ${Result}

mValidateFormatNumber
    [Arguments]    ${Locator}    ${Masking}=True
    [Documentation]    *Description*
    ...    เช็ค Format Phone Number \ *Format keyword*
    ...    | mValidateFormatNumber | Locator | True |
    ...
    ...
    ...    *Example keyword*
    ...    | mValidateFormatNumber | Locator | True |
    ...    | mValidateFormatNumber | Locator | False |
    ...
    ...    *Allow Value for Masking*
    ...    - True
    ...    - False
    ${PhoneNumber}    Get Element Text    ${Locator}
    ${Regexp}    Set Variable If    "${Masking}" == "True"    XXX    \\d{3}
    Comment    ${Regexp}    Run Keyword If    "${Masking}" == "True"    Set Variable    XXX
    ...    ELSE    Set Variable    d{3}
    Should Match Regexp    ${PhoneNumber}    ^\\d{3}-?${Regexp}-?\\d{4}$

mLogoutmyAIS
    [Documentation]    *Description*
    ...
    ...    Logout Profile
    ...
    ...    *Format keyword*
    ...    | mLogoutmyAIS |
    ...
    ...    *Example keyword*
    ...    | mLogoutmyAIS |
    #Swipe to Section History
    mSwipedownToElement    xpath=//*[@content-desc="History" or @content-desc="ประวัติ"]    5
    #Swipe ให้ Section History หายไปจากหน้าจอ เพื่อให้คลิกปุ่ม Logout ได้
    mSwipedownUntilElementInvisible    xpath=//*[@content-desc="History" or @content-desc="ประวัติ"]    5
    mClickWebElement    xpath=//*[@content-desc="Log out" or @content-desc="ออกจากระบบ"]
    mWaitUntilElement    xpath=//*[@content-desc="Cancel" or @content-desc="ยกเลิก"]    10
    #Click Logout on Popup
    mClickWebElement    xpath=//*[@content-desc="Log out" or @content-desc="ออกจากระบบ"]
    #Wait Avatar Profile Display
    Comment    mWaitUntilElement    xpath=//android.widget.ImageView[starts-with(@content-desc,'ตั้งค่าภาษาแอปพลิเคชัน ภาษาไทย') or starts-with(@content-desc,'App Language English')]    1m
    Comment    Swipe    350    750    350    1200
    Comment    mWaitUntilElement    xpath=//android.widget.ScrollView/android.view.View[@index='0']    1m
    #Swipe to Button Login and Click
    Comment    mChangLanguage
    Comment    mSwipeupToElement    xpath=//android.widget.ScrollView/android.view.View[@index='0']    #xpath=//*[@content-desc="Login" or @content-desc="เข้าสู่ระบบ"]
    Comment    Swipe    350    789    350    1168
    [Teardown]    mCaptureAppium

mSwipedownUntilElementInvisible
    [Arguments]    ${locator}    ${count}=5
    Comment    ${count}    Set Variable    5
    FOR    ${i}    IN RANGE    ${count}
        ${StatusElement}    Run Keyword And Return Status    Wait Until Page Does Not Contain Element    ${locator}    5s
        Run Keyword If    '${StatusElement}'=='True'    Exit For Loop
        ...    ELSE    Swipe    100    800    0    0
        Exit For Loop If    '${i}'=='${count}'
    END

mSelectLanguage
    #WAit
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']    30s
    mWaitUntilElement    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    30s
    #Select Language on Radio Button
    Run Keyword If    '${LANGUAGE}'=='TH'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="0"]
    Run Keyword If    '${LANGUAGE}'=='EN'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="1"]
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    Comment    sleep    1s
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']/*    10s
    #Click Button 'Continue'
    Comment    Wait Until Element Is Visible    xpath=//android.view.View[@index='5']
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View[@index='5']
    Comment    sleep    1s
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']    10s
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']
    #Allow Permission Notification and Location
    Sleep    3s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    FOR    ${i}    IN RANGE    2
        ${StatusEnable}    Run Keyword And Return Status    mWaitUntilElement    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]    10s
        Run Keyword If    '${StatusEnable}'=='True'    Run Keywords    mClickWebElement    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]
        ...    AND    mAllowPermission
        Exit For Loop If    "${StatusEnable}"=="False"
    END
    #Redirect to Login Screen
    FOR    ${i}    IN RANGE    20
        ${StatusUsername}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.EditText[@index="1"]    2s
        Exit For Loop If    "${StatusUsername}"=="True"
    END
    Sleep    1s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    #Click 'เข้าสู่หน้าหลัก'
    Comment    mClickWebElement    xpath=//android.view.View[@resource-id='formRegister']/android.widget.Button
    Comment    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    30s
    [Teardown]    mCaptureAppium

mSelectLanguageIos
    #WAit
    mWaitUntilElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[1]    5m
    Run Keyword If    '${LANGUAGE}'=='TH'    mClickWebElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeImage[1]
    Run Keyword If    '${LANGUAGE}'=='EN'    mClickWebElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeImage[2]
    mWaitUntilElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]/XCUIElementTypeWindow//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[3]
    mClickWebElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]/XCUIElementTypeWindow//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[3]
    Comment    sleep    3s
    Comment    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']/*    10s
    #Click Continue
    Comment    Wait Until Element Is Visible    xpath=//android.view.View[@index='5']
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View[@index='5']
    Comment    sleep    1s
    mWaitUntilElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[1][@index='7']    20s
    mClickWebElement    xpath=//XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[1][@index='7']
    #Enable
    Comment    sleep    1s
    mClickWebElement    //XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[3]    10s
    Sleep    2s
    Comment    ###AllowPermission###
    ${AllowPermission}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    //XCUIElementTypeButton[@name="อนุญาต" or @name="Allow" or @name="Allowed"]    5s
    Run Keyword If    "${AllowPermission}"=="True"    mClickElementAppium    //XCUIElementTypeButton[@name="อนุญาต" or @name="Allow" or @name="Allowed"]
    sleep    3s
    mClickWebElement    //XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[4]    3s
    sleep    3s
    mClickWebElement    //XCUIElementTypeApplication[@name="myAIS-Prod"]//XCUIElementTypeOther[2]/XCUIElementTypeOther[2]/XCUIElementTypeStaticText[4]    3s

mAllowPermission
    ${Status}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.widget.Button[contains(@resource-id,'allow_button') or contains(@resource-id,'allow_foreground')]
    Run Keyword If    '${Status}'=='True'    AppiumLibrary.Click Element    xpath=//android.widget.Button[contains(@resource-id,'allow_button') or contains(@resource-id,'allow_foreground')]

mValidateHomePage
    Sleep    5s
    #Check Mobile Novigation Bar
    #AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/android.widget.ImageView[@index="2"]
    #AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/android.widget.ImageView[@index="3"]
    #AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/android.widget.ImageView[@index="4"]
    AppiumLibrary.Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/android.widget.ImageView[@index="6"]

mSelectLanguageAndSkipPermission
    Sleep    5s
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']    5m
    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    5m
    Run Keyword If    '${LANGUAGE}'=='TH'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="0"]
    Run Keyword If    '${LANGUAGE}'=='EN'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="1"]
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    Comment    sleep    1s
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']/*    10s
    #Click Continue
    Comment    Wait Until Element Is Visible    xpath=//android.view.View[@index='5']
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View[@index='5']
    Comment    sleep    1s
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']    10s
    AppiumLibrary.Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']
    #Enable
    sleep    1s
    Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" or starts-with(@content-desc,"Enable") or starts-with(@content-desc,"เปิดการ")]    10s
    AppiumLibrary.Click Element    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" or starts-with(@content-desc,"Enable") or starts-with(@content-desc,"เปิดการ")]
    mAllowPermission
    #Enable
    sleep    3s
    ${StatusEnable}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" or starts-with(@content-desc,"Enable") or starts-with(@content-desc,"เปิดใช้")]    10s
    Run Keyword If    '${StatusEnable}'=='True'    Run Keywords    AppiumLibrary.Click Element    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" or starts-with(@content-desc,"Enable") or starts-with(@content-desc,"เปิดใช้")]
    ...    AND    mAllowPermission

mInputPhoneNumberAndOtp
    [Arguments]    ${PhoneNumber}    ${OTPNumber}
    ##
    Wait Until Element Is Visible    xpath=//*[@resource-id='username']    1m
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.EditText[@resource-id="username"]
    AppiumLibrary.Input Text    xpath=//android.widget.EditText[@resource-id="username"]    ${PhoneNumber}
    Sleep    2s    #เนื่องจากหน้าโหลดช้า
    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="btn_register"]
    AppiumLibrary.Click Element    xpath=//android.widget.Button[@resource-id="btn_register"]
    #OTP
    Wait Until Element Is Visible    xpath=//*[@resource-id='otp1']    1m
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp1']    ${OTPNumber}[0]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp2']    ${OTPNumber}[1]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp3']    ${OTPNumber}[2]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp4']    ${OTPNumber}[3]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp5']    ${OTPNumber}[4]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='otp6']    ${OTPNumber}[5]
    Wait Until Element Is Visible    xpath=//*[@resource-id='btn_check_otp']
    AppiumLibrary.Click Element    xpath=//*[@resource-id='btn_check_otp']

mSetPinAndConfirmPIN
    [Arguments]    ${PIN}
    Sleep    3s
    AppiumLibrary.Wait Until Element Is Visible    //android.widget.TextView[@resource-id="register_set_pin"]    1m
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[0]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[1]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[2]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[3]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[4]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[5]']
    AppiumLibrary.Wait Until Element Is Visible    //android.widget.TextView[@resource-id="register_confirm_pin"]    1m
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[0]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[1]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[2]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[3]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[4]']
    AppiumLibrary.Click Element    //android.view.View[@resource-id="register_numbers"]/*/*/*[@text='${PIN}[5]']

mClickCoordinates
    [Arguments]    ${locator}
    Sleep    5s
    ${bounds}    Get Element Attribute    ${locator}    bounds
    ${bounds}    Replace String    ${bounds}    ][    ,
    ${bounds}    Replace String    ${bounds}    [    ${EMPTY}
    ${bounds}    Replace String    ${bounds}    ]    ${EMPTY}
    ${bounds}    Split String    ${bounds}    ,
    ${x_bounds}    Evaluate    (${bounds}[2]-${bounds}[0])/2
    ${x_bounds}    Evaluate    ${bounds}[0]+${x_bounds}
    ${y_bounds}    Evaluate    (${bounds}[3]-${bounds}[1])/2
    ${y_bounds}    Evaluate    ${bounds}[1]+${y_bounds}
    AppiumLibrary.Click Element At Coordinates    ${x_bounds}    ${y_bounds}

mSwipeUp
    [Arguments]    ${locator}
    Log    ${locator}
    FOR    ${i}    IN RANGE    99
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    1
        Log    ${status}
        Exit For Loop If    "${status}"=="True"
        Swipe    500    1300    500    1000
    END

mInputEmailAndOtp
    [Arguments]    ${mail}    ${OTP}
    #Input Email
    mClickWebElement    xpath=//android.widget.EditText[@resource-id='input_email']
    mInputText    xpath=//*[@resource-id='input_verify_email']    ${mail}
    AppiumLibrary.Click Element    xpath=//*[@resource-id='btn_verify_email']
    #Set OTP Email
    Wait Until Element Is Visible    xpath=//*[@resource-id='verify_otp1']    1m
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp1']    ${OTP}[0]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp2']    ${OTP}[1]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp3']    ${OTP}[2]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp4']    ${OTP}[3]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp5']    ${OTP}[4]
    AppiumLibrary.Input Text    xpath=//*[@resource-id='verify_otp6']    ${OTP}[5]
    AppiumLibrary.Click Element    xpath=//*[@resource-id='btn_verify_email_confirm']
    Wait Until Element Is Visible    xpath=//*[@resource-id='signup_reterm_checked']
    mClickCoordinates    xpath=//*[@resource-id='signup_reterm_checked']
    mClickCoordinates    xpath=//*[@resource-id="text_under_iframe_home_page"]/*/*/*[@index="0"]/*[@resource-id="register_check_box_tc"]
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="btn_term_agree"]
    mClickCoordinates    xpath=//android.widget.Button[@resource-id="btn_term_agree"]

mGetExpectedCoreLanguage
    [Arguments]    ${LANGUAGE}    ${KeyCoreLanguage}
    [Documentation]    *Description*
    ...    Keyword ไว้สำหรับเช็คค่า Expected ที่ดึงจาก API
    ...
    ...    *Format keyword*
    ...    | ${LANGUAGE} | ${KeyCoreLanguage} |
    ...
    ...
    ...    *Example keyword*
    ...    | mGetExpectedCoreLanguage | ${LANGUAGE} | ${KeyCoreLanguage} |
    ${LANGUAGELower}    Convert To Lowercase    ${LANGUAGE}
    Create Session    List    url=https://cdn.adldigitalservice.com/contents/core/language/system_language_mapping.json?version=1.0.96
    ${response}    GET On Session    List    url=https://cdn.adldigitalservice.com/contents/core/language/system_language_mapping.json?version=1.0.96
    ${TextLanguage}    JsonValidator.Get Elements    ${response.json()}    $.${LANGUAGELower}
    log    ${TextLanguage[0]['${KeyCoreLanguage}']}
    ${Text}    Set Variable    ${TextLanguage[0]['${KeyCoreLanguage}']}
    [Return]    ${Text}

mCheckFormatBahtwithUnit
    [Arguments]    ${locator}
    ${KeyIDisVisible}    Run Keyword And Return Status    Wait For Element    ${locator}    10
    ${amount}    Run Keyword If    '${KeyIDisVisible}'=='True'    Get Element Text    ${locator}
    ${pattern}    Set Variable    ([0-9]{0,3},)?([0-9]{1,3}).([0-9]{2})
    ${clean_amount}    Run Keyword If    '${KeyIDisVisible}'=='True'    Strip String    ${amount}
    Run Keyword If    '${KeyIDisVisible}'=='True'    Should Match Regexp    ${clean_amount}    ${pattern}

mValidatePayBillDetails
    [Documentation]    loop นับจำนวนการ์ด บิลหมายเลขโทรศัพท์
    #Loop Card Paybill
    Set Global Variable    ${j}    0
    FOR    ${j}    IN RANGE    99
        Comment    Log    billAndPayPayMyBill/allBill/chmCardPayBill/${j}
        ${KeyIDVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}    20
        Run Keyword If    '${KeyIDVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Scroll To Element    billAndPayPayMyBill/allBill/chmCardPayBill/${j}/sectionUser/chmAvatar
        ...    AND    CheckCardPayBill
        Exit For Loop If    '${KeyIDVisible}'=='False'
        ${j}    Evaluate    ${j}+1
        Set Global Variable    ${j}
        Set Global Variable    ${i}    0
    END

mValidatePayBills
    [Documentation]    mValidatePayBills \ ตรวจสอบรายละเอียดหน้าจ่ายบิลของฉัน
    ...
    ...    Example
    ...    | mValidatePayBills |
    #Pop up Detect
    ${PopupisVisible}    Run Keyword And Return Status    Wait For Element    ${PackageTariffTLblPopUpPayBillButton}    10
    Run Keyword If    '${PopupisVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    ${PackageTariffTLblPopUpPayBillButton}
    ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
    #IF card Paybill Doesnt Visible Refresh Page
    ${count}    Set Variable    0
    FOR    ${count}    IN RANGE    3
        ${KeyIDVisible}    Run Keyword And Return Status    Wait For Element    billAndPayPayMyBill/allBill/chmCardPayBill/0
        Exit For Loop If    '${KeyIDVisible}'=='True'
        Run Keyword If    '${KeyIDVisible}'=='False'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        Run Keyword If    '${KeyIDVisible}'=='False' and '${PopupisVisible}'=='True'    Run Keywords    AppiumFlutterLibrary.Click Element    billAndPayPayMyBill/headerNavigation/chmIcon
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTLblPopUpPayBillButton}
        ...    AND    AppiumFlutterLibrary.Click Element    ${PackageTariffTBtnPayBill}
        ${count}    Evaluate    ${count}+1
        Run Keyword If    '${count}'=>3    Fail
    END
    #Validate Header
    Comment    Wait For Element    billAndPayPayMyBill/headerNavigation/headerText    #${PaymentLblAmountToPayRequestTextTopic}    PayBillHeader
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_header_pay_bill
    Log    ${ExpectedText}
    mValidateTextFlutter    ${HeaderMenuTitlePaybill}    ${ExpectedText}
    #Validate Bill History
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    billing_tab_bill_history
    Log    ${ExpectedText}
    mValidateTextFlutter    ${HeaderMenubtnBillHistory}    ${ExpectedText}
    #Check Icon Bill History btn Visible
    Wait For Element    ${HeaderMenuiconBillHistory}    #iconBillHistory
    #Validate Tab My Bills
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_tab_my_bills
    Log    ${ExpectedText}
    mValidateTextFlutter    ${PaymentBtnMyBill}    ${ExpectedText}
    #Validate Tab Pay For Other
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_tab_pay_for_other
    Log    ${ExpectedText}
    mValidateTextFlutter    ${PaymentBtnPayForOther}    ${ExpectedText}
    #Validate Pay Bill Contents
    mValidatePayBillDetails
    #ButtonSheet
    #Total Text
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    billing_title_balance
    Log    ${ExpectedText}
    mValidateTextFlutter    billAndPayPayMyBill/stickyButtonAmountToPay/chmContentDisplay/headingText    ${ExpectedText}    30
    Wait For Element    ${PaymentLblTotalTextDetail}    10
    ${amount}    Get Element Text    ${PaymentLblAmountTextDetail}
    ${pattern}    Set Variable    ^([0-9]{0,3},)?([0-9]{1,3}).([0-9]{2})
    ${clean_amount}    Strip String    ${amount}
    Should Match Regexp    ${clean_amount}    ${pattern}
    #Button Pay Bill
    Wait For Element    ${PaymentBtnPayBill}    10
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_button_pay_bill
    Log    ${ExpectedText}
    mValidateTextFlutter    billAndPayPayMyBill/stickyButtonAmountToPay/chmButtonSet/chmButtoon/primary/textButton    ${ExpectedText}    30    #null/stickyButtonAmountToPay/chmButtonSet/chmButtoon/primary/textButton
    #Button Condition
    Wait For Element    ${PaymentImgTermAndConditionicon}    10
    Comment    Wait For Element    ${PaymentBtnTermAnnCondition}    10
    ${ExpectedText}    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_bottom_term_condition
    Log    ${ExpectedText}
    mValidateTextFlutter    ${PaymentLblTermAndConditionTextTopic}    ${ExpectedText}

mValidatewithCoreLang
    [Arguments]    ${locator}    ${locatorCoreLanguage}
    [Documentation]    *Description*
    ...    Keyword ไว้สำหรับเช็คค่า Expected ที่ดึงจาก CoreLang และนำมาเช็คกับ Actual ที่ Get มาจากใน App
    ...
    ...    *Format keyword*
    ...    | ${LocatorActual} | ${LocatorCoreLanguage} |
    ...
    ...
    ...    *Example keyword*
    ...    | mValidatewithCoreLang | ${LocatorActual} | ${LocatorCoreLanguage} |
    ${ExpectedEqual}    mGetText    ${locator}
    ${GetTextValue}    mGetExpectedCoreLanguage    ${LANGUAGE}    ${locatorCoreLanguage}
    ${clean_ExpectedEqual}    Strip String    ${ExpectedEqual}
    ${StatusEqual}    Run Keyword And Return Status    Should Be Equal    ${GetTextValue}    ${clean_ExpectedEqual}
    Run Keyword If    '${StatusEqual}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>text should be    ${ExpectedEqual} but is ${GetTextValue}

CheckStatusPhoneNum
    [Arguments]    ${Phone}    ${StatusExpected}
    [Documentation]    ใส่เบอร์เพื่อเช็ค สเตตัส ของเบอร์
    ...    | Phone Number | Expected |
    ...
    ...    Example
    ...    | 0934000831 | active |
    ...
    ...    | Status | Mongo Name |
    ...    | Active | active |
    ...    | Suspend - barredRequest | barredReques t |
    ...    | Suspend - Credit Limit | creditLimitted |
    ...    | Suspend - Debt | suspendDebt |
    ...    | Suspend - Fraud | suspendFraud |
    ${Output}    Get Data Sort From Database    product    product    {"productCharacteristic": {"$elemMatch": {"name": "number", "value": "${Phone}"}}}    status    10    sortOrder    asc
    log    ${Output[0]['status']}
    Should Be Equal    ${Output[0]['status']}    ${StatusExpected}

mLoginNativeAndClose
    [Arguments]    ${MobileNumberOrEmail}    ${PIN}
    #Open Application
    FOR    ${i}    IN RANGE    3
        mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Native    false    false
        ${StatusLoadingScreen}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/*/*[ends-with(@content-desc,'%')] | //android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/android.view.View[@index="0"]    20s
        Exit For Loop If    "${StatusLoadingScreen}"=="True"
        Run Keyword If    "${StatusLoadingScreen}"=="False"    AppiumLibrary.Close All Applications
        Run Keyword If    "${i}"=="2"    Fail    Failed Browser Stack
    END
    #Select Language and Skip Permission
    FOR    ${i}    IN RANGE    200
        ${StatusSelectLanguageScreen}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    2s
        ${StatusRetryButton}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]    2s
        Run Keyword If    "${StatusSelectLanguageScreen}"=="False" and "${StatusRetryButton}"=="True"    mClickWebElement    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]
        Exit For Loop If    "${StatusSelectLanguageScreen}"=="True" and "${StatusRetryButton}"=="False"
        Run Keyword If    "${i}"=="199"    Fail    Failed Loading Screen / Transaction Screen
    END
    mSelectLanguage
    #Login
    Comment    mWaitUntilElement    xpath=//android.widget.EditText[@resource-id="username"]    20s
    mInputPhoneNumberAndPin    ${MobileNumberOrEmail}    ${PIN}
    #Set Variable
    Set Global Variable    ${LoginStatus}    Success
    AppiumLibrary.Capture Page Screenshot
    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    1m
    #Close Application    AppiumLibrary.Close Application
    [Teardown]    AppiumLibrary.Close Application

Get Data From Database
    [Arguments]    ${DBName}    ${CollectionName}    ${Input}    ${Fields}
    [Documentation]    input = selectStatement, row
    ...
    ...    selectStatement : Required. \ Uses the input `selectStatement` to query for the values
    ...
    ...    row : Optional. Default = 1
    ...
    ...    *Example*
    ...
    ...    input = select APPLICATION_NAME from APPLICATION
    ...
    ...    query data in database which row=1
    ...
    ...    input = select APPLICATION_NAME from APPLICATION, 5
    ...
    ...    query data in database which row=5
    ...
    ...    *Create By #by Numhorm*
    ${MDBDB} =    Set Variable    ${DBName}
    Connect To MongoDB    mongodb+srv://sid-qa-user:fVg7nY1Bph78XWtH@sid-information-azure-s.q03bu.mongodb.net/
    ${MDBColl} =    Set Variable    ${CollectionName}
    ${resultQuery}    Retrieve Mongodb Records With Desired Fields    ${MDBDB}    ${MDBColl}    ${Input}    ${Fields}    True    True
    log    ${resultQuery}
    Disconnect From Mongodb    # disconnects from current connection to the MongoDB server
    LogMany    ${resultQuery}
    Return From Keyword    ${resultQuery}

Get Data Sort From Database
    [Arguments]    ${DBName}    ${CollectionName}    ${Query}    ${Fields}    ${recordLimit}    ${sortParameter}    ${sortType}
    [Documentation]    *Keyword :* Get Data Sort From Database
    ...
    ...    Get Data Sort From Database | ${DBName} | ${CollectionName} | ${Query} | ${Fields} | ${recordLimit} | ${sortParameter} | ${sortType}
    ...
    ...    *Example :*
    ...    Get Data Sort From Database |${DBNAME_IOT_PRODUCT}| products.categories|{}|categoryName|${Total}|sortOrder|asc
    ...
    ...
    ...    Create By : Ging
    ${MDBDB} =    Set Variable    ${DBName}
    Connect To MongoDB    mongodb+srv://sid-qa-user:fVg7nY1Bph78XWtH@sid-information-azure-s.q03bu.mongodb.net/
    ${MDBColl} =    Set Variable    ${CollectionName}
    ${result}    Retrieve All Mongodb Records Limit Sort    ${MDBDB}    ${MDBColl}    ${Query}    ${Fields}    ${recordLimit}    ${sortParameter}    ${sortType}    true
    LogMany    ${result}
    Return From Keyword    ${result}

mGetCurrentDate
    ${CurrentDate}    Get Current Date    UTC    +7
    [Return]    ${CurrentDate}

mConvertToTimestamp
    [Arguments]    ${Date}
    # Convert Date to Timestamp
    ${months}=    Create Dictionary    Jan=01    Feb=02    Mar=03    Apr=04    May=05    Jun=0    Jul=07    Aug=08    Sep=09    Oct=10    Nov=11    Dec=12    ม.ค.=01    ก.พ.=02    มี.ค.=03
    ...    เม.ย.=04    พ.ค.=05    มิ.ย.=06    ก.ค.=07    ส.ค.=08    ก.ย.=09    ต.ค.=10    พ.ย.=11    ธ.ค.=12
    ${Date}    Split String    ${Date}
    ${month_number}=    Get From Dictionary    ${months}    ${Date}[1]
    ${Year}    Run Keyword If    '${LANGUAGE}'=='TH'    Evaluate    ${Date}[2]-543
    ...    ELSE    Set Variable    ${Date}[2]
    ${ActuralDate}    Set Variable    ${Date}[0]-${month_number}-${Year}
    ${ActuralDate}    Convert Date    ${ActuralDate}    result_format=%Y-%m-%d    date_format=%d-%m-%Y
    log    ${ActuralDate}
    Comment    ${ActuralDate}    Run Keyword If    '${LANGUAGE}'=='TH'    Split String    ${ActuralDate}
    Comment    ${Year}    Run Keyword If    '${LANGUAGE}'=='TH'    Evaluate    ${Year}+543
    Comment    ${ActuralDate}    Run Keyword If    '${LANGUAGE}'=='TH'    Set Variable    ${Date}[0]-${month_number}-${Year}
    Comment    ${ActuralDate}    Run Keyword If    '${LANGUAGE}'=='TH'    Convert Date    ${ActuralDate}    result_format=%Y-%m-%d    date_format=%d-%m-%Y
    Comment    Run Keyword If    '${LANGUAGE}'=='TH'    log    ${ActuralDate}
    [Return]    ${ActuralDate}

>>>>>>> feature/tine
    Comment    ${OverDue}    Run Keyword If    '${status}'=='True'    Remove String    ${OverDue}    (    )
    Comment    log    ${OverDue}
    Comment    ${OverdueExpected}    Run Keyword If    '${status}'=='True'    mGetExpectedCoreLanguage    ${LANGUAGE}    payment_outstanding_label_overdue
    Comment    Run Keyword If    '${status}'=='True'    Should Be Equal    ${OverDue}    ${OverdueExpected}

mCaptureAppium
    ${CurrentDate}    Get Current Date    result_format=%d%m%Y
    ${current_time}    Get Current Date    result_format=%H-%M-%S
    log    ${current_time}
    AppiumLibrary.Capture Page Screenshot    appium-screenshot-${CurrentDate}_${current_time}.png

mInputPhoneNumberAndPinForPord
    [Arguments]    ${PhoneNumber}    ${PinNumber}
    mWaitUntilElement    xpath=//android.widget.EditText[@index="1"]    30s
    Comment    Run Keyword If    Wait Until Element Is Visible    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    AppiumLibrary.Click Element    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]
    ...    ELSE    AppiumLibrary.Input Text    xpath=//android.widget.EditText[@resource-id="username"]    ${PhoneNumber}
    ${StatusX}    Run Keyword And Return Status    mWaitUntilElement    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    Run Keyword If    '${StatusX}'=='True'    mClickWebElement    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    mClickWebElement    xpath=//android.widget.EditText[@index="1"]    30s
    mInputText    xpath=//android.widget.EditText[@index="1"]    ${PhoneNumber}
    Sleep    2s    #เนื่องจากหน้าโหลดช้า
    Comment    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="btn_register"]
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index="0"]
    #Xpath login by this email    xpath=//android.view.View[@resource-id='login_fbb_id']/android.widget.Button[@index='0']
    #Check button login by this email
    #Check button login by this email
    FOR    ${i}    IN RANGE    10
        ${StatusPin}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    1s
        ${StatusLoginByEmail}    Run Keyword If    '${StatusPin}'=='False'    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    Sleep    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']
        Exit For Loop If    '${StatusPin}'=='True'
    END
    #PIN    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]
    Comment    AppiumLibrary.Wait Until Element Is Visible    //android.view.View[@resource-id="login_numbers"]/*/*/*[@text="${PinNumber}[0]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    30s
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[1]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[2]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[3]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[4]"]
    mClickWebElement    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[5]"]
    [Teardown]    mCaptureAppium

mSelectLanguageForPord
    #WAit
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']    30s
    mWaitUntilElement    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    30s
    #Select Language on Radio Button
    # Run Keyword If    '${LANGUAGE}'=='TH'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="0"]
    # Run Keyword If    '${LANGUAGE}'=='EN'    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="1"]
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="1"]
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    Comment    sleep    1s
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']/*    10s
    #Click Button 'Continue'
    Comment    Wait Until Element Is Visible    xpath=//android.view.View[@index='5']
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View[@index='5']
    Comment    sleep    1s
    mWaitUntilElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']    10s
    mClickWebElement    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']
    #Allow Permission Notification and Location
    Sleep    3s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    FOR    ${i}    IN RANGE    2
        ${StatusEnable}    Run Keyword And Return Status    mWaitUntilElement    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]    10s
        Run Keyword If    '${StatusEnable}'=='True'    Run Keywords    mClickWebElement    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]
        ...    AND    mAllowPermission
        Exit For Loop If    "${StatusEnable}"=="False"
    END
    #Redirect to Login Screen
    FOR    ${i}    IN RANGE    20
        ${StatusUsername}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.EditText[@index="1"]    2s
        Exit For Loop If    "${StatusUsername}"=="True"
    END
    Sleep    1s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    #Click 'เข้าสู่หน้าหลัก'
    Comment    mClickWebElement    xpath=//android.view.View[@resource-id='formRegister']/android.widget.Button
    Comment    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    30s
    [Teardown]    mCaptureAppium

mValidateNotEmpty
    [Arguments]    ${Locator}
    ${CardTextDetailMyPackage_Actual}    mGetText    ${Locator}
    ${StatusEqual}    Run Keyword And Return Status    Should Not Be Empty    ${CardTextDetailMyPackage_Actual}
    Run Keyword If    '${StatusEqual}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>text should be ค่าเป็นค่าว่าง}

mLoginswitch
    [Arguments]    ${MobileNumberOrEmail}    ${PIN}
    #Open Application    ${MobileNumberOrEmail}
    FOR    ${i}    IN RANGE    3
        mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Flutter    false    false
        TineAutomationToolkit.Native Switch Mode    NATIVE_APP
        ${StatusLoadingScreen}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/*/*[ends-with(@content-desc,'%')] | //android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/android.view.View[@index="0"]    20s
        Exit For Loop If    "${StatusLoadingScreen}"=="True"
        Run Keyword If    "${StatusLoadingScreen}"=="False"    TineAutomationToolkit.Native Close Application Session
        Run Keyword If    "${i}"=="2"    Fail    Failed Browser Stack
    END
    #Select Language and Skip Permission
    FOR    ${i}    IN RANGE    200
        ${StatusSelectLanguageScreen}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    2s
        ${StatusRetryButton}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]    2s
        Run Keyword If    "${StatusSelectLanguageScreen}"=="False" and "${StatusRetryButton}"=="True"    TineAutomationToolkit.Native Click Element    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]
        Exit For Loop If    "${StatusSelectLanguageScreen}"=="True" and "${StatusRetryButton}"=="False"
        Run Keyword If    "${i}"=="199"    Fail    Failed Loading Screen / Transaction Screen
    END
    #Select Language
    mSelectLanguageWithSwitchMode
    #Input Phone number
    mInputPhoneNumberandPINSwitchMode    ${MobileNumberOrEmail}    ${PIN}
    #Set Variable
    Set Global Variable    ${LoginStatus}    Success
    Comment    AppiumLibrary.Capture Page Screenshot
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    5m
    #Close Application    AppiumLibrary.Close Application
    #switch mode to Flutter
    TineAutomationToolkit.Native Switch Mode    FLUTTER
    [Teardown]

mSelectLanguageWithSwitchMode
    #WAit
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']    30s
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']    30s
    #Select Language on Radio Button
    Run Keyword If    '${LANGUAGE}'=='TH'    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="0"]
    Run Keyword If    '${LANGUAGE}'=='EN'    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*/*/*[@index="1"]
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='3']
    Comment    sleep    1s
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='0']/*    10s
    #Click Button 'Continue'
    Comment    Wait Until Element Is Visible    xpath=//android.view.View[@index='5']
    Comment    AppiumLibrary.Click Element    xpath=//android.view.View[@index='5']
    Comment    sleep    1s
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']    10s
    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/*/*/*/*/*[@index='6']
    #Allow Permission Notification and Location
    Sleep    3s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    FOR    ${i}    IN RANGE    2
        ${StatusEnable}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]    10s
        Run Keyword If    '${StatusEnable}'=='True'    Run Keywords    TineAutomationToolkit.Native Click Element    xpath=//*[@resource-id="android:id/content"]/*/*/*/*/*[@index="2" and starts-with(@content-desc,"Enable") or @index="2" and starts-with(@content-desc,"เปิด")]
        ...    AND    mAllowPermissionWithSwicthMode
        Exit For Loop If    "${StatusEnable}"=="False"
        Sleep    1s
    END
    #Redirect to Login Screen
    FOR    ${i}    IN RANGE    20
        ${StatusUsername}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.EditText[@index="1"]    2s
        Exit For Loop If    "${StatusUsername}"=="True"
    END
    Sleep    1s    #เนื่องจากมีแถบ DOM หน้าแดงขึ้นมาดักก่อนแสดงผล
    #Click 'เข้าสู่หน้าหลัก'
    Comment    mClickWebElement    xpath=//android.view.View[@resource-id='formRegister']/android.widget.Button
    Comment    mWaitUntilElement    xpath=//android.view.View/android.view.View/android.view.View/android.widget.ImageView[@index="6"]    30s
    #mCaptureAppium
    [Teardown]    TineAutomationToolkit.Native Capture Page Screenshot

mAllowPermissionWithSwicthMode
    ${Status}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.Button[contains(@resource-id,'allow_button') or contains(@resource-id,'allow_foreground')]
    Run Keyword If    '${Status}'=='True'    TineAutomationToolkit.Native Click Element    xpath=//android.widget.Button[contains(@resource-id,'allow_button') or contains(@resource-id,'allow_foreground')]

mInputPhoneNumberandPINSwitchMode
    [Arguments]    ${PhoneNumber}    ${PinNumber}
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.EditText[@index="1"]    30s
    Comment    Run Keyword If    Wait Until Element Is Visible    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    AppiumLibrary.Click Element    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]
    ...    ELSE    AppiumLibrary.Input Text    xpath=//android.widget.EditText[@resource-id="username"]    ${PhoneNumber}
    ${StatusX}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    Run Keyword If    '${StatusX}'=='True'    TineAutomationToolkit.Native Click Element    xpath=//android.widget.Image[@resource-id="icon_reset_field_name"]    2s
    TineAutomationToolkit.Native Click Element    xpath=//android.widget.EditText[@index="1"]
    TineAutomationToolkit.Native Input Text    xpath=//android.widget.EditText[@index="1"]    ${PhoneNumber}
    Sleep    2s    #เนื่องจากหน้าโหลดช้า
    Comment    AppiumLibrary.Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="btn_register"]
    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index="0"]
    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index="0"]
    #Xpath login by this email    xpath=//android.view.View[@resource-id='login_fbb_id']/android.widget.Button[@index='0']
    #Check button login by this email
    FOR    ${i}    IN RANGE    10
        ${StatusPin}    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    1s
        ${StatusLoginByEmail}    Run Keyword If    '${StatusPin}'=='False'    Run Keyword And Return Status    TineAutomationToolkit.Native Wait Element Is Visible    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    Sleep    1s
        Run Keyword If    '${StatusLoginByEmail}'=='True'    TineAutomationToolkit.Native Click Element    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/android.widget.Button[@index='0']
        Exit For Loop If    '${StatusPin}'=='True'
    END
    #PIN    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]
    Comment    AppiumLibrary.Wait Until Element Is Visible    //android.view.View[@resource-id="login_numbers"]/*/*/*[@text="${PinNumber}[0]"]
    TineAutomationToolkit.Native Wait Element Is Visible    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]    30s
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[0]"]
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[1]"]
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[2]"]
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[3]"]
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[4]"]
    TineAutomationToolkit.Native Click Element    //android.widget.FrameLayout[@resource-id="android:id/content"]/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*[@text="${PinNumber}[5]"]
    #mCaptureAppium
    [Teardown]    TineAutomationToolkit.Native Capture Page Screenshot

