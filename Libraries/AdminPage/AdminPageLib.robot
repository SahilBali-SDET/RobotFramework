*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   AdminPageProps.robot


*** Keywords ***
Verify Admin Page Is Loaded
    Element Should Be Visible    ${SYSTEM_USERS_HEADER}
    Element Should Be Visible    ${ADMIN_USERNAME_FIELD}
    Element Should Be Visible    ${EMPLOYEE_NAME_FIELD}
    Element Should Be Visible    ${USER_ROLE_FIELD}
    Element Should Be Visible    ${STATUS_FIELD}
    Element Should Be Visible    ${RESET_BUTTON}
    Element Should Be Visible    ${SEARCH_BUTTON}
    Element Should Be Visible    ${ADD_BUTTON}

Search Employee
    [Arguments]    ${username}
    Input Text    ${ADMIN_USERNAME_FIELD}    ${username}
    Click Button  ${SEARCH_BUTTON}
    Sleep         5s

Verify Correct Employee Is Displayed
    [Arguments]    ${expected_name}
    ${names}=    Get WebElements    xpath://div[@class='oxd-table-card']//div[@class='oxd-table-cell oxd-padding-cell'][2]//div
    ${found}=    Set Variable    None
    ${expected_name}=    Convert To Lower Case    ${expected_name}
    FOR    ${el}    IN    @{names}
        ${text}=    Get Text    ${el}
        ${text}=    Convert To Lower Case    ${text}
        Log    Comparing: '${text}' with '${expected_name}'
        ${found}    Run Keyword If    '${text}' == '${expected_name}'    Set Variable    True
        ...    ELSE    Set Variable    False
    END
    Should Be Equal    ${found}    True    Employee ${expected_name} is not found in the list

Verify Records Table Is Empty
    ${names}=    Get WebElements    ${EMPLOYEE_NAMES}
    Length Should Be    ${names}    0

Click Reset Button
    Click Button    ${RESET_BUTTON}
