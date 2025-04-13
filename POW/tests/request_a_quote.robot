*** Settings ***
Library         Browser
Library         Collections
Resource        ../keywords/quote_keywords.robot
Resource        ../resources/commom_variable.robot

Suite Setup     New Browser    chromium    headless=False
Suite Teardown  Close Browser
Test Setup      Setup Test
Test Teardown   Close Context

*** Test Cases ***
User tries to send a request a quote form without filling in the required fields
    Given The user accesses the site with its respective data
    When The user selects a model and year
    And The user clicks the quote button
    And The user tries to submit the quote form without filling in the required fields
    Then Validation messages should appear for each required field
    And The form should not be submitted

User Navigates, Selects Model And Submits Quote Form
    Given The user accesses the site with its respective data
    When The user selects a model and year
    And The user clicks the quote button
    Then The user fills out and submits the quote form