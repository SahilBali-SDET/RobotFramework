*** Settings ***
Library    SeleniumLibrary
Library    ../Utilities/CustomSeleniumLibrary.py
Resource   LoginPageProps.robot


*** Keywords ***
Enter Username
    [Arguments]    ${username}
    Input Text    ${USERNAME_FIELD}    ${username}

Enter Password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_FIELD}    ${password}

Click Login Button
    Click Button    ${LOGIN_BUTTON}

Click Forgot Password
    Click Element    ${FORGOT_PASSWORD_LINK}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Enter Username    ${username}
    Enter Password    ${password}
    Click Login Button

Verify Invalid Credentials Message Is Displayed
    Element Should Be Visible    ${ALERT_ICON}
    Element Text Should Be    ${ALERT_TEXT}    Invalid credentials
