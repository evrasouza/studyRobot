*** Settings ***
Library         Browser
Library         Collections
Resource        ../keywords/quote_keywords.robot
Resource        ../resources/variables.robot

Suite Setup     New Browser    chromium    headless=False
Suite Teardown  Close Browser
Test Setup      Setup Test
Test Teardown   Close Context

*** Test Cases ***
Verify cookie and lead generation pop-ups on brand website
    #Given the user navigates to the brand website
    Given The user accesses the site with its respective data
    #Wait For Elements State    xpath=//iframe[contains(@title, "Newsletter")]    visible    timeout=10s
    Wait For Elements State    .modal-content    visible    timeout=60s
    #Wait Until Element Is Visible    .modal-content    timeout=60s
    #When the page loads
    #Then the cookie pop-up should be displayed
    #And the lead generation pop-up should be displayed
