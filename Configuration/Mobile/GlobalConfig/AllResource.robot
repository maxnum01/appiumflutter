*** Settings ***
Library           AppiumFlutterLibrary
Library           AppiumLibrary
Library           Collections
Library           DateTime
Library           Dialogs
Library           JsonValidator
Library           OperatingSystem
Library           Process
Library           RequestsLibrary
Library           String
Library           TineAutomationToolkit
Resource          ../../../Resources/Mobile/PageKeywords/Redefine_Keyword.robot
Resource          ../../../Resources/Mobile/PageKeywords/mCommonKeyword.robot
Resource          ../../../Resources/Mobile/PageKeywords/mLoyaltyKeyword.robot
Resource          ../../../Resources/Mobile/PageKeywords/mPaymentBillingKeyword.robot
Resource          ../../../Resources/Mobile/PageRepositories/mCommonRepositories.robot
Resource          ../../../Resources/Mobile/PageVariables/mCommonPageVariables.robot
Resource          ../../../Resources/Mobile/PageVariables/mLoyaltyPageVariable.robot
Resource          ../../../Resources/Mobile/PageVariables/mPackageTariffPageVariable.robot
Resource          ../../../Resources/Mobile/PageVariables/mPaymentBillingPageVariable.robot
Resource          ../../../Configuration/Mobile/LocalConfig/${CONFIGNAME}.robot
Resource          ../../../Configuration/Mobile/GlobalConfig/${ENV}.robot
Resource          ../../../Resources/Mobile/PageRepositories/mPaymentBillingRepositories.robot
Resource          ../../../Resources/Mobile/PageRepositories/mPackageTariffRepositories.robot
Resource          ../../../Resources/Mobile/PageVariables/mGetExpectedAPI.robot
# Library           MongoDBLibrary

*** Variables ***
${PathLogWindowsOS}    --outputdir C:/RobotFrameworkLogs/%date:~-4,4%%date:~-7,2%%date:~-10,2% --timestampoutputs --variable CONFIGNAME:KUNG
${PathLogMacOS}    --outputdir /Users/RobotFrameworkLogs/`date +%F` --variable CONFIGNAME:KUNG
