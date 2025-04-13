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