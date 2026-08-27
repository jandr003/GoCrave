# Walkthrough - GoCrave Login Screen Implementation

Nagawa ko na ang implementation ng Login Screen para sa GoCrave. Ginamit ko ang **Poppins** font gaya ng iyong request at sinunod ko ang design sa image.

## Mga Pagbabagong Ginawa

### 1. Dependencies Setup
Nagdagdag ako ng `google_fonts` at `intl_phone_field` sa `pubspec.yaml` para sa malinis na typography at functionality.

### 2. Login Screen UI & Input Validation
Sa [login_screen.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/screens/login_screen.dart), inimplement ko ang mga sumusunod:
- **Language Selector**: Rounded container na may shadow sa top right.
- **Header**: Bold title na "Welcome to GoCrave".
- **Phone Input**: Custom design kung saan ang Flag at Country Code ay nasa loob ng grey box.
- **Input Validation (FIX)**: Nagdagdag ako ng `FilteringTextInputFormatter.digitsOnly` at pinalitan ang `keyboardType` sa `number`. Ngayon, **numero na lang talaga ang pwedeng i-type** at limitado ito sa 10 digits.
- **Continue Button**: Rounded button na may light grey background at orange text.

### 3. App Theme
Sa [main.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/main.dart), ginawa kong default font ang Poppins para sa buong app.

## Paano ito i-verify
1. Siguraduhin na tumakbo ang `flutter pub get`.
2. I-run ang app at tignan kung tugma ang layout sa binigay mong image.
3. Subukan i-type ang phone number sa field.

> [!TIP]
> Ang flag icon ay kasalukuyang gumagamit ng network image para sa Philippines (PH). Pwede nating palitan ito ng local asset kung gusto mo.
