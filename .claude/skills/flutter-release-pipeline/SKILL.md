---
name: flutter-release-pipeline
description: Maintain or extend fm_expenses' CI/CD, Shorebird (OTA code push), and Firebase (Crashlytics + App Distribution) setup. Use when asked to touch GitHub Actions workflows, Shorebird release/patch flows, Firebase config, or add a new build flavor.
---

# Flutter release pipeline (CI/CD + Shorebird + Firebase)

This is a Melos monorepo. The shippable app is `app/` with three flavors on
both platforms: `dev`, `stag`, `prod`. Full human-facing setup checklist
(accounts, secrets, commands to run once) lives in
`docs/release-pipeline.md` — read it before doing any setup work, and keep
it in sync with whatever you change here.

## File map

| File | Role |
|---|---|
| `.github/workflows/ci.yml` | Lint/test gate. Runs `melos bootstrap` → `melos run analyze` (reuses the script in root `melos.yaml`) → a test step that runs `flutter test` only in packages with a `test/` directory (most packages have none yet — intentionally skipped rather than failing CI on missing tests; don't "fix" this by writing speculative tests) → format check. |
| `.github/workflows/firebase-distribute.yml` | Push to `dev`/`staging` branch (or manual dispatch) → build APK for that flavor → `firebase appdistribution:distribute`. Android works without a real keystore (release build type currently signs with the debug key — see `app/android/app/build.gradle.kts`). iOS job is gated on `secrets.IOS_DIST_CERTIFICATE_BASE64` existing; it's a stub until then. |
| `.github/workflows/shorebird-release.yml` | Manual dispatch, inputs `flavor` + `platform`. Cuts a new Shorebird release (the full binary patches apply on top of). |
| `.github/workflows/shorebird-patch.yml` | Manual dispatch, inputs `flavor` + `platform`. Pushes an OTA patch. This is the everyday Shorebird action. |
| `app/shorebird.yaml` | `app_id` + `flavors:` map. Currently placeholders (`TODO_REPLACE_...`) until real Shorebird apps are created. |
| `app/lib/firebase/firebase_options_{dev,stag,prod}.dart` | Per-flavor `DefaultFirebaseOptions`, shaped to match FlutterFire CLI output so `flutterfire configure --out=<this path>` overwrites cleanly. Currently placeholders. |
| `app/lib/firebase/firebase_bootstrap.dart` | `initializeFirebase()` called from `app/lib/main.dart`. Gated by `kFirebaseConfigured` (currently `false` → no-op). Flip it to `true` only after all three `firebase_options_*.dart` files have real values, or the app will crash on startup with placeholder API keys. |

`docs/release-pipeline.md` is written in Vietnamese (the user's preference)
and includes a "Đang thiếu gì để CI/CD release THẬT lên Store" section
listing everything still needed for an actual Play Store / App Store
submission (Play Console account + first manual upload + real keystore +
Play Developer API service account on Android; Apple Developer account +
App Store certs/profile + App Store Connect API key on iOS). Keep that
section in sync if you add signing or a store-upload workflow.

## Known gaps — don't assume these are done

- **No store-submission workflow exists at all.** Everything built so far only covers internal testing (Firebase App Distribution) and OTA patches (Shorebird release/patch) — neither of those uploads a binary to Play Console or App Store Connect. A `store-release.yml` (Fastlane-based is the standard, low-risk choice: `fastlane supply` for Android, `fastlane pilot`/`deliver` for iOS) has not been written. Don't assume "Shorebird release" means "shipped to the store" — it doesn't.

- No real Shorebird apps/tokens exist yet (`app_id` placeholders in `shorebird.yaml`, no `SHOREBIRD_TOKEN` secret).
- No real Firebase project exists yet (placeholder keys, no `FIREBASE_*` secrets).
- No Android release keystore — release builds use the debug signing config. Fine for Firebase App Distribution, **not** fine for a Play Store upload.
- No iOS distribution certificate/provisioning profile — all iOS jobs in the three workflows above are stubs gated on `secrets.IOS_DIST_CERTIFICATE_BASE64`.
- `app/android/app/build.gradle.kts` has a pre-existing inconsistency: `dev`/`stag` flavors inherit the default `applicationId = "com.example.app"` + suffix, while `prod` overrides to `com.fm.expense`. This means dev/stag Android IDs are still `com.example.app.dev` / `.stag`, not `com.fm.expense.dev` / `.stag` like iOS. Flag this to the user if it becomes relevant (e.g. when registering Firebase Android apps) rather than silently fixing it — it may be intentional.
- Root `melos.yaml`'s own `test` script (`melos run test` = `melos exec -- "flutter test"`) fails today because 17 of 18 packages have no `test/` directory — this is a pre-existing gap in the repo, not something this pipeline introduced. `ci.yml` intentionally does NOT call that script directly; it uses the skip-if-missing variant described above instead.
- `shared/config/lib/app_evn.dart` only defines `Flavor.stage`/`Flavor.production` (two values), while the native side has three flavors (`dev`/`stag`/`prod`). A `FLAVOR=dev` dart-define currently falls back silently to the `production` endpoint inside `Env.of()`. The Firebase flavor selector in `firebase_bootstrap.dart` reads the raw `FLAVOR` dart-define directly (not `Env.flavor`) specifically to avoid being broken by this, but it's worth flagging to the user — it looks like an existing bug, not something introduced by this pipeline.

## Common tasks

**Add a new flavor** (e.g. `uat`): add the Android product flavor + iOS scheme/xcconfig first (outside this skill's scope), then: add a `firebase_options_<flavor>.dart` stub matching the existing three, add a case in `firebase_bootstrap.dart`'s switch, add the flavor to `shorebird.yaml`'s `flavors:` map, add it to the `options:` choice lists in the two `shorebird-*.yml` workflow inputs.

**Add a new GitHub secret**: document it in the relevant table in `docs/release-pipeline.md` at the same time — that file is the only place secrets are enumerated for a human to go create them.

**Debug a failing Shorebird patch/release job**: the job installs Shorebird CLI fresh every run (`curl ... install.sh`) and reads `SHOREBIRD_TOKEN` from secrets — if auth fails, that's the first thing to check, not the Dart code. `shorebird patch` requires a prior `shorebird release` for the same flavor/platform/version to exist; "no releases found" errors mean release first.

**Turning Firebase on for real**: once `flutterfire configure` has been run for all three flavors (see `docs/release-pipeline.md`), flip `kFirebaseConfigured = true` in `firebase_bootstrap.dart`. Don't flip it while any `firebase_options_*.dart` still contains `TODO_REPLACE_VIA_FLUTTERFIRE_CONFIGURE` — `Firebase.initializeApp` will throw at startup.

**Verifying changes to this pipeline compile**: there's no way to actually run the GitHub Actions workflows locally, but always run `fvm flutter analyze lib/main.dart lib/firebase` and `fvm flutter pub get` from `app/` after touching the Firebase Dart files, since a typo there breaks `flutter run` for everyone, unlike a workflow YAML mistake which only breaks CI.
