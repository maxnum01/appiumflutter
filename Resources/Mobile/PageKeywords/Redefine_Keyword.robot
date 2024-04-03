*** Settings ***
Resource          ../../../Configuration/Mobile/GlobalConfig/AllResource.robot    #Library    Selenium2Library

*** Keywords ***
mClickElement
    [Arguments]    ${Locator}    ${TimeOut}=60
    Wait For Element    ${Locator}    ${TimeOut}
    AppiumFlutterLibrary.Click Element    ${Locator}

mClickWebElement
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    [Documentation]    *Description*
    ...
    ...    This keyword is for click element.
    ...
    ...
    ...    *Format keyword*
    ...    | mClickWebElement |
    log    ${Locator}
    Comment    Sleep    2s
    ${Result}    BuiltIn.Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    ${Result}    BuiltIn.Run Keyword And Return Status    BuiltIn.Run Keyword If    '${result}'=='False'    AppiumLibrary.Wait Until Page Contains Element    ${Locator}    ${Timeout}
    BuiltIn.Run Keyword If    '${Result}'=='True'    AppiumLibrary.Click Element    ${Locator}
    Comment    Wait Until Keyword Succeeds    5x    1s    AppiumLibrary.Click Element    ${Locator}
    ${ResultAppCrash}    BuiltIn.Run Keyword And Return Status    BuiltIn.Run Keyword If    '${Result}'=='False'    AppiumLibrary.Wait Until Element Is Visible    ${AppMyAISOnScreen}    1s
    BuiltIn.Run Keyword If    '${Result}'=='False' and '${ResultAppCrash}'=='True'    Fail    <font style="color:#FFCC00" size="3">&#9679</font>Application Keep Crashing
    Run Keyword If    '${Result}'=='False' and '${ResultAppCrash}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Element did not appear in 20s
    [Teardown]    mCaptureAppium

mInputText
    [Arguments]    ${Locator}    ${Text}    ${Timeout}=${General_TimeOut}
    [Documentation]    *Description*
    ...
    ...    This keyword is for input text.
    ...
    ...
    ...    *Format keyword*
    ...    | mInputText |
    ${Result}    BuiltIn.Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    BuiltIn.Run Keyword If    '${result}'=='False'    AppiumLibrary.Wait Until Page Contains Element    ${Locator}    ${Timeout}
    AppiumLibrary.Input Text    ${Locator}    ${Text}

mVerifyText
    [Arguments]    ${Locator}    ${Expected}
    [Documentation]    *Description*
    ...
    ...    This keyword is for verify text.
    ...
    ...
    ...    *Format keyword*
    ...    | mVerifyText |
    ${txt}=    AppiumLibrary.Get Text    ${Locator}
    ${ResultText}    BuiltIn.Run Keyword And Return Status    Should Be Equal As Strings    ${txt}    ${Expected}
    Run Keyword If    '${ResultText}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Text not match : ${txt} != ${Expected}
    comment    <b><font size="20" style="color:red">Text not match ${Expected}</front></b>

mGetText
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    [Documentation]    *Description*
    ...
    ...    This keyword is for get text.
    ...
    ...
    ...    *Format keyword*
    ...    | mGetText |
    ${Result}    BuiltIn.Run Keyword And Return Status    Wait For Element    ${Locator}    ${Timeout}
    ${Value}    BuiltIn.Run Keyword If    '${Result}'=='True'    AppiumFlutterLibrary.Get Element Text    ${Locator}
    Comment    ${ResultXpath}    BuiltIn.Run Keyword If    '${Result}'=='True'    BuiltIn.Run Keyword And Return Status    Should Be Equal    ${Value}    ${EMPTY}
    Comment    Run Keyword If    '${result}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Element did not appear in 10s
    Comment    Run Keyword If    '${ResultXpath}'=='True'    Fail    <font style="color:red" size="3">&#9679</font>Xpath not value
    [Return]    ${Value}

mWaitUntilElement
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    [Documentation]    *Description*
    ...
    ...    This keyword is for click element.
    ...
    ...
    ...    *Format keyword*
    ...    | mClickWebElement |
    ${Result}    BuiltIn.Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    ${Result}    BuiltIn.Run Keyword And Return Status    BuiltIn.Run Keyword If    '${Result}'=='False'    AppiumLibrary.Wait Until Page Contains Element    ${Locator}    ${Timeout}
    ${ResultAppCrash}    BuiltIn.Run Keyword And Return Status    BuiltIn.Run Keyword If    '${Result}'=='False'    AppiumLibrary.Wait Until Element Is Visible    ${AppMyAISOnScreen}    1s
    BuiltIn.Run Keyword If    '${Result}'=='False' and '${ResultAppCrash}'=='True'    Fail    <font style="color:#FFCC00" size="3">&#9679</font>Application Keep Crashing
    Run Keyword If    '${Result}'=='False' and '${ResultAppCrash}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Element did not appear in 20s
    [Teardown]    mCaptureAppium

mVerifyTextShouldMatch
    [Arguments]    ${Locator}    ${Expected}
    [Documentation]    *Description*
    ...
    ...    This keyword is for verify text.
    ...
    ...
    ...    *Format keyword*
    ...    | mVerifyText |
    ${ResultText}    BuiltIn.Run Keyword And Return Status    Wait Until Keyword Succeeds    4x    4s    mShouldMatch    ${Locator}    *${Expected}*
    Run Keyword If    '${ResultText}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Text not match : ${txt} != ${Expected}
    comment    *HTML*<b><font size="20" style="color:red">Text not match ${Expected}</front></b>    ${ResultText}

mShouldMatch
    [Arguments]    ${Locator}    ${Expected}
    [Documentation]    *Description*
    ...
    ...    This keyword is for verify specific text.
    ...
    ...
    ...    *Format keyword*
    ...    | ${Locator} | ${Expected} |
    ${txt}    AppiumLibrary.Get Text    ${Locator}
    Set Test Variable    ${txt}
    Should Match    ${txt}    *${Expected}*

wInputWebText
    [Arguments]    ${Locator}    ${Text}    ${Timeout}=${General_TimeOut}
    [Documentation]    input text into text field identified by locator.
    ...
    ...
    ...    *Format keyword*
    ...
    ...    Input Web Text | ${Locator} | ${Text} | ${Timeout}=${General_TimeOut}
    ${result}    BuiltIn.Run Keyword And Return Status    Selenium2Library.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    BuiltIn.Run Keyword If    '${result}'=='False'    Selenium2Library.Wait Until Page Contains Element    ${Locator}    ${Timeout}
    Comment    Selenium2Library.Input Text    ${Locator}    ${Text}
    Wait Until Keyword Succeeds    5x    1s    Selenium2Library.Input Text    ${Locator}    ${Text}

wClickWebButton
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    [Documentation]    Click a button identified by locator.
    ...
    ...    Step in keyword
    ...
    ...    Line 1 : Run keyword "Wait Web Until Page Contains Element" and return status in parameter ${Result}
    ...    Line 2 : Run keyword "Wait Until Element Is Visible" If ${Result}=False
    ...    Line 3 : Click Button ${Locator}
    ...
    ...
    ...    *Format keyword*
    ...
    ...    Click Web Button | ${Locator} | ${Timeout}=${General_TimeOut}
    ${Result}    BuiltIn.Run Keyword And Return Status    Wait Web Until Page Contains Element    ${Locator}    ${Timeout}
    BuiltIn.Run Keyword If    '${result}'=='False'    Selenium2Library.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    Selenium2Library.Click Button    ${Locator}

wClickWebElement
    [Arguments]    ${Locator}    ${Timeout}=${General_TimeOut}
    ${result}    BuiltIn.Run Keyword And Return Status    Selenium2Library.Wait Until Element Is Visible    ${Locator}    ${Timeout}
    BuiltIn.Run Keyword If    '${result}'=='False'    Selenium2Library.Wait Until Page Contains Element    ${Locator}    ${Timeout}
    Wait Until Keyword Succeeds    5x    1s    Selenium2Library.Click Element    ${Locator}
    BuiltIn.Sleep    1s

mClickElementAppium
    [Arguments]    ${Locator}    ${TimeOut}=60
    AppiumLibrary.Wait Until Element Is Visible    ${Locator}    ${TimeOut}
    AppiumLibrary.Click Element    ${Locator}

mCheckFormatBath
    [Arguments]    ${Locator}
    [Documentation]    *Description*
    ...    Keyword ไว้สำหรับเช็ค Format เงิน เช่น 1,234฿
    ...
    ...    *Format keyword*
    ...    | ${Locator} |
    ...
    ...
    ...    *Example keyword*
    ...    | mCheckFormatBath | Locator |
    ${amount}    mGetText    ${Locator}
    ${pattern}    Set Variable    ([0-9]{0,3},)?([0-9]{1,3})+฿$
    ${clean_amount}    Strip String    ${amount}
    ${is_match}    Run Keyword And Return Status    Should Match Regexp    ${clean_amount}    ${pattern}
    log    ${amount}
    log    ${clean_amount}
    Run Keyword If    ${is_match}    Log    ตรงตาม Format ที่กำหนด
    ...    ELSE    Fail    ข้อความไม่ตรงกับ format ที่กำหนด

mValidateTextFlutter
    [Arguments]    ${LocatorEqual}    ${ExpectedEqual}    ${Timeout}=${General_TimeOut}
    ${StatusElement}    BuiltIn.Run Keyword And Return Status    Wait For Element    ${LocatorEqual}    ${Timeout}
    ${GetTextValue}    BuiltIn.Run Keyword If    '${StatusElement}'=='True'    AppiumFlutterLibrary.Get Element Text    ${LocatorEqual}
    ${StatusEqual}    BuiltIn.Run Keyword If    '${StatusElement}'=='True'    BuiltIn.Run Keyword And Return Status    Should Be Equal    ${GetTextValue}    ${ExpectedEqual}
    Run Keyword If    '${StatusElement}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>Element did not appear in 10s
    Run Keyword If    '${StatusEqual}'=='False'    Fail    <font style="color:red" size="3">&#9679</font>text should be ${ExpectedEqual} but is ${GetTextValue}
    [Return]    ${GetTextValue}
