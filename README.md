# FM Expenses

Flutter project using **Melos monorepo** structure.

## Project Structure

```
fm_expenses
 ├── app
 │    └── pubspec.yaml
 ├── packages
 │    ├── logger
 │    ├── storage
 │    └── theme
 └── melos.yaml
```

- **app**: Main Flutter application
- **packages**: Shared internal packages used by the app
- **melos.yaml**: Monorepo configuration

---

# Setup Project

## 1. Clone repository

```bash
git clone <repo-url>
cd fm_expenses
```

---

## 2. Install dependencies

Install all dependencies for the project.

```bash
flutter pub get
```

If using **melos**:

```bash
melos bootstrap
```

---

# Generate Assets

## Generate App Launcher Icon

App icon configuration is defined in `pubspec.yaml` under `flutter_launcher_icons`.

Run the following command:

```bash
dart run flutter_launcher_icons
```

or

```bash
flutter pub run flutter_launcher_icons
```

---

## Generate Native Splash Screen

Splash configuration is defined in `pubspec.yaml` under `flutter_native_splash`.

Run:

```bash
dart run flutter_native_splash:create
```

or

```bash
flutter pub run flutter_native_splash:create
```

---

# Run Application

Start the application:

```bash
flutter run
```

---

# Clean Project

If you encounter dependency or build issues:

```bash
flutter clean
flutter pub get
```

---

# Build Application

## Android APK

```bash
flutter build apk
```

## Android App Bundle

```bash
flutter build appbundle
```

## iOS

```bash
flutter build ios
```

---

# Notes

- App icon configuration: `flutter_launcher_icons`
- Splash screen configuration: `flutter_native_splash`
- All configurations are defined inside `pubspec.yaml`

After updating icon or splash images, remember to **run the generate commands again**.

---

# Requirements

- Flutter >= 3.x
- Dart >= 3.x
- Melos (optional for monorepo)

Install melos globally:

```bash
dart pub global activate melos
```

Then run:

```bash
melos bootstrap
```
