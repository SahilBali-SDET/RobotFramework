*** Settings ***
Library    SeleniumLibrary
Resource   ../Libraries/LoginPage/LoginPageLib.robot
Resource   ../Libraries/OrangeHRMPage/OrangeHRMPageLib.robot
Resource   ../Libraries/MyInfoPage/MyInfoPageLib.robot
Resource    ../Libraries/Resource/ResourceLib.robot
Suite Setup    Login And Navigate To My Info
Test Teardown  Refresh My Info Page
Suite Teardown    Close Browser Session

*** Variables ***
${FILE_NAME}   ImageAddedByAutomationScript.jfif

*** Keywords ***
Login And Navigate To My Info
    Open Browser With Config
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Verify OrangeHRM Page Is Loaded
    Search And Click Navigation Item    My Info
    Verify My Info Page Is Loaded

Refresh My Info Page
    Reload Page
    Verify My Info Page Is Loaded

*** Test Cases ***
Verify User Is Able To Upload File
    [Tags]    OrangeHRMSuite    MyInfoTest
    Upload Attachment    ${FILE_NAME}
    Verify File Is Displayed In Attachment Table    ${FILE_NAME}

Verify User Is Able To Delete File
    [Tags]    OrangeHRMSuite    MyInfoTest
    Verify File Is Displayed In Attachment Table    ${FILE_NAME}
    Delete File From Attachment Table    ${FILE_NAME}
    Verify File Is Not Displayed In Attachment Table    ${FILE_NAME}
