# Walkthrough - Get Started (Onboarding) Screen Implementation

Inimplement ko na ang **Get Started** screen na lalabas lamang para sa mga bagong users. Ginamit natin ang `shared_preferences` para maalala ng app kung tapos na ang user sa onboarding.

## Mga Pagbabagong Ginawa

### 1. Persistence Setup
Nagdagdag ako ng `shared_preferences` sa `pubspec.yaml`. Sa [main.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/main.dart), chine-check na natin bago mag-load ang app kung `isFirstTime` ang user para malaman kung `OnboardingScreen` o `LoginScreen` ang dapat ipakita.

### 2. Onboarding Screen: [onboarding_screen.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/screens/onboarding_screen.dart)
- **Auto-Slide Flow (NEW)**: Ang slideshow ay **kusa nang gumagalaw** tuwing 4 na segundo. Hindi mo na kailangang i-swipe para makita ang sumunod na slide.
- **Ultra-Smooth Slideshow**: Gumamit ako ng `AnimatedBuilder` at `Transform` para sa isang **parallax effect**. Habang nag-i-swipe (kusa man o manual), gumagalaw din nang bahagya ang background images para sa mas premium feel.
- **Fluid Dot Indicators**: Ang tatlong dots sa gitna ay **perpektong naka-sync** sa galaw ng slideshow. Habang lumilipat ang page, unti-unting humahaba at nagliliwanag ang dot na pupuntahan.
- **Visuals**:
    - **Background Images**: High-quality food images.
    - **Overlay**: Gradient background sa baba para kitang-kita ang text.
- **Action Button**: Ang "Click To Start" button ay mag-si-save ng preference sa device bago lumipat sa Login Screen.

## Paano ito i-verify
1. **Unang Run**: Pagkatapos ng `flutter pub get` at pag-run ng app, dapat lumabas ang Onboarding Screen.
2. **Slides**: I-swipe pakaliwa o pakanan para makita ang 3 slides.
3. **Finish**: Pindutin ang "Click To Start". Dapat kang mapunta sa Login Screen.
4. **Persistence**: I-restart ang app. Dapat direkta na itong pumunta sa Login Screen (dahil alam na ng device na hindi ka na "first time").

> [!TIP]
> Kung gusto mong makita ulit ang onboarding habang nagde-develop, i-clear mo lang ang data ng app sa settings ng emulator o i-uninstall at i-install ulit ito.
