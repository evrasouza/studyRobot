* Settings *
Library  Browser

Resource     variables.resource

* Keywords *
# GIVEN
GIVEN the user has accessed the website
    [Arguments]    ${brand}    ${country}    ${language}
    Open site      ${brand}    ${country}    ${language}

GIVEN the user has accessed the website default
    [Arguments]    ${brand}    ${country}    ${language}
    Open Site Default      ${brand}    ${country}    ${language}

# WHEN
WHEN the user sees the drop-down menu to select the region
    Wait For Elements State    h1[class='brpmodal-title']    visible    5

WHEN the user selects a region from he dropdown
    Select an item from the dropdown

# THEN
THEN the validates that the screen title is "${TITLE}"
    Get Text        h1[class='brpmodal-title']   contains    ${TITLE}

THEN the user sees the vehicle/model type page
    Validate that the user is on the vehicle/Model type page

#AND
AND the subtitle is "${SUBTITLE}"
    Get Text        div[class='css-3oit09']   contains    ${SUBTITLE}

AND the default text that appears in the selection box is "${TEXT_COMBOBOX}"
    Get Text        //*[@id="promotion-page-location-dialog"]/div[2]/div/div/div[2]/div/div/select   contains    ${TEXT_COMBOBOX}

AND the button text is "${BUTTON}"
    Get Text        button[class^='MuiButtonBase']   contains    ${BUTTON}
    Take Screenshot    fullPage=True

AND the page title should be "${EXPECTED_PAGE_TITLE}"
    Get Text        div[class='title-container']   contains    ${EXPECTED_PAGE_TITLE}

AND the page subtitle should be "${EXPECTED_PAGE_SUBTITLE}"
    Get Text        div[class='css-1rycpgk']   contains    ${EXPECTED_PAGE_SUBTITLE}

AND the text next to the region combobox should be "${EXPECTED_TEXT}"
    Get Text        div[class='region-container']    contains    ${SHOWING_RESULTS}

AND there should be vehicle model cards displayed on the screen
    Wait For Elements State    div[class='cards-grid']    visible    5
    Take Screenshot    fullPage=True
    
# Generic keywords
Open Site
    [Arguments]  ${url}  ${country}    ${language}
    New Browser             browser=chromium    headless=True
    New Context             viewport={'width': 1280, 'height': 720}    # HD
    Set Browser Timeout     01:00
    New Page                ${url}/${country}/${language}/promotions.html
    Validate tab title
    Check if the form is displayed when you open the site

Open Site Default
    [Arguments]  ${url}  ${country}    ${language}
    New Browser             browser=${BROWSER}    headless=False
    New Context             viewport={'width': 1280, 'height': 720}
    Set Browser Timeout     02:00
    New Page                ${url}/${country}/${language}
    Check if the form is displayed when you open the site
    Check cookies and close

Check cookies and close
    TRY
        Wait For Elements State    css=#axeptio_btn_acceptAll    visible    5
        Click    css=#axeptio_btn_acceptAll
    EXCEPT
        Log    Form not presented
    END

Validate tab title
        Get Title               ==    ${TAB_TITLE}

Check if the form is displayed when you open the site
    TRY
        Wait For Elements State    button[class='close-btn']    visible    5
        Wait For Elements State    ${CLOSE_FORM}    visible    5
        Click    ${CLOSE_FORM}
    EXCEPT
        Log    Form not presented
    END


Select an item from the dropdown
    Wait For Elements State    h1[class='brpmodal-title']    visible    5
    Wait For Elements State    ${dropdown}        visible    5
    Click    ${dropdown}
    Select Options By    ${options}    value    ${REGION}
    Click    ${dropdown}
    Wait For Elements State  ${confirm}  visible    5
    Click    ${confirm}
   
Validate that the user is on the vehicle/Model type page
    Wait For Elements State    div[class='css-1rycpgk']    visible    5
    Get Text        div[class='region-slct']    contains    ${NAME_REGION}

Validate Title
    TRY
        Get Text        div[class='title-container']   contains    ${EXPECTED_PAGE_TITLE}
    EXCEPT
        Get Text        div[class='title-container']   contains    ${EXPECTED_PAGE_TITLE_SEALYNX}
    END