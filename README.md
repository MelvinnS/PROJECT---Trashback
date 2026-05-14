# TrashBack – Flutter Project Structure

## Folder Layout
```
trashback/
├── pubspec.yaml
├── lib/
│   ├── main.dart                   ← App entry, AppTheme, routes
│   ├── screens/
│   │   ├── splash_screen.dart      ← Screen 1: 3-sec fade-in, auto-nav to login
│   │   ├── login_screen.dart       ← Screen 2: Masuk Ke Akun
│   │   ├── register_screen.dart    ← Screen 3: Daftar Akun
│   │   ├── welcome_screen.dart     ← Screen 4: Ayo Ubah Sampah
│   │   └── home_screen.dart        ← Screen 5: Halaman Utama
│   └── widgets/
│       ├── custom_text_field.dart  ← Reusable text field with asset prefix icon
│       ├── social_login_button.dart← Google/Apple/Phone button
│       ├── wallet_card.dart        ← EcoCash saldo card
│       ├── feature_grid.dart       ← 5-item feature row
│       ├── active_history_card.dart← Map route card
│       ├── recycle_items_carousel.dart ← Horizontal scroll items
│       └── bottom_nav_bar.dart     ← Fixed 4-tab nav bar
└── assets/
    ├── fonts/                      ← Poppins (400/500/600/700/800)
    ├── images/                     ← Illustrations, banners, product images
    └── icons/                      ← UI icons (prefix icons, nav icons)
```

## Setup Steps

### 1. Add Poppins Font
Download from https://fonts.google.com/specimen/Poppins and place:
- `assets/fonts/Poppins-Regular.ttf`
- `assets/fonts/Poppins-Medium.ttf`
- `assets/fonts/Poppins-SemiBold.ttf`
- `assets/fonts/Poppins-Bold.ttf`
- `assets/fonts/Poppins-ExtraBold.ttf`

### 2. Add Assets
Place your design assets in the appropriate folders as declared in `pubspec.yaml`.
All icons/images use `errorBuilder` fallbacks so the app runs even before assets are added.

### 3. Run
```bash
flutter pub get
flutter run
```

## Navigation Flow
```
SplashScreen (3s) → LoginScreen → RegisterScreen
                 ↘                ↙
                  WelcomeScreen → HomeScreen
```

## API Integration Points
- `LoginScreen._handleLogin()` → POST /auth/login
- `RegisterScreen._handleRegister()` → POST /auth/register
Both use `TextEditingController` for clean data extraction.

## Color Palette
| Token | Hex | Usage |
|-------|-----|-------|
| primaryGreen | #2E7D32 | Buttons, accents, active states |
| lightGreen | #4CAF50 | Gradients, highlights |
| backgroundWhite | #F9F9F9 | Scaffold background |
| textDark | #1A1A1A | Headlines |
| textGrey | #757575 | Body, hints |
