# FM Expenses

Flutter project using **Melos monorepo** structure.

---

## 🛠 Prerequisites & Version Management

### 1. Flutter Version Management (FVM)
This project uses [FVM](https://fvm.app/) to manage the Flutter SDK version. This ensures all developers use the same Flutter version.

- **Flutter Version:** `3.41.6` (defined in `.fvmrc`)

**Setup FVM:**
```bash
# Install FVM
dart pub global activate fvm

# Install the required Flutter version
fvm install
```

### 2. Monorepo Management (Melos)
This project is structured as a **Monorepo** (multiple packages in a single repository) following the [official Flutter/Dart package management guidelines](https://docs.flutter.dev/packages-and-plugins/developing-packages).

We use [Melos](https://melos.invertase.dev/) to manage the workspace, which provides features like automatic versioning, dependency linking (bootstrapping), and workspace-wide command execution.

**Install Melos:**
```bash
dart pub global activate melos
```

---

## Project Structure

```text
fm_expenses
 ├── app                # Main Flutter application
 ├── packages           # Feature-based packages
 │    ├── account       # Account & Profile features
 │    ├── auth          # Authentication & Login
 │    ├── home          # Home dashboard
 │    ├── main          # Main shell/navigation
 │    ├── member        # Member management
 │    └── transaction   # Expense & Transaction tracking
 ├── shared             # Common shared packages
 │    ├── assets        # Centralized assets (images, fonts)
 │    ├── components    # Shared UI widgets
 │    ├── config        # Environment & App config
 │    ├── l10n          # Localization & Internationalization
 │    ├── logger        # Custom logging utility
 │    ├── providers     # State management / BLoCs
 │    ├── router        # App routing
 │    ├── service       # API & Business services
 │    ├── storage       # Local storage
 │    └── theme         # App styling & Themes
 └── melos.yaml         # Melos workspace configuration
```

- **app**: Entry point of the Flutter application.
- **packages**: Contain independent feature modules.
- **shared**: Common packages used across the application.
- **melos.yaml**: Configuration for managing the monorepo.

---

## Package Architecture (Clean Architecture + MVVM)

Each feature package (under `packages/`) follows **Clean Architecture** principles combined with **MVVM (using Bloc)**:

```text
lib/
 ├── data/              # Data Layer
 │    ├── dto/          # Data Transfer Objects (Request/Response)
 │    ├── repository/   # Repository implementations
 │    └── converters/   # Model mapping logic
 ├── domain/            # Domain Layer (Business Logic)
 │    ├── entities/     # Business objects
 │    ├── repository/   # Repository interfaces
 │    └── usecase/      # Application business rules
 └── presentation/      # Presentation Layer (UI)
      ├── pages/        # Feature screens
      │    └── login/
      │         ├── bloc/ # State management (ViewModel)
      │         └── login_page.dart
      └── components/   # Feature-specific widgets
```

- **Data Layer**: Responsible for data retrieval from APIs or local storage.
- **Domain Layer**: Contains the core business logic, independent of other layers.
- **Presentation Layer**: Handles UI and user interaction using BLoC as the bridge (MVVM).

---

## 🌍 Localization (Multi-language)

The project uses the standard Flutter `l10n` tool for internationalization.
- **Location**: `shared/l10n`
- **Configuration**: `shared/l10n/l10n.yaml`
- **Translation Files**: `shared/l10n/lib/src/arb/`

**Commands to generate translations:**
```bash
# Using Melos (recommended)
melos run gen_l10n

# Manual (inside shared/l10n)
flutter gen-l10n
```

---

## 🎨 Assets & Resources Management

Assets are centralized in `shared/assets` and managed using [flutter_gen](https://pub.dev/packages/flutter_gen).
- **Images/SVGs/Fonts**: Stored in `shared/assets/assets/`
- **Code Generation**: Automatically generates type-safe references for assets.

**Commands to generate assets:**
```bash
# Using Melos (recommended)
melos run gen_assets
```

---

## Routing & Navigation (Auto Route)

The project uses [Auto Route](https://pub.dev/packages/auto_route) for navigation, which provides strong-typing and deep-linking support across the monorepo.

### 🔗 Deep Linking Benefits
Using a declarative router like Auto Route (or Go Router) provides several advantages for Deep Linking:
- **Type-safe Navigation**: Pass arguments to routes without worrying about string-based key errors.
- **Nested Routing**: Easily handle complex deep links that point to specific tabs or nested screens.
- **Path-based URLs**: Support for web-like URL structures (e.g., `/transaction/123/edit`) out of the box.
- **Declarative Logic**: Centralized logic to handle incoming links and redirect users based on app state (e.g., authentication).

- **Centralized Router**: Managed in `packages/router` or `packages/main`.
- **Modular Routes**: Each feature package defines its own routes using `@RoutePage`.
- **Code Generation**: Uses `build_runner` to generate route configurations.

**Commands to generate routes:**
```bash
# Generate for a specific package
dart run build_runner build --delete-conflicting-outputs

# Or use Melos to generate for all packages (if script is configured)
melos exec -- "flutter pub run build_runner build --delete-conflicting-outputs"
```

---

# Setup Project

## 1. Clone repository

```bash
git clone <repo-url>
cd fm_expenses
```

---

## 2. Setup Environment

```bash
# Install and use the correct Flutter version
fvm install
fvm use

# Bootstrap the project (Install all dependencies and link packages)
melos bootstrap
```

---

# Melos Scripts & Commands

The project includes several Melos scripts for easier management:

| Command | Description |
| --- | --- |
| `melos run get` | Run `flutter pub get` in all packages |
| `melos run analyze` | Run `flutter analyze` in all packages |
| `melos run test` | Run `flutter test` in all packages |
| `melos run clean` | Run `flutter clean` in all packages |
| `melos run gen_assets` | Re-generate assets files (using flutter_gen) |
| `melos run gen_l10n` | Generate translation files (l10n) |
| `melos bootstrap` | Install all dependencies and link internal packages |

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
- **FVM** is recommended to maintain Flutter version consistency.
- Use `fvm flutter ...` instead of `flutter ...` if you want to use the project's specific version.

After updating icon or splash images, remember to **run the generate commands again**.

---

# Requirements

- FVM (Flutter Version Management)
- Melos (Monorepo management tool)
- Flutter SDK `3.41.6`
