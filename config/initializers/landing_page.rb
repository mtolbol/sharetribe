module CustomLandingPage
  # rubocop:disable Metrics/ModuleLength
  module StaticData

    # TODO Document the expected JSON structure here

    DATA_STR = <<JSON
{
  "settings": {
    "marketplace_id": 9999,
    "locale": "da-DK",
    "sitename": "Tumlino"
  },

  "page": {
    "twitter_handle": {"type": "marketplace_data", "id": "twitter_handle"},
    "twitter_image": {"type": "assets", "id": "default_hero_background"},
    "facebook_image": {"type": "assets", "id": "default_hero_background"},
    "title": {"type": "marketplace_data", "id": "page_title"},
    "description": {"type": "marketplace_data", "id": "description"},
    "publisher": {"type": "marketplace_data", "id": "name"},
    "copyright": {"type": "marketplace_data", "id": "name"},
    "facebook_site_name": {"type": "marketplace_data", "id": "name"},
    "google_site_verification": {"value": "CHANGEME"}
  },

  "sections": [
    {
      "id": "hero",
      "kind": "hero",
      "variation": {"type": "marketplace_data", "id": "search_type"},
      "title": {"type": "marketplace_data", "id": "slogan"},
      "subtitle": {"type": "marketplace_data", "id": "description"},
      "background_image": {"type": "assets", "id": "photo/mother"},
      "background_image_variation": "transparent",
      "search_button": {"type": "translation", "id": "search_button"},
      "search_path": {"type": "path", "id": "search"},
      "search_placeholder": {"type": "marketplace_data", "id": "search_placeholder"},
      "search_location_with_keyword_placeholder": {"type": "marketplace_data", "id": "search_location_with_keyword_placeholder"},
      "signup_path": {"type": "path", "id": "signup"},
      "signup_button": {"type": "translation", "id": "signup_button"},
      "search_button_color": {"type": "marketplace_data", "id": "primary_color"},
      "search_button_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"},
      "signup_button_color": {"type": "marketplace_data", "id": "primary_color"},
      "signup_button_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"}
    },
    {
      "id": "video",
      "kind": "video",
      "variation": "youtube",
      "youtube_video_id": "igSjslFH_DA",
      "width": "1280",
      "height": "720",
      "text": ""
    },
    {
      "id": "about_tumlino",
      "kind": "info",
      "variation": "single_column",
      "title": "Om Tumlino",
      "paragraph": "Vi havde selv svært ved at finde hjælp!\\n\\nTumlino er et nyt koncept der gør det lettere for dig at finde, sammenligne og booke privat sundhedshjælp.\\n\\nDet er ret simpelt. Tumlino forbinder gravide, barslende og børnefamilier med kvalificeret hjælp fra private fagpersoner som f.eks. private jordemødre, ammerådgivere, fysioterapeuter, kiropraktorer og andre relevante fagpersoner.",
      "background_image": {"type": "assets", "id": "photo/family"},
      "background_image_variation": "transparent"
    },
    {
      "id": "benefits",
      "kind": "info",
      "variation": "multi_column",
      "title": "Fordelene ved Tumlino",
      "button_color": {"type": "marketplace_data", "id": "primary_color"},
      "button_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"},
      "icon_color": {"type": "marketplace_data", "id": "primary_color"},
      "columns": [
        {
          "icon": "home-1",
          "title": "Alt samlet ét sted",
          "paragraph": "Tumlino samler alle private sundshedstilbud på én markedsplads. ",
          "button_title": "Gå til markedspladsen",
          "button_path": {"value": "/s"}
        },
        {
          "icon": "location-pin-1",
          "title": "Find hjælp nær dig",
          "paragraph": "Hjælpen er oftere tættere på end du tror. På Tumlino kan hurtigt finde private fagpersoner nær dig.",
          "button_title": "Gå til FAQ",
          "button_path": {"value": "/da-DK/infos/how_to_use"}
        }
      ]
    },
    {
      "id": "get_started",
      "kind": "info",
      "variation": "single_column",
      "title": "Kom i gang med det samme",
      "paragraph": "Har du brug for hjælp eller har du spørgsmål?\\n\\nLad os hjælpe dig med at komme i gang med at bruge Tumlinos markedsplads.",
      "background_image": {"type": "assets", "id": "photo/get_started"},
      "background_image_variation": "transparent",
      "button_color": {"type": "marketplace_data", "id": "primary_color"},
      "button_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"},
      "button_title": "Kontakt os",
      "button_path": {"type": "path", "id": "contact_us"}
    },
    {
      "id": "how_it_works",
      "kind": "info",
      "variation": "multi_column",
      "title": "Sådan fungerer Tumlino",
      "button_color": {"type": "marketplace_data", "id": "primary_color"},
      "button_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"},
      "icon_color": {"type": "marketplace_data", "id": "primary_color"},
      "columns": [
        {
          "title": "1. Find hjælp",
          "icon": "account-find-1",
          "paragraph": "Indtast din by eller den hjælp du har brug for og find fagpersoner i dit nærområde.",
          "button_title": "Gå til markedspladsen",
          "button_path": {"value": "/s"}
        },
        {
          "title": "2. Sammenlign",
          "icon": "task-checklist-check",
          "paragraph": "Se fagpersonernes profil og få information om erfaring, uddanelse, priser og meget andet.",
          "button_title": "Gå til FAQ",
          "button_path": {"value": "/da-DK/infos/how_to_use"}
        },
        {
          "title": "3. Book en tid",
          "icon": "calendar-2",
          "paragraph": "Vælg det tidspunkt som passer dig bedst og book med det samme.",
          "button_title": "Kontakt os",
          "button_path": {"value": "/da-DK/user_feedbacks/new"}
        }
      ]
    },
    {
      "id": "three_column_info_without_icons_and_buttons",
      "kind": "info",
      "variation": "multi_column",
      "title": "Three column info without icons and buttons",
      "columns": [
        {
          "title": "Column 1",
          "paragraph": "Paragraph. Curabitur blandit tempus porttitor. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel."
        },
        {
          "title": "Column 2",
          "paragraph": "Paragraph. Curabitur blandit tempus porttitor. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel."
        },
        {
          "title": "Column 3",
          "paragraph": "Paragraph. Curabitur blandit tempus porttitor. Nulla vitae elit libero, a pharetra augue. Vivamus sagittis lacus vel."
        }
      ]
    },
    {
      "id": "footer",
      "kind": "footer",
      "theme": "light",
      "social_media_icon_color": {"type": "marketplace_data", "id": "primary_color"},
      "social_media_icon_color_hover": {"type": "marketplace_data", "id": "primary_color_darken"},
      "links": [
        {"label": "Om os", "href": {"type": "path", "id": "about"}},
        {"label": "Kontakt os", "href": {"type": "path", "id": "contact_us"}},
        {"label": "FAQ", "href": {"type": "path", "id": "how_to_use"}},
        {"label": "Handelsbetingelser", "href": {"type": "path", "id": "terms"}},
        {"label": "Privatpolitik", "href": {"type": "path", "id": "privacy"}}
      ],
      "social": [
        {"service": "facebook", "url": "https://www.facebook.com/tumlino/"},
        {"service": "instagram", "url": "https://www.instagram.com/tumlino/"}
      ],
      "copyright": "Copyright Tumlino ApS, 2019"
    }
  ],

  "composition": [
    { "section": {"type": "sections", "id": "hero"}},
    { "section": {"type": "sections", "id": "video"}},
    { "section": {"type": "sections", "id": "how_it_works"}},
    { "section": {"type": "sections", "id": "about_tumlino"}},
    { "section": {"type": "sections", "id": "benefits"}},
    { "section": {"type": "sections", "id": "get_started"}},
    { "section": {"type": "sections", "id": "footer"}}
  ],

  "assets": [
    { "id": "default_hero_background", "src": "default_hero_background.jpg", "content_type": "image/jpeg" },
    { "id": "icon/calendar", "src": "icons/calendar.png", "content_type": "image/png" },
    { "id": "icon/certificate", "src": "icons/certificate.png", "content_type": "image/png" },
    { "id": "icon/compare", "src": "icons/compare.png", "content_type": "image/png" },
    { "id": "icon/description", "src": "icons/description.png", "content_type": "image/png" },
    { "id": "icon/found", "src": "icons/found.png", "content_type": "image/png" },
    { "id": "icon/happy_customers", "src": "icons/happy_customers.png", "content_type": "image/png" },
    { "id": "icon/map", "src": "icons/map.png", "content_type": "image/png" },
    { "id": "icon/notification", "src": "icons/notification.png", "content_type": "image/png" },
    { "id": "icon/profile", "src": "icons/profile.png", "content_type": "image/png" },
    { "id": "icon/under_one_roof", "src": "icons/under_one_roof.png", "content_type": "image/png" },

    { "id": "photo/concept_video", "src": "photos/concept_video.png", "content_type": "image/png" },
    { "id": "photo/family", "src": "photos/family.jpg", "content_type": "image/jpeg" },
    { "id": "photo/get_started", "src": "photos/get_started.jpg", "content_type": "image/jpeg" },
    { "id": "photo/green", "src": "photos/green.png", "content_type": "image/png" },
    { "id": "photo/grey", "src": "photos/grey.png", "content_type": "image/png" },
    { "id": "photo/mother", "src": "photos/mother.jpg", "content_type": "image/jpeg" },
    { "id": "photo/professionals", "src": "photos/professionals.jpg", "content_type": "image/jpeg" }
  ]
}
JSON


  end
  # rubocop:enable Metrics/ModuleLength
end
