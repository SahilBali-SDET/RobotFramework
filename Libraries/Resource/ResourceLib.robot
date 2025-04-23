*** Settings ***
Library    SeleniumLibrary
Resource   ResourceProps.robot

*** Keywords ***
Open Browser With Config
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If    '${HEADLESS}'=='True'    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Open Browser    ${BASE_URL}    ${BROWSER_NAME}    options=${options}
    Maximize Browser Window
    Set Selenium Implicit Wait    2s

Close Browser Session
    Close Browser
