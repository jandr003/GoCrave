# Implementation Plan - GoCrave Login Screen

This plan outlines the steps to implement the Login UI as seen in the provided image for the `login_screen.dart` file.

## User Review Required

> [!IMPORTANT]
> I will be adding the `intl_phone_field` and `google_fonts` packages to `pubspec.yaml` to achieve the look and functionality shown in the image (country picker and specific typography).

## Proposed Changes

### Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/pubspec.yaml)
- Add `google_fonts: ^6.1.0`
- Add `intl_phone_field: ^3.2.0`

### Core Screen Implementation

#### [MODIFY] [login_screen.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/screens/login_screen.dart)
- Implement `LoginScreen` as a `StatelessWidget`.
- **Top Bar**: Use a `SafeArea` and `Row` for the back button and the "English" language selector.
- **Header**: Large bold text "Welcome to GoCrave" and a grey subtitle.
- **Phone Input Section**:
    - Label "Phone number*" with a red asterisk.
    - Custom `intl_phone_field` styling to match the image (flag icon, country code in a box, and underlined text field).
- **Continue Button**: A rounded button with a light grey background and orange text.
- **Footer**: `RichText` to handle the "Terms of Service & Privacy Policy" clickable links.

### Project Setup

#### [MODIFY] [main.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/main.dart)
- Set `LoginScreen` as the `home` widget.
- Update `ThemeData` to use a clean font (e.g., Poppins or Roboto) via `google_fonts`.

## Verification Plan

### Manual Verification
- Verify that the layout matches the provided image.
- Ensure the phone number field correctly displays the country picker (defaulting to Philippines).
- Check that the "Continue" button is clickable.
- Verify the "Terms of Service & Privacy Policy" text layout.
