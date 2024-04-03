*** Settings ***
Resource    ../../Configuration/Mobile/GlobalConfig/AllResource.robot


*** Variables ***
# before come app mynetwork

${permisallowphone}             xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_button"]
${checkbeforeapp}               xpath=//android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_foreground_only_button"]

# mynetwork english
${headertitle}                  xpath=//android.view.View[@content-desc="myNetwork"]
${tabmobile}                    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[@index=1]    # content-desc="Mobile\nTab 1 of 2
${tabfiber}                     xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[@index=2]    # content-desc="Fiber Tab 2 of 2
${statusexcellent}              xpath=//android.widget.ImageView[@index=3]    # content-desc="Your Internet Status092-430-9872Excellent
${subtitle}                     xpath=//android.view.View[@content-desc="Internet Quality: ExcellentEnjoy your favorite movies, live streaming, social media, and more, to the fullest."]
${rateinternet}                 xpath=//android.view.View[@content-desc="Rate Internet Quality"]
${subtitlerateinternet}         xpath=//android.view.View[@content-desc="from your experience"]
${ratestar1}                    xpath=//android.widget.ScrollView/android.widget.ImageView[2]
${ratestar2}                    xpath=//android.widget.ScrollView/android.widget.ImageView[3]
${ratestar3}                    xpath=//android.widget.ScrollView/android.widget.ImageView[4]
${ratestar4}                    xpath=//android.widget.ScrollView/android.widget.ImageView[5]
${ratestar5}                    xpath=//android.widget.ScrollView/android.widget.ImageView[6]
${performance}                  xpath=//android.view.View[@index=12]
${performanceicon1}             xpath=//android.view.View[@index=12]/android.widget.ImageView[1]
${performanceicon2}             xpath=//android.view.View[@index=12]/android.widget.ImageView[2]
# ${performanceupdate}    xpath=//android.view.View[@content-desc="PerformanceUpdate Now"]
# ${iconperformanc}    xpath=//android.view.View[@content-desc="PerformanceUpdate1 min"]/android.widget.ImageView[1]
# ${selectorperformance}    xpath=//android.view.View[@content-desc="PerformanceUpdate Now"]/android.widget.ImageView[2]
${browsing/social}              xpath=//android.widget.ImageView[@content-desc="Browsing / Social"]
${live}                         xpath=//android.widget.ImageView[@content-desc="Live"]
${VDOStreaming}                 xpath=//android.widget.ImageView[@content-desc="VDO Streaming"]
${Game}                         xpath=//android.widget.ImageView[@content-desc="Game"]

# 5G Mode

${title5GMode}                  xpath=//android.view.View[@content-desc="5G Mode"]
${titleicon5GMode}              xpath=//android.widget.ScrollView/android.widget.ImageView[1]
${swipedownmode5g}              xpath=//android.view.View[@content-desc="Unable to use 5G Mode"]
${backto5GMode}                 xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View[1]/android.view.View[2]/android.widget.ImageView[1]
# Boot Mode
${titlebootmode}                xpath=//android.view.View[@content-desc="BOOST Mode"]
${subtitlebootmode}             xpath=//android.view.View[@content-desc="For faster performance"]
${selectorbootmode}             xpath=(//android.view.View[@content-desc="Select"])[1]
# Game Mode
${titlegamemode}                xpath=//android.view.View[@content-desc="GAME Mode"]
${subtitlegamemode}             xpath=//android.view.View[@content-desc="For enhanced stability"]
${selectorgamemode}             xpath=(//android.view.View[@content-desc="Select"])[2]
# Live Mode
${titlelivemode}                xpath=//android.view.View[@content-desc="LIVE Mode"]
${subtitlelivemode}             xpath=//android.view.View[@content-desc="For better LIVE Streaming"]
${selectorlivemode}        xpath=(//android.view.View[@content-desc="Select"])[3]
# botton term&con
${swipedowntermscondi}          xpath=//android.widget.ImageView[@content-desc="Terms & Conditions"]
# minaMap
${map}                          xpath=//android.widget.ScrollView/android.view.View[2]
${location}                     xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.ImageView
${AISshop1.51km}                xpath=//android.widget.ImageView[@content-desc="AIS Shop A-Store University of the Thai Chamber of Commerce Directions1.51 km"]
${focuslocationuser}            xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.ImageView[3]
${focuslocation}                xpath=//android.view.View[@content-desc="เครื่องหมายบนแผนที่"]
${AISshopIconbotton}            xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.ImageView[1]
${AISshopbottontitle}           xpath=//android.view.View[@content-desc="AIS Shop A-Store University of the Thai Chamber of Commerce "]
${AISshopbottonminiIcon}        xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.widget.ImageView[2]
${AISshopbottonsubtitle}        xpath=//android.view.View[@content-desc="126/1, Floor , Vibhavadi Rangsit, RATCHADAPHISEK, DIN DAENG, BANGKOK, 10400"]
${AISshopbottonDirections}      xpath=//android.widget.ImageView[@content-desc="Directions"]

${termsconditiondown}           xpath=//android.widget.ImageView[@content-desc="Terms & Conditions"]


*** Keywords ***
VerifyText
    [Arguments]    ${locator}    ${Expected}
    ${txt}=    AppiumLibrary.Get Text    ${locator}
    ${ResultText}=    BuiltIn.Run Keyword And Return Status    Expected txt    ${txt}    ${Expected}
    RETURN    ${ResultText}

VerifyContent-Desc
    [Arguments]    ${locator}    ${expected}
    ${content_desc}=    AppiumLibrary.Get Element Attribute    ${locator}    content-desc
    ${result}=    Evaluate    "${content_desc}"