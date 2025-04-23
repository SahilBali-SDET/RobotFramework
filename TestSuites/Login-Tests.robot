*** Settings ***
Library    SeleniumLibrary
Resource   ../Libraries/LoginPage/LoginPageLib.robot
Resource   ../Libraries/OrangeHRMPage/OrangeHRMPageLib.robot
Resource   ../Libraries/Resource/ResourceProps.robot
Resource    ../Libraries/Resource/ResourceLib.robot
Suite Setup    Open Browser With Config
Suite Teardown    Close Browser Session

*** Test Cases ***
Verify Valid Login
    [Tags]    OrangeHRMSuite    LoginTest
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Verify OrangeHRM Page Is Loaded
    Logout

Verify Invalid Login
    [Tags]    OrangeHRMSuite    LoginTest
    Login With Credentials    random@gmail.com    test
    Verify Invalid Credentials Message Is Displayed
