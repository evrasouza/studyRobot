*** Settings ***
Library           Browser
Library           Collections

Suite Setup       New Browser    chromium    headless=False
Suite Teardown    Close Browser
Test Setup        Setup Test
Test Teardown     Close Context


*** Variables ***
#${URL}            https://can-am.brp.com/off-road/ca/en/
#${URL}            https://can-am.brp.com/off-road/ca/fr/
${URL}            https://can-am.brp.com/off-road/us/en/
#${URL}            https://can-am.brp.com/off-road/us/es/
#${URL}            https://can-am.brp.com/on-road/us/en/
#${URL}            https://sea-doo.brp.com/ca/en/
#${URL}            https://sea-doo.brp.com/ca/fr/
#${URL}            https://ski-doo.brp.com/ca/en/
#${URL}            https://brplynx.com/ca/en/

&{DATA_SEA_DOO_EN}=    
...    model=spark
...    model_year=2024 Spark
...    quote_text=Request a Quote
...    expected_title=2025 Sea-Doo Personal Watercraft & Pontoon Boats
...    menu_label=models

&{DATA_SEA_DOO_FR}=    
...    model=spark
...    model_year=Spark 2024
...    quote_text=Demandez un prix
...    expected_title=Motomarines et Bateaux Pontons Sea-Doo 2025
...    menu_label=models

&{DATA_CAN_AM_OFF_EN_CA}=    
...    model=defender
...    model_year=2024 Defender
...    quote_text=Request a Quote
...    expected_title=2025 Can-Am Off-Road ATVs & Side-by-Sides Vehicles
...    menu_label=side-by-side-vehicles
...    first_name=John
...    last_name=Doe
...    email=john.doe@example.com
...    phone=1234567890
...    country_code=+55
...    address=Madame Toussauds 234 West 42nd Street
...    city=Ontario
...    province=ON
...    postal_code=M5H 2N2

&{DATA_CAN_AM_OFF_EN_US}=    
...    model=defender
...    model_year=2024 Defender
...    quote_text=Request a Quote
...    expected_title=2025 Can-Am Off-Road ATVs & Side-by-Sides Vehicles
...    menu_label=side-by-side-vehicles
...    first_name=John
...    last_name=Doe
...    email=john.doe@example.com
...    phone=1234567890
...    country_code=+1
...    address=123 Main Street
...    city=Miami
...    province=FL
...    postal_code=33101

&{DATA_CAN_AM_OFF_FR}=    
...    model=defender
...    model_year=Defender 2024
...    quote_text=Demander un prix
...    expected_title=Véhicules Can-Am Hors-Route 2025 : VTT et VCC
...    menu_label=side-by-side-vehicles

&{DATA_CAN_AM_OFF_ES}=    
...    model=defender
...    model_year=2024 Defender
...    quote_text=Request a Quote
...    expected_title=2025 Can-Am Off-Road ATVs & Side-by-Sides Vehicles
...    menu_label=side-by-side-vehicles

&{URL_DATA_MAP}=
...    https://sea-doo.brp.com/ca/en/=${DATA_SEA_DOO_EN}
...    https://sea-doo.brp.com/ca/fr/=${DATA_SEA_DOO_FR}
...    https://can-am.brp.com/off-road/ca/en/=${DATA_CAN_AM_OFF_EN_CA}
...    https://can-am.brp.com/off-road/ca/fr/=${DATA_CAN_AM_OFF_EN_CA}
...    https://can-am.brp.com/off-road/us/en/=${DATA_CAN_AM_OFF_EN_US}
...    https://can-am.brp.com/off-road/us/es/=${DATA_CAN_AM_OFF_EN_US}

${IFRAME_SELECTOR}    css=iframe[id^="lightbox-iframe-"]

*** Test Cases ***
Navigation Flow To Form Submission
    ${data}=    Get From Dictionary    ${URL_DATA_MAP}    ${URL}

    New Page    ${URL}
    Close Modal If Exists
    ${title}=    Get Title
    Should Contain    ${title}    ${data.expected_title}

    Wait For Elements State    css=#root_newsletter-popup .overlay    hidden    10s
    Click Model Menu    ${data.menu_label}
    Click Model By Name    ${data.model}
    Click    text="${data.model_year}"
    Click    text="${data.quote_text}" >> nth=0

    Fill Quote Form    ${data}

    Take Screenshot

*** Keywords ***
Setup Test
    New Context    viewport={'width': 1920, 'height': 1080}
    Set Browser Timeout    1 minute

Close Modal If Exists
    ${newsletter}=    Get Element Count    css=#root_newsletter-popup .overlay
    Run Keyword If    ${newsletter} > 0    Click    css=#root_newsletter-popup button[aria-label="Close"]

    ${modals}=    Get Element Count    css=.modal.fade.show
    Run Keyword If    ${modals} > 0    Click    css=.modal.fade.show button.close

Click Model By Name
    [Arguments]    ${model_name}
    ${element}=    Get Element    a[data-technical-name="${model_name}"]:visible >> nth=0
    Click    ${element}

Fill Quote Form
    [Arguments]         ${data}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_first_name"]    ${data.first_name}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_last_name"]     ${data.last_name}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_email"]         ${data.email}
    Select Options By   ${IFRAME_SELECTOR} >>> [id="form_input_country_code"]  value   ${data.country_code}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_phone"]         ${data.phone}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom2"]       ${data.address}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom3"]       ${data.city}
    Select Options By   ${IFRAME_SELECTOR} >>> [id="form_input_custom4"]       value   ${data.province}
    Fill Text           ${IFRAME_SELECTOR} >>> [id="form_input_custom5"]       ${data.postal_code}
    #Click Checkboxes In Iframe
    #Click                    ${IFRAME_SELECTOR} >>> [id="button1"]

Click Checkboxes In Iframe
    Click    ${IFRAME_SELECTOR} >>> [id="form_input_custom19"]
    Click    ${IFRAME_SELECTOR} >>> [id="form_input_custom20"]

Click Model Menu
    [Arguments]    ${menu_label}
    ${selector}=    Set Variable    a[data-analytic-label="${menu_label}"]
    Click    ${selector} >> nth=1