**Variables**

#Brand Variables
${CANAMOFF}    https://can-am.brp.com/off-road
${CANAMON}     https://can-am.brp.com/on-road
${SKIDOO}      https://ski-doo.brp.com
${SEADOO}      https://sea-doo.brp.com
${LYNX}        https://www.brplynx.com

#Language Variables
${LANG_EN}     en
${LANG_FR}     fr

#Country variables
${REGION}      ON

${BROWSER}     ${EMPTY}
${TIMEOUT}     02:00
${DROPDOWN}    //div[@id='promotion-page-location-dialog']//div[contains(@class, 'modal-content')]//select
${OPTIONS}     //*[@id="promotion-page-location-dialog"]/div[2]/div/div/div[2]/div/div/select    
${CONFIRM}     css=#promotion-page-location-dialog .MuiBox-root button
${CLOSE_FORM}  button[class='close-btn']

#Data to fill in form
${FIRST_NAME_DATA}   Adrian
${LAST_NAME_DATA}    Osborne
${EMAIL_DATA}        adrian.osborne@test.com
${COUNTRYCODE_DATA}  +55
${PHONE_DATA}        11980988854
${ADDRESS_DATA}      155, rue Notre-Dame Est
${CITY_DATA}         Montreal
${PROVINCE_DATA}     QC
${POSTALCODE_DATA}   H2Y1B5