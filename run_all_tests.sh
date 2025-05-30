#!/bin/bash

echo "Running separate tests in parallel..."

declare -A locales=(
  ["CA_EN"]="https://can-am.brp.com/off-road/ca/en/"
  ["CA_FR"]="https://can-am.brp.com/off-road/ca/fr/"
  ["US_EN"]="https://can-am.brp.com/off-road/us/en/"
)

tests=(
  "request_a_quote.robot::RAQ"
  "subscribe_to_a_newsletter.robot::NEW"
)

# Função para rodar cada teste
run_test() {
  local locale=$1
  local url=$2
  local file=$3
  local suffix=$4

  echo "Running: $file - $locale"
  robot -v URL:"$url" -v BRAND:can_am \
        --variablefile "resources/yaml/${locale}.py" \
        -d "./reports/${locale}_${suffix}" \
        "tests/${file}"
}

# Loop paralelo
for locale in "${!locales[@]}"; do
  url="${locales[$locale]}"
  for test in "${tests[@]}"; do
    file="${test%%::*}"
    suffix="${test##*::}"
    run_test "$locale" "$url" "$file" "$suffix" &
  done
done

# Espera todos os testes finalizarem
wait

echo "Preparing merge paste..."
mkdir -p reports/merged/Browser/screenshot

echo "Copying screenshots..."
for locale in "${!locales[@]}"; do
  for suffix in "RAQ" "NEW"; do
    src_dir="reports/${locale}_${suffix}/Browser/screenshot"
    [ -d "$src_dir" ] && cp "$src_dir"/*.png reports/merged/Browser/screenshot/ 2>/dev/null
  done
done

echo "Merging the outputs..."
rebot --name "Quote Navigation Tests" \
      -d reports/merged \
      --output merged_output.xml \
      --report merged_report.html \
      --log merged_log.html \
      reports/*_RAQ/output.xml \
      reports/*_NEW/output.xml

echo "✅ Final report generated in reports/merged"
