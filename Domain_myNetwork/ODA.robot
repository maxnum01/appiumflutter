*** Settings ***
Library         JSONLibrary
Resource        ../../Resources/Mobile/PageKeywords/mCommonKeyword.robot
Resource        ../../Resources/Mobile/PageRepositories/mCommonRepositories.robot    # robotcode: ignore
Resource        key.robot
Library         requests
# Library    MongoDBLibrary
Library         AppiumFlutterLibrary
Library         AppiumLibrary

Suite Setup     Set Library Search Order    AppiumFlutterLibrary
# 0924309872 old
# 0924304928
*** Variables ***
${CONFIGNAME}           Folk
${AppPackagemyAIS}      com.ais.mimo.eservice.inhouse1
${AppActivitymyAIS}     com.adl.mfaf.MainActivity
${eg}    radioButton_chooseLanguage_Eng
${th}   radioButton_chooseLanguage_TH
${my}    radioButton_chooseLanguage_My
${km}    radioButton_chooseLanguage_km
${selelang}   button_continueSelectLanguage
${skip}    button_skip
${conti}    button_continue
${btnNoti}   button_enableNotification
${enableloca}   buttonEnableLocation_button_enableLocation
${skipbotton}   bottomContent_button_skip

*** Test Cases ***
Test term&condition Mynetwork Test Step
    [Documentation]    Test Step
    ...    1. user เปิดแอพใช้งาน
    ...    2. user คลิกเมนูโปรไฟล์ - กดเข้าสู่ระบบ ใส่เบอร์ และ รัหสผ่าน
    ...    3. click ที่เมนูหน้าหลักของเมนู mynetwork
    ...    4. user click let 's get start
    ...    5. user click agree และ กดคลิกเลือก 
    ...    6. click อนุญาตระหว่างใช้งานแอพ
    ...    7. user click ไม่ allow phone
    ...    8. user click "Late"
    mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Native    false    false
    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc="continue"]    59
    mClickWebElement    xpath=//android.view.View[@content-desc="continue"]    
    mClickWebElement    xpath=//android.widget.Button[@content-desc="Skip"]
    mClickWebElement    xpath=//android.view.View[@content-desc="Skip"]
    ${MobileNumberOrEmail}    Set Variable    0924309872
    ${PIN}    Set Variable    111111
    Wait Until Element Is Visible   xpath=//android.widget.EditText    120
    Input Value    xpath=//android.widget.EditText    0924309872
    mClickWebElement    xpath=//android.widget.Button[@text="Continue"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    ${allowphone}    Set Variable    xpath=//android.widget.Button[@index=0]
    ${dontallowphone}    Set Variable    xpath=//android.widget.Button[@index=1]
    mClickWebElement    ${checkbeforeapp}    
    mClickWebElement    ${dontallowphone} 
    Sleep    5
    Swipe    800    1600    0    1600
    mClickWebElement    xpath=//android.view.View[@content-desc="Let’s Get Started!"]
    Sleep    3
    ${btnLateallowphone}    Set Variable    xpath=//android.view.View[@content-desc="Later"]
    ${btnOK}    Set Variable    xpath=//android.view.View[@content-desc="OK"]
    mClickWebElement    ${btnLateallowphone}




    
    
Test term&condition Mynetwork Test Expected Results
    [Documentation]    Expected Results
    ...    1. user เปิดแอพใช้งาน
    ...    2. user คลิกเมนูโปรไฟล์ - กดเข้าสู่ระบบ ใส่เบอร์ และ รัหสผ่าน
    ...    3. click ที่เมนูหน้าหลักของเมนู mynetwork
    ...    4. user click let 's get start
    ...    5. user click agree และ กดคลิกเลือก 
    ...    6. click อนุญาตระหว่างใช้งานแอพ
    ...    7. user click ไม่ allow phone
    ...    8. user click "Late"
    mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Native    false    false
    Wait Until Element Is Visible    xpath=//android.view.View[@content-desc="continue"]    59
    mClickWebElement    xpath=//android.view.View[@content-desc="continue"]    
    mClickWebElement    xpath=//android.widget.Button[@content-desc="Skip"]
    mClickWebElement    xpath=//android.view.View[@content-desc="Skip"]
    ${MobileNumberOrEmail}    Set Variable    0924309872
    ${PIN}    Set Variable    111111
    Wait Until Element Is Visible   xpath=//android.widget.EditText    120
    Input Value    xpath=//android.widget.EditText    0924309872
    mClickWebElement    xpath=//android.widget.Button[@text="Continue"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    mClickWebElement    xpath=//android.widget.Button[@text="1"]
    ${allowphone}    Set Variable    xpath=//android.widget.Button[@index=0]
    ${dontallowphone}    Set Variable    xpath=//android.widget.Button[@index=1]
    mClickWebElement    ${checkbeforeapp}    
    mClickWebElement    ${allowphone} 
    Sleep    5
    Swipe    800    1600    0    1600
    mClickWebElement    xpath=//android.view.View[@content-desc="Let’s Get Started!"]
    Sleep    3
    




    
    