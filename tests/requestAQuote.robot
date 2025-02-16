*** Settings ***

Documentation        Tests to validate the request a quote form
Library              Browser

Resource             ../resources/common_keywords.resource
Resource             ../resources/BDD.resource

*** Test Cases ***
Scenario Outline 01 - The user sends the form with the selected consents
    [Template]    Scenario Outline 01 - The user sends the form with the selected consents
    #BRAND          #COUNTRY        #LANGUAGE
    ${CANAMOFF}     ${COUNTRY}      ${LANGUAGE}
    ${SEADOO}     ${COUNTRY}      ${LANGUAGE}

Scenario Outline 02 - The user sends the form without the selected consents
    [Template]    Scenario Outline 02 - The user sends the form without the selected consents
    #BRAND          #COUNTRY        #LANGUAGE
    ${CANAMOFF}     ${COUNTRY}      ${LANGUAGE}

***Keywords***
Scenario Outline 01 - The user sends the form with the selected consents
    [Arguments]    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    GIVEN the user has accessed the website default    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    WHEN the user navigates to the RAQ form page
    AND the user fills in all required fields with valid details
    #AND the user submits the form
    #THEN the system should display a confirmation page indicating that the form has been successfully submitted

Scenario Outline 02 - The user sends the form without the selected consents
    [Arguments]    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    GIVEN the user has accessed the website default    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    WHEN the user navigates to the RAQ form page
    AND the user fills in all required fields without consent
    #AND the user submits the form
    #THEN the system should display a confirmation page indicating that the form has been successfully submitted

WHEN the user navigates to the RAQ form page
    Click    css=#navbarSupportedContent > ul > li:nth-child(1)
    Click    css=.productgrid.list section div ul > li:first-child > a
    Click    css=.teaser.model-essential .cmp-teaser__action-container a:nth-child(3)
    Click    css=.teaser.model-essential .cmp-teaser__action-container a:nth-child(2)

AND the user fills in all required fields with valid details
    Fill Form
    Check Consents in Forms

AND the user fills in all required fields without consent
    Fill Form

AND the user submits the form
    Click   ${IFRAME} >>> button[id="button1"]

THEN the system should display a confirmation page indicating that the form has been successfully submitted
    Wait Until Keyword Succeeds    10s    1s    Validate title on page
    Get Title               ==    Confirmation
    [Teardown]    Close Browser

Fill Form
    Set Suite Variable        ${IFRAME}     xpath=//*[starts-with(@id, 'lightbox-iframe')]
    Wait For Elements State   ${IFRAME}    Visible    5
    Set Suite Variable        ${FIRST_NAME}    ${IFRAME} >>> input[id="form_input_first_name"]
    Set Suite Variable        ${LAST_NAME}     ${IFRAME} >>> input[id="form_input_last_name"]
    Set Suite Variable        ${EMAIL}         ${IFRAME} >>> input[id="form_input_email"]
    Set Suite Variable        ${COUNTRYCODE}   ${IFRAME} >>> select[id="form_input_country_code"]
    Set Suite Variable        ${PHONE}         ${IFRAME} >>> input[id="form_input_phone"]
    Set Suite Variable        ${COUNTRYFORM}       ${IFRAME} >>> select[id="form_input_custom1"]
    Set Suite Variable        ${ADDRESS}       ${IFRAME} >>> input[id="form_input_custom2"]
    Set Suite Variable        ${CITY}          ${IFRAME} >>> input[id="form_input_custom3"]
    Set Suite Variable        ${PROVINCE}      ${IFRAME} >>> select[id="form_input_custom4"]
    Set Suite Variable        ${POSTALCODE}    ${IFRAME} >>> input[id="form_input_custom5"]

    Fill Text           ${FIRST_NAME}    ${FIRST_NAME_DATA}
    Fill Text           ${LAST_NAME}     ${LAST_NAME_DATA}
    Fill Text           ${EMAIL}         ${EMAIL_DATA}
    Select Options By   ${COUNTRYCODE}   Value      ${COUNTRYCODE_DATA}
    Fill Text           ${PHONE}         ${PHONE_DATA}
    Get Attribute       ${COUNTRYFORM}   disabled
    Fill Text           ${ADDRESS}       ${ADDRESS_DATA}
    Fill Text           ${CITY}          ${CITY_DATA}
    Select Options By   ${PROVINCE}      Value      ${PROVINCE_DATA}
    Fill Text           ${POSTALCODE}    ${POSTALCODE_DATA}

Check Consents in Forms
    Click   ${IFRAME} >>> input[id="form_input_custom19"]
    Click   ${IFRAME} >>> input[id="form_input_custom20"]

Validating URL parameters
    #baseURL
    ${actual_url}        Get Url
    Should Start With   ${actual_url}   ${CANAMOFF}
    Should Contain      ${actual_url}   ${REQUESTAQUOTE}
    Should Contain      ${actual_url}   ${NGCAT}
    Should Contain      ${actual_url}   ${NGMODEL}
    Should Contain      ${actual_url}   ${NGTRIM}
    Should Contain      ${actual_url}   ${NGMSRP}
    Should Contain      ${actual_url}   ${NGCURR}

Validate title on page
    ${texto}=    Get Text    h1[class="cmp-teaser__title"]
    Should Be Equal As Strings    ${texto}    MERCI POUR VOTRE DEMANDE