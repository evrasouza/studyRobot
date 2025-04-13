*** Keywords ***
# Given
The user accesses the site with its respective data
    New Page          ${URL}
    Close Modal If Exists
    Wait For Elements State    css=#root_newsletter-popup .overlay    hidden    10s
    ${title}=         Get Title
    ${brand_data}=  Get From Dictionary    ${brands}    ${BRAND}
    Should Contain    ${title}    ${brand_data["expected_title"]}

# When
The user selects a model and year
    ${brand_data}=  Get From Dictionary    ${brands}    ${BRAND}
    Click Model Menu        ${brand_data["menu_label"]}
    Click Model By Name     ${brand_data["model"]}
    Click                   text=${brand_data["model_year"]}

#The user selects a model and year
    #Click Model Menu        ${${model_data}["menu_label"]}
    #Click Model By Name     ${${model_data}["model"]}
    #Click                   text=${${model_data}["model_year"]}

The user clicks the quote button
    ${brand_data}=  Get From Dictionary    ${brands}    ${BRAND}
    Click    text=${brand_data["quote_text"]} >> nth=0

The user fills out and submits the quote form
    Fill Quote Form                ${form}
    Take Timestamped Screenshot    ${locale}

#Setup Test
    #New Context            viewport={'width': 1920, 'height': 1080}
    #Set Browser Timeout    1 minute
    #${model_data}=    Evaluate    globals()[${brand}]
    #Set Suite Variable    ${model_data}

Setup Test
    New Context            viewport={'width': 1920, 'height': 1080}
    Set Browser Timeout    1 minute
    ${model_data}=    Get Variable Value    ${brand}    # Acessa o valor de ${brand}
    Run Keyword If      '${model_data}' == ''    Fail    Brand data not found!
    Log    ${model_data}    # Depuração para conferir o conteúdo
    Set Suite Variable    ${model_data}
    Log    ${brand}    # Verifique se a variável brand tem o valor esperado, como 'can_am' ou 'sea_doo'



Close Modal If Exists
    ${newsletter}=    Get Element Count    css=#root_newsletter-popup .overlay
    Run Keyword If    ${newsletter} > 0    Click    css=#root_newsletter-popup button[aria-label="Close"]

    ${modals}=    Get Element Count    css=.modal.fade.show
    Run Keyword If    ${modals} > 0    Click    css=.modal.fade.show button.close

Click Model By Name
    [Arguments]    ${model_name}
    ${element}=    Get Element    a[data-technical-name="${model_name}"]:visible >> nth=0
    Click          ${element}

Fill Quote Form
    [Arguments]         ${form}
    Sleep    1
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_first_name"]    ${form["first_name"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_last_name"]     ${form["last_name"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_email"]         ${form["email"]}
    Select Options By   ${IFRAME_SELECTOR} >>> [id="form_input_country_code"]  value   ${form["country_code"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_phone"]         ${form["phone"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom2"]       ${form["address"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom3"]       ${form["city"]}
    Select Options By   ${IFRAME_SELECTOR} >>> [id="form_input_custom4"]       value   ${form["province"]}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom5"]       ${form["postal_code"]}
    Run Keyword If      '${form["click_checkboxes"]}' == 'True'    Click Checkboxes In Iframe
    #Click                    ${IFRAME_SELECTOR} >>> [id="button1"]

Click Checkboxes In Iframe
    Click    ${IFRAME_SELECTOR} >>> [id="form_input_custom19"]
    Click    ${IFRAME_SELECTOR} >>> [id="form_input_custom20"]
    Sleep    1

Click Model Menu
    [Arguments]     ${menu_label}
    ${selector}=    Set Variable    a[data-analytic-label="${menu_label}"]
    Click           ${selector} >> nth=1

Handle Cookie Banner
    ${banner_present}=    Run Keyword And Return Status    Get Element    css=cmm-cookie-banner
    IF    ${banner_present}
        ${shadow_root}=    Get Shadow Root    css=cmm-cookie-banner
        Click    ${shadow_root} >> css=button:nth-child(2)
        Log    ✅ Successfully handled "Continue without consent" modal
    END

Take Timestamped Screenshot
    [Arguments]    ${locale}=default
    ${timestamp}=    Get Time    result_format=%Y%m%d-%H%M%S
    ${timestamp}=    Set Variable    ${timestamp.replace(":", "-")}
    ${filename}=     Set Variable    ${locale}-screenshot-${timestamp}
    Take Screenshot    filename=${filename}    fullPage=True

the page loads
    Click Shadow Button

Click Shadow Button
    ${button}=    Get Shadow Button
    Click         ${button}

Get Shadow Button
    ${element}=       Get Element    cmm-cookie-banner
    ${shadowRoot}=    Get Shadow Root    ${element}
    ${button}=        Query Selector From Root    ${shadowRoot}    button
    RETURN            ${button}

The user tries to submit the quote form without filling in the required fields
    Click                    ${IFRAME_SELECTOR} >>> [id="button1"]

the user sees the newsletter subscription form
    Wait For Elements State    text=Subscribe    visible
    Click    text=Subscribe

the user clicks the subscribe button without filling in first name, last name, and email
    Click                    ${IFRAME_SELECTOR} >>> [id="button1"]
    
# THEN
Validation messages should appear for each required field
    Validate Error Messages In Iframe    ${IFRAME_SELECTOR}    &{EXPECTED_ERRORS}
    Take Timestamped Screenshot    ${locale}

Validate Error Messages In Iframe
    [Arguments]    ${iframe}    @{only_keys}    &{errors}
    ${keys_to_check}=    Run Keyword If    ${only_keys}    Set Variable    @{only_keys}    ELSE    Evaluate    list(${errors}.keys())
    FOR    ${id}    IN    @{keys_to_check}
        ${selector}=    Set Variable    ${iframe} >>> div#${id}
        ${expected}=    Get From Dictionary    ${errors}    ${id}
        ${actual}=    Get Text    ${selector}
        Should Be Equal As Strings    ${actual}    ${expected}
    END

The form should not be submitted
    ${text}=    Get Text    h1.cmp-teaser__title
    ${brand_data}=  Get From Dictionary    ${brands}    ${BRAND}
    Should Be Equal As Strings    ${text}    ${brand_data["title_RAQ_PAGE"]}

validation messages should appear for the required fields
    Validate Error Messages In Iframe
    ...    ${IFRAME_SELECTOR}
    ...    form_input_name_error_text
    ...    form_input_email_error_text
    ...    &{EXPECTED_ERRORS}
    Take Timestamped Screenshot    ${locale}