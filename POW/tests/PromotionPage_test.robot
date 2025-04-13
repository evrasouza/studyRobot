* Settings *
Documentation        Tests to validate the promotions page of BRP brand websites
Library              Browser

Resource             ../resources/common_keywords.resource

* Test Cases *
Scenario Outline 01 - The user sees the drop-down list on the promotions page
    [Template]    Scenario Outline 01 - The user sees the drop-down list on the promotions page
    #BRAND        #COUNTRY        #LANGUAGE      #TITLE               #SUBTITLE        $TEXT_COMBOBOX        #BUTTON
    ${CANAMOFF}   ${COUNTRY}      ${LANGUAGE}    ${TITLE}             ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON}
    ${CANAMON}    ${COUNTRY}      ${LANGUAGE}    ${TITLE}             ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON}
    ${SEADOO}     ${COUNTRY}      ${LANGUAGE}    ${TITLE_SEALYNX}     ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON_SEA}
    ${SKIDOO}     ${COUNTRY}      ${LANGUAGE}    ${TITLE}             ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON}
    ${LYNX}       ${COUNTRY}      ${LANGUAGE}    ${TITLE_SEALYNX}     ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON}

Scenario Outline 02 - User selects region from the dropdown on promotion page
    [Template]    Scenario Outline 02 - User selects region from the dropdown on promotion page
    #BRAND        #COUNTRY        #LANGUAGE        #TEXT                #EXPECTED_PAGE_TITLE              ${SUBTITLE_VEHICLEPAGE}
    ${CANAMOFF}   ${COUNTRY}      ${LANGUAGE}      ${SHOWING_RESULTS}   ${EXPECTED_PAGE_TITLE}            ${SUBTITLE_VEHICLEPAGE}
    ${CANAMON}    ${COUNTRY}      ${LANGUAGE}      ${SHOWING_RESULTS}   ${EXPECTED_PAGE_TITLE}            ${SUBTITLE_VEHICLEPAGE}
    ${SEADOO}     ${COUNTRY}      ${LANGUAGE}      ${SHOWING_RESULTS}   ${EXPECTED_PAGE_TITLE_SEALYNX}    ${SUBTITLE_VEHICLEPAGE}
    ${SKIDOO}     ${COUNTRY}      ${LANGUAGE}      ${SHOWING_RESULTS}   ${EXPECTED_PAGE_TITLE}            ${SUBTITLE_MODELPAGE}
    ${LYNX}       ${COUNTRY}      ${LANGUAGE}      ${SHOWING_RESULTS}   ${EXPECTED_PAGE_TITLE_SEALYNX}    ${SUBTITLE_MODELPAGE}

**Keywords**
Scenario Outline 01 - The user sees the drop-down list on the promotions page
    [Arguments]    ${BRAND}    ${COUNTRY}    ${LANGUAGE}    ${TITLE}      ${SUBTITLE}      ${TEXT_COMBOBOX}      ${BUTTON}
    GIVEN the user has accessed the website    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    WHEN the user sees the drop-down menu to select the region
    THEN the validates that the screen title is "${TITLE}"
    AND the subtitle is "${SUBTITLE}"
    AND the default text that appears in the selection box is "${TEXT_COMBOBOX}"
    AND the button text is "${BUTTON}"
    [Teardown]    Close Browser

Scenario Outline 02 - User selects region from the dropdown on promotion page
    [Arguments]    ${BRAND}    ${COUNTRY}    ${LANGUAGE}    ${SHOWING_RESULTS}    ${EXPECTED_PAGE_TITLE}    ${EXPECTED_PAGE_SUBTITLE}
    GIVEN the user has accessed the website    ${BRAND}    ${COUNTRY}    ${LANGUAGE}
    WHEN the user selects a region from he dropdown
    THEN the user sees the vehicle/model type page
    AND the page title should be "${EXPECTED_PAGE_TITLE}"
    AND the page subtitle should be "${EXPECTED_PAGE_SUBTITLE}"
    AND the text next to the region combobox should be "${SHOWING_RESULTS}"
    AND there should be vehicle model cards displayed on the screen
    [Teardown]    Close Browser