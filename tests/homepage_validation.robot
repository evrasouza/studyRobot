*** Settings ***
Library    Browser

*** Variables ***
${BASE_URL}    https://sea-doo.brp.com
@{VALID_COMBINATIONS}    ca:en    ca:fr    br:pt

*** Test Cases ***
Validate Home Page in Valid Languages
    FOR    ${combination}    IN    @{VALID_COMBINATIONS}
        ${country}=    Set Variable    ${combination.split(':')[0]}
        ${lang}=       Set Variable    ${combination.split(':')[1]}
        ${url}=        Set Language URL    ${country}    ${lang}
        Open Browser    ${url}    browser=chromium
        Validate Page Components
        Close Browser
    END

*** Keywords ***
Set Language URL
    [Arguments]    ${country}    ${lang}
    Return From Keyword    ${BASE_URL}/${country}/${lang}/

Validate Page Components
    ${title}=    Get Title
    Should Contain    ${title}    Sea-Doo
    Take Screenshot
