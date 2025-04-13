#!/bin/bash

echo "Running separate tests..."
#robot -v URL:https://can-am.brp.com/off-road/ca/en/ --variablefile resources/yaml/CA_EN.py -d ./reports/CA_EN tests/request_a_quote.robot                                
#robot -v URL:https://can-am.brp.com/off-road/ca/fr/ --variablefile resources/yaml/CA_FR.py -d ./reports/CA_FR tests/request_a_quote.robot
#robot -v URL:https://can-am.brp.com/off-road/us/en/ --variablefile resources/yaml/US_EN.py -d ./reports/US_EN tests/request_a_quote.robot

robot -v URL:https://can-am.brp.com/off-road/ca/en/ -v BRAND:can_am --variablefile resources/yaml/CA_EN.py -d ./reports/CA_EN_CAN tests/request_a_quote.robot                                
robot -v URL:https://can-am.brp.com/off-road/ca/fr/ -v BRAND:can_am --variablefile resources/yaml/CA_FR.py -d ./reports/CA_FR_CAN tests/request_a_quote.robot
robot -v URL:https://can-am.brp.com/off-road/us/en/ -v BRAND:can_am --variablefile resources/yaml/US_EN.py -d ./reports/US_EN_CAN tests/request_a_quote.robot
robot -v URL:https://sea-doo.brp.com/ca/en/ -v BRAND:sea_doo --variablefile resources/yaml/CA_EN.py -d ./reports/CA_EN_SEA tests/request_a_quote.robot
robot -v URL:https://sea-doo.brp.com/ca/fr/ -v BRAND:sea_doo --variablefile resources/yaml/CA_FR.py -d ./reports/CA_FR_SEA tests/request_a_quote.robot

C:\projects\ROBOT\BRP\POW\resources\yaml\CA_EN.py

echo "Preparing merge paste..."
mkdir -p reports/merged/Browser/screenshot

echo "Copying screenshots..."
cp reports/CA_EN/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/CA_FR/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/US_EN/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null

echo "Merging the outputs..."
rebot --name "Quote Navigation Tests" \
      -d reports/merged \
      --output merged_output.xml \
      --report merged_report.html \
      --log merged_log.html \
      reports/CA_EN/output.xml \
      reports/CA_FR/output.xml \
      reports/US_EN/output.xml

echo "Final report generated in reports/merged"