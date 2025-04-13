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
    "form_input_name_error_text": "Veuillez saisir un prénom et un nom valides.",
    "form_input_email_error_text": "Veuillez saisir une adresse électronique valide.",
    "form_input_phone_error_text": "Veuillez saisir un numéro de téléphone valide.",
    "form_input_custom2_error_text": "Veuillez saisir une adresse valide.",
    "form_input_custom3_error_text": "Veuillez saisir une ville valide.",
    "form_input_custom4_error_text": "Veuillez sélectionner votre province.",
    "form_input_custom5_error_text": "Veuillez saisir un code postal valide."
}

locale = "CA_FR"

sea_doo = {
  "model": "spark",
  "model_year": "2024 Spark",
  "quote_text": "Demandez un prix",
  "expected_title": "Motomarines et Bateaux Pontons Sea-Doo 2025",
  "menu_label": "models"
}

can_am = {
  "model": "defender",
  "model_year": "Defender 2024",
  "quote_text": "Demander un prix",
  "title_RAQ_PAGE": "DEMANDEZ UN PRIX",
  "expected_title": "Véhicules Can-Am Hors-Route 2025 : VTT et VCC",
  "menu_label": "side-by-side-vehicles"
}
