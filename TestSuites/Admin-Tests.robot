*** Settings ***
Library    SeleniumLibrary
Resource   ../Libraries/LoginPage/LoginPageLib.robot
Resource   ../Libraries/AdminPage/AdminPageLib.robot
Resource   ../Libraries/OrangeHRMPage/OrangeHRMPageLib.robot
Resource    ../Libraries/Resource/ResourceLib.robot
Suite Setup    Login And Navigate To Admin
Test Teardown  Go Back To Admin Page    
Suite Teardown    Close Browser Session


*** Keywords ***
Login And Navigate To Admin
    Open Browser With Config
    Login With Credentials    ${USERNAME}    ${PASSWORD}
    Verify OrangeHRM Page Is Loaded
    Search And Click Navigation Item    Admin
    Verify Admin Page Is Loaded

Go Back To Admin Page
    Navigate To Menu    Admin
    Verify Admin Page Is Loaded


*** Test Cases ***
Verify Records Are Updated With Correct Details
    [Tags]    OrangeHRMSuite    AdminPageTest
    Search Employee    ${USERNAME}
    Verify Correct Employee Is Displayed    ${USERNAME}

Verify Records Are Empty If No Records Are Present
    [Tags]    OrangeHRMSuite    AdminPageTest
    Click Reset Button
    Search Employee    123
    Verify Records Table Is Empty
