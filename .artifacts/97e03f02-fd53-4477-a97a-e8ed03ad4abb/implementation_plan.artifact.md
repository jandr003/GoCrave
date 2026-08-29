# Implementation Plan - 6-Slide Infinite Onboarding

I-a-update natin ang Onboarding Screen para magkaroon ng 6 na slides na kumakatawan sa iba't ibang food categories. Gagawin din nating "infinite forward scroll" ang logic para laging pakanan ang galaw.

## Proposed Changes

### Screens

#### [MODIFY] [onboarding_screen.dart](file:///Users/macbookpro/AndroidStudioProjects/GoCrave/lib/screens/onboarding_screen.dart)
- **Data Expansion**: Magdagdag ng 6 na items sa `_onboardingData` (Fast Food, Home Style, Vegetarian, Snacks, Desserts, Drinks) na may high-quality representative images.
- **Infinite Scroll Logic**:
    - Baguhin ang `itemCount` sa `10000` (effectively infinite).
    - Gamitin ang `index % _onboardingData.length` para sa pagkuha ng data.
    - I-set ang initial page ng `PageController` sa gitna (e.g., `_onboardingData.length * 500`) para sa seamless infinite scroll.
- **Auto-Slide Adjustment**: Siguraduhin na ang timer ay laging nag-a-`animateToPage` sa `nextPage` (pakanan lang).
- **Dot Indicators**: I-update ang dots para maging 6 at ang logic para gamitin ang modulo operator (`index % 6`).

## 6 Categories Data
1. **Fast Food**: "Quick & Tasty Meals 🍔" - Crispy burgers and fries.
2. **Home Style**: "Taste of Home 🍲" - Classic Chicken Adobo and warm meals.
3. **Vegetarian**: "Healthy & Fresh 🥗" - Nutritious green bowls and salads.
4. **Snacks**: "Perfect Mid-day Bites 🍟" - Street foods and quick snacks.
5. **Desserts**: "Sweet Cravings Satisfied 🍰" - Cakes, ice cream, and sweets.
6. **Drinks**: "Refreshingly Cool 🥤" - Shakes, juices, and milk teas.

## Verification Plan

### Manual Verification
- I-verify kung ang slideshow ay kusa at smooth na gumagalaw pakanan.
- I-check kung pagkatapos ng ika-6 na slide, ang susunod ay ang 1st slide pa rin na pakanan ang galaw.
- Siguraduhin na ang 6 dots ay sumasabay nang tama.
- I-verify ang linaw ng mga bagong images.
