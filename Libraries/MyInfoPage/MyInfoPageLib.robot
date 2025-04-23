*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    OperatingSystem
Library    ../../venv/Lib/site-packages/robot/libraries/XML.py
Resource   MyInfoPageProps.robot

*** Keywords ***
Verify My Info Page Is Loaded
    Element Should Be Visible    ${EDIT_EMPLOYEE_SECTION}
    Wait Until Element Is Not Visible    ${ATTACHMENT_LOADER}

Upload Attachment
    [Arguments]    ${file_name}    ${dir_name}=Images
    ${path}=    Set Variable    ${CURDIR}/../../TestData/${dir_name}/${file_name}
    ${path}=    Normalize Path    ${path}
    Click Button     ${ADD_ATTACHMENT_BUTTON}
    Choose File      ${ATTACHMENT_INPUT_FIELD}    ${path}
    Click Button     ${UPLOAD_SAVE_BUTTON}
    Wait Until Element Is Not Visible    ${ATTACHMENT_LOADER}

Verify File Is Displayed In Attachment Table
    [Arguments]    ${file_name}
    ${attachments}=    Get WebElements    ${ATTACHMENT_CARDS}
    ${no_of_attachements}=  Get Length    ${attachments}
    ${attachment_names}=    Get WebElements    ${ATTACHMENT_FILENAME}
    ${names}=    Create List
    FOR    ${INDEX}    IN RANGE  ${no_of_attachements}
        ${name}=    Get Text    ${attachment_names}[${INDEX}]
        ${name}=    Split String    ${name}    \n
        Append To List    ${names}    ${name[0]}
    END
    List Should Contain Value    ${names}    ${file_name}

Verify File Is Not Displayed In Attachment Table
    [Arguments]    ${file_name}
    ${attachments}=    Get WebElements    ${ATTACHMENT_CARDS}
    ${no_of_attachements}=  Get Length    ${attachments}
    ${attachment_names}=    Get WebElements    ${ATTACHMENT_FILENAME}
    ${names}=    Create List
    FOR    ${INDEX}    IN RANGE  ${no_of_attachements}
        ${name}=    Get Text    ${attachment_names}[${INDEX}]
        ${name}=    Split String    ${name}    \n
        Append To List    ${names}    ${name[0]}
    END
    List Should Not Contain Value    ${names}    ${file_name}

Delete File From Attachment Table
    [Arguments]    ${file_name}
    ${attachments}=    Get WebElements    ${ATTACHMENT_CARDS}
    ${no_of_attachements}=  Get Length    ${attachments}
    ${attachment_names}=    Get WebElements    ${ATTACHMENT_FILENAME}
    ${delete_buttons}=    Get WebElements    ${DELETE_BUTTON}
    FOR    ${INDEX}    IN RANGE  ${no_of_attachements}
        ${name}=    Get Text    ${attachment_names}[${INDEX}]
        ${name}=    Split String    ${name}    \n
        Run Keyword If    '${file_name}' == '${name[0]}'    Run Keywords
        ...    Click Element    ${delete_buttons}[${INDEX}]
        ...    AND    Click Element    ${CONFIRM_DELETE_BUTTON}
        ...    AND    Wait Until Element Is Not Visible    ${ATTACHMENT_LOADER}
    END
