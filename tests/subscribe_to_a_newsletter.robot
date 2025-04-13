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
Attempt to subscribe without filling in required fields
    Given The user accesses the site with its respective data
    When the user sees the newsletter subscription form
    And the user clicks the subscribe button without filling in first name, last name, and email
    Then validation messages should appear for the required fields
    Sleep    10

#Attempt to subscribe without entering the email
    #Given The user accesses the site with its respective data
    #When the user fills in the first name and last name
    #And leaves the email field empty
    #And the user clicks the subscribe button
    #Then a validation message should appear for the email field

#Attempt to subscribe without entering the first name
    #Given The user accesses the site with its respective data
    #When the user fills in the last name and email
    #And leaves the first name field empty
    #And the user clicks the subscribe button
    #Then a validation message should appear for the first name field

#Attempt to subscribe without entering the last name
    #Given The user accesses the site with its respective data
    #When the user fills in the first name and email
    #And leaves the last name field empty
    #And the user clicks the subscribe button
    #Then a validation message should appear for the last name field

#Subscribe to the newsletter using the modal form on homepage
    #Given The user accesses the site with its respective data
    #When the user sees the newsletter subscription modal
    #And the user fills in a valid email address
    #And the user clicks the subscribe button
    #Then a confirmation message should appear

#Subscribe to the newsletter using the footer form
    #Given The user accesses the site with its respective data
    #When the user scrolls to the footer section
    #And the user fills in a valid email address in the newsletter box
    #And the user clicks the subscribe button
    #Then a confirmation message should appear
