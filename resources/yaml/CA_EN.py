form = {
  "first_name": "John",
  "last_name": "Doe",
  "email": "john.doe@example.com",
  "phone": "1234567890",
  "country_code": "+1",
  "address": "2, rue des Jardins Québec, QC G1R4S9Canada",
  "city": "Quebec",
  "province": "QC",
  "postal_code": "G1R4S9",
  "click_checkboxes": "true"
}

EXPECTED_ERRORS = {
    "form_input_name_error_text": "Please enter a valid name.",
    "form_input_email_error_text": "Please enter a valid email.",
    "form_input_phone_error_text": "Please enter a valid phone number.",
    "form_input_custom2_error_text": "Please enter a valid address.",
    "form_input_custom3_error_text": "Please enter a valid city.",
    "form_input_custom4_error_text": "Please select your state.",
    "form_input_custom5_error_text": "Please enter a valid zip code."
}

locale = "CA_EN"

sea_doo = {
  "model": "spark",
  "model_year": "2024 Spark",
  "quote_text": "Request a Quote",
  "expected_title": "2025 Sea-Doo Personal Watercraft & Pontoon Boats",
  "menu_label": "models"
}

can_am = {
  "model": "defender",
  "model_year": "2024 Defender",
  "quote_text": "Request a Quote",
  "title_RAQ_PAGE": "REQUEST A QUOTE",
  "expected_title": "2025 Can-Am Off-Road ATVs & Side-by-Sides Vehicles",
  "menu_label": "side-by-side-vehicles"
}