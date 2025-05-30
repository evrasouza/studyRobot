#!/bin/bash

echo "Running separate tests..."
robot -v URL:https://can-am.brp.com/off-road/ca/en/ -v BRAND:can_am --variablefile resources/yaml/CA_EN.py -d ./reports/CA_EN_RAQ tests/request_a_quote.robot
robot -v URL:https://can-am.brp.com/off-road/ca/fr/ -v BRAND:can_am --variablefile resources/yaml/CA_FR.py -d ./reports/CA_FR_RAQ tests/request_a_quote.robot
robot -v URL:https://can-am.brp.com/off-road/us/en/ -v BRAND:can_am --variablefile resources/yaml/US_EN.py -d ./reports/US_EN_RAQ tests/request_a_quote.robot
robot -v URL:https://can-am.brp.com/off-road/ca/en/ -v BRAND:can_am --variablefile resources/yaml/CA_EN.py -d ./reports/CA_EN_NEW tests/subscribe_to_a_newsletter.robot
robot -v URL:https://can-am.brp.com/off-road/ca/fr/ -v BRAND:can_am --variablefile resources/yaml/CA_FR.py -d ./reports/CA_FR_NEW tests/subscribe_to_a_newsletter.robot
robot -v URL:https://can-am.brp.com/off-road/us/en/ -v BRAND:can_am --variablefile resources/yaml/US_EN.py -d ./reports/US_EN_NEW tests/subscribe_to_a_newsletter.robot

#robot -v URL:https://can-am.brp.com/off-road/ca/en/ --variablefile /Users/desouev/Documents/robot-pocs/resources/yaml/CA_EN.yaml -d ./reports/CA_EN --tag CA_EN request_a_quote.robot                                
#robot -v URL:https://can-am.brp.com/off-road/ca/fr/ --variablefile /Users/desouev/Documents/robot-pocs/resources/yaml/CA_FR.yaml -d ./reports/CA_FR --tag CA_FR request_a_quote.robot
#robot -v URL:https://can-am.brp.com/off-road/us/en/ --variablefile /Users/desouev/Documents/robot-pocs/resources/yaml/US_EN.yaml -d ./reports/US_EN --tag US_EN request_a_quote.robot

#C:\projects\ROBOT\BRP\POW\resources\yaml\CA_EN.py

echo "Preparing merge paste..."
mkdir -p reports/merged/Browser/screenshot

echo "Copying screenshots..."
cp reports/CA_EN_RAQ/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/CA_FR_RAQ/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/US_EN_RAQ/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/CA_EN_NEW/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/CA_FR_NEW/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null
cp reports/US_EN_NEW/Browser/screenshot/*.png reports/merged/Browser/screenshot/ 2>/dev/null

echo "Merging the outputs..."
rebot --name "Quote Navigation Tests" \
      -d reports/merged \
      --output merged_output.xml \
      --report merged_report.html \
      --log merged_log.html \
      reports/CA_EN_RAQ/output.xml \
      reports/CA_FR_RAQ/output.xml \
      reports/US_EN_RAQ/output.xml \
      reports/CA_FR_NEW/output.xml \
      reports/CA_FR_NEW/output.xml \
      reports/US_EN_NEW/output.xml

echo "Final report generated in reports/merged"
