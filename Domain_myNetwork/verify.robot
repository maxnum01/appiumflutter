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


*** Test Cases ***
Verify txt selector all หน้าแอพด้วย xpath
    [Documentation]    Test Step
    ...    1. เปิดแอปพลิเคชัน MyAIS
    ...    2. Login ด้วยเบอร์
    ...    3. แสดงหน้า Mynetwork
    ...    4. Verify txt selector all หน้าแอพด้วย xpath
    ...    5. ปิดแอปพลิเคชัน MyAIS
    ...    Expected
    ...
    ...
    FOR    ${i}    IN RANGE    3
        mOpenApplication    ${AppPackagemyAIS}    ${AppActivitymyAIS}    Native    false    false
        ${StatusLoadingScreen}    Run Keyword And Return Status
        ...    mWaitUntilElement
        ...    xpath=//android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/*/*[starts-with(@content-desc,'20')] | //android.widget.FrameLayout[@resource-id='android:id/content']/android.widget.FrameLayout/*/*/android.view.View[@index="0"]
        ...    15s
        mCaptureAppium
        IF    "${StatusLoadingScreen}"=="True"    BREAK

        IF    "${StatusLoadingScreen}"=="False"    Comment    CloseApp
        mCaptureAppium
        IF    "${i}"=="2"    Fail    Failed Browser Stack
    END
    FOR    ${i}    IN RANGE    200
        ${StatusSelectLanguageScreen}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    xpath=//android.view.View[@content-desc='Select language' or @content-desc='เลือกภาษา']
        ...    2s
        ${StatusRetryButton}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible
        ...    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]
        ...    2s
        IF    "${StatusSelectLanguageScreen}"=="False" and "${StatusRetryButton}"=="True"
            mClickWebElement    xpath=//android.view.View[@content-desc="รีเฟรชข้อมูล" or @content-desc="Refresh Page"]
        END
        IF    "${StatusSelectLanguageScreen}"=="True" and "${StatusRetryButton}"=="False"
            BREAK
        END
        IF    "${i}"=="199"    Fail    Failed to Open App After Installed
    END
    mSelectLanguageForPord
    ${MobileNumberOrEmail}    Set Variable    0924309872
    ${PIN}    Set Variable    111111
    mInputPhoneNumberAndPinForPord    ${MobileNumberOrEmail}    ${PIN}
    mClickWebElement    ${permisallowphone}    
    Sleep    22
    VerifyContent-Desc    ${headertitle}    MyNetwork
    mClickWebElement    ${tabfiber}
    Sleep    2
    mClickWebElement    ${tabmobile}
    Sleep    2
    mClickWebElement    ${tabmobile}
    ${back}            Set Variable             xpath=//android.widget.Button[@content-desc="Later"]
    FOR    ${i}    IN RANGE    1    6    
        ${ratestar_xpath}        Set Variable       xpath=//android.widget.ScrollView/android.widget.ImageView[${i + 1}]
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${ratestar_xpath}    timeout=10s
        Run Keyword If    not ${status}    Fail    Element ${ratestar_xpath} not found
        mClickWebElement    ${ratestar_xpath}
        mClickWebElement    ${back}
    END
    VerifyContent-Desc    ${rateinternet}    Rate Internet Quality
    Sleep    2
    Wait Until Element Is Visible    ${performance}
    mClickWebElement    ${performanceicon2}
    Swipe    372  1472    356  582
    VerifyContent-Desc    ${browsing/social}    Browsing / Social
    VerifyContent-Desc    ${live}    Live
    VerifyContent-Desc    ${VDOStreaming}    VDO Streaming
    VerifyContent-Desc    ${Game}    Game
    Sleep    2
    mSwipedownToElement    ${swipedownmode5g}
    VerifyContent-Desc    ${title5GMode}    5G Mode   
    VerifyContent-Desc    ${titlebootmode}    BOOST Mode
    VerifyContent-Desc    ${subtitlebootmode}    For faster performance
    mClickWebElement    ${selectorbootmode}
    Sleep    3
    mClickWebElement    ${backto5GMode}
    Sleep    10
    VerifyContent-Desc    ${titlegamemode}    GAME Mode
    VerifyContent-Desc    ${subtitlegamemode}    For enhanced stability
    mClickWebElement    ${selectorgamemode}
    Sleep    3
    mClickWebElement    ${backto5GMode}
    Sleep    10
    VerifyContent-Desc    ${titlelivemode}    LIVE Mode
    VerifyContent-Desc    ${subtitlelivemode}    For better LIVE Streaming
    mClickWebElement    ${selectorlivemode}
    Sleep    3
    mClickWebElement    ${backto5GMode}
    Sleep    10
    mSwipedownToElement    ${swipedowntermscondi}
    [Teardown]    AppiumLibrary.Close Application