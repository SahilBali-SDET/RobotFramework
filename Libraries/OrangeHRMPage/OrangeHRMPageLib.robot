*** Settings ***
Library    SeleniumLibrary
Resource   OrangeHRMPageProps.robot

*** Keywords ***
Verify OrangeHRM Page Is Loaded
    Wait Until Element Is Visible    ${ORANGEHRM_LOGO}
    Wait Until Element Is Visible    ${NAVIGATION_PANEL}
    ${title}=    Get Text    ${HEADER_TITLE}
    Should Be Equal As Strings    ${title}    Dashboard

Navigate To Menu
    [Arguments]    ${menu_name}
    ${menu_items}=    Get WebElements    ${MENU_ITEMS}
    FOR    ${item}    IN    @{menu_items}
        ${item_text}=    Get Text    xpath=.//span
        Run Keyword If    '${item_text}' == '${menu_name}'    Click Element    ${item}
        Exit For Loop If    '${item_text}' == '${menu_name}'
    END

Search Navigation Item
    [Arguments]    ${menu_name}
    Input Text    ${SEARCH_FIELD}    ${menu_name}

Search And Click Navigation Item
    [Arguments]    ${menu_name}
    Search Navigation Item    ${menu_name}
    Navigate To Menu          ${menu_name}

Logout
    Click Element    ${USER_DROPDOWN_TAB}
    Click Link  Logout
