*** Settings ***
Documentation        Tests to validate the request a quote form
Library              Browser

Resource             ../resources/common_keywords.resource
Resource             ../resources/BDD.resource


*** Variables ***
${MODEL_CANAMOFF}   css=.productgrid.list section div ul > li:first-child > a
${MODEL_SEADOO}     css=#root > div > div > div:nth-child(5) > section > div > ul > li:nth-child(1) > a
${MODEL_SKIDOO}     css=#root > div > div > div:nth-child(4) > section > div > ul > li:nth-child(1) > a
${MODEL_LYNX}       css=#root > div > div > div.productgrid.list.aem-GridColumn.aem-GridColumn--default--12 > section > div > ul > li:nth-child(1) > a

*** Test Cases ***
Scenario Outline 01 - The user sends the form with the selected consents
    [Template]    Scenario Outline 01 - The user sends the form with the selected consents
    #BRAND        #COUNTRY        #LANGUAGE         #MARCA
    ${CANAMOFF}   ${COUNTRY}      ${LANGUAGE}       CANAMOFF
    ${SEADOO}     ${COUNTRY}      ${LANGUAGE}       SEADOO
    ${SKIDOO}     ${COUNTRY}      ${LANGUAGE}       SKIDOO
    ${LYNX}       ${COUNTRY}      ${LANGUAGE}       LYNX

***Keywords***
Scenario Outline 01 - The user sends the form with the selected consents
    [Arguments]    ${BRAND}    ${COUNTRY}    ${LANGUAGE}    ${MARCA}
    GIVEN the user has accessed the website default    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    Click    css=#navbarSupportedContent > ul > li:nth-child(1)
    ${object_css}=      Get Objeto por marca    ${MARCA}
    Click     ${object_css}
    ${URL_URL}        Get Url
    [Teardown]    Close Browser

Get Objeto por marca
    [Arguments]     ${MARCA}
    ${object_css}=      Set Variable If
    ...     '${MARCA}' == 'CANAMOFF'      ${MODEL_CANAMOFF}
    ...     '${MARCA}' == 'SEADOO'      ${MODEL_SEADOO}
    ...     '${MARCA}' == 'SKIDOO'      ${MODEL_SKIDOO}
    ...     '${MARCA}' == 'LYNX'      ${MODEL_LYNX}
    Should Not Be Empty      ${object_css}   Marca inválida: ${MARCA}
    RETURN        ${object_css}