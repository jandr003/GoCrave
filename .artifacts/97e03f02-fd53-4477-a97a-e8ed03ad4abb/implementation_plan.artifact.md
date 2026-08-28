# Implementation Plan - Get Started (Onboarding) Screen

I-a-add natin ang **Onboarding Screen** (Get Started) para sa mga bagong user ng GoCrave. Lalabas lang ito sa unang pagkakataon na buksan ang app.

## User Review Required

> [!IMPORTANT]
> Gagamit tayo ng `shared_preferences` package para maalala ng app kung napanood na ng user ang onboarding. Ito ay para hindi na ito paulit-ulit na lumitaw.

## Proposed Changes

### Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/pubspec.yaml)
- Magdagdag ng `shared_preferences: ^2.2.2`.

### Core Logic

#### [MODIFY] [main.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/main.dart)
- Gawing `async` ang `main()` function.
- I-check ang `SharedPreferences` para malaman kung `isFirstTime` ang user.
- I-set ang `home` widget base sa result (Onboarding vs. Login).

### Screens

#### [NEW] [onboarding_screen.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/screens/onboarding_screen.dart)
- Inimplement ang `OnboardingScreen` bilang `StatefulWidget`.
- **Slide Show**: Gamit ang `PageView` para sa smooth na pag-slide ng images at text.
- **Content**:
    - **Full Screen Background**: Images na may food themes (gagamit muna tayo ng high-quality network images).
    - **Text Overlay**: Title ("Get Fastest Delivery in 30 Minutes 🍕") at Subtitle na may dark gradient background para mababasa.
- **Dot Indicators**: Tatlong dots sa gitna na nagbabago ang width/color depende sa active page.
- **Click To Start Button**: Rounded white button na may black text. Kapag pinindot:
    - I-save sa `SharedPreferences` na tapos na ang onboarding.
    - Mag-navigate papuntang `LoginScreen`.

## Verification Plan

### Manual Verification
1. I-uninstall at i-reinstall ang app (o i-clear data) para makita ang Onboarding Screen.
2. I-swipe ang slides at i-check kung smooth ang animation at dot indicators.
3. Pindutin ang "Click To Start" at siguraduhin na dadalhin ka sa Login Screen.
4. I-restart ang app at i-verify na direkta na itong pumupunta sa Login Screen (hindi na dapat lumabas ang Onboarding).
