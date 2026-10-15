# Release pipeline: CI/CD + Shorebird + Firebase + Store release

Repo này là Melos monorepo; app thật nằm ở `app/` và đã có sẵn 3 flavor trên
cả 2 platform: `dev`, `stag`, `prod` (Android product flavor trong
`app/android/app/build.gradle.kts`, Xcode scheme trong
`app/ios/Runner.xcodeproj`).

Toàn bộ phần dưới đây là **scaffold**: workflow, file config, code Dart/Kotlin
đã đúng cấu trúc và không làm hỏng build hiện tại (đã build-test local), nhưng
cần tài khoản/credential thật trước khi chạy ra kết quả thật. Phần
["Checklist triển khai"](#checklist-triển-khai-theo-thứ-tự) ở cuối file là
nơi bắt đầu nếu bạn muốn làm theo thứ tự, từng bước, có lệnh cụ thể.

Quy ước trong toàn bộ file: `$VALUE` nghĩa là "điền giá trị thật của bạn vào
đây", không phải biến môi trường cần export.

## Những gì đã được nối sẵn

| File | Vai trò |
|---|---|
| `.github/workflows/ci.yml` | `melos bootstrap`, `analyze`, `test`, format check trên mọi PR và push vào `main`/`dev`/`staging`. Chạy được ngay, không cần setup gì. |
| `.github/workflows/firebase-distribute.yml` | Build APK flavor `dev`/`stag` rồi gửi lên Firebase App Distribution cho tester. Phần Android chạy được ngay khi có Firebase + secret service account (ký bằng debug key — đủ cho test nội bộ). Job iOS chỉ là placeholder, tự skip tới khi có secret ký Apple. |
| `.github/workflows/shorebird-release.yml` | Chạy tay (`workflow_dispatch`) — tạo bản **release** Shorebird đầu tiên cho 1 flavor/platform/version. Chạy 1 lần cho mỗi version trước khi patch. |
| `.github/workflows/shorebird-patch.yml` | Chạy tay (`workflow_dispatch`) — đẩy 1 bản **patch OTA** lên trên release đã có. Dùng hàng ngày cho lỗi Dart-only. |
| `.github/workflows/store-release.yml` | Chạy tay (`workflow_dispatch`) — build flavor `prod` rồi dùng **Fastlane** nộp lên Play Console (track `internal`) hoặc TestFlight. Tự skip (in warning) khi chưa có secret — chạy test ngay bây giờ được. |
| `app/shorebird.yaml` | Config app Shorebird, mỗi flavor 1 `app_id`. Đang là placeholder. |
| `app/lib/firebase/firebase_options_{dev,stag,prod}.dart` | Config Firebase theo từng flavor, đúng format FlutterFire CLI xuất ra. Đang là placeholder. |
| `app/lib/firebase/firebase_bootstrap.dart` | Init Firebase + Crashlytics, chặn bằng cờ `kFirebaseConfigured = false`. Chỉ bật `true` khi các file trên có giá trị thật. |
| `app/android/key.properties.example` + `app/android/app/build.gradle.kts` | Scaffold ký release Android thật: nếu `app/android/key.properties` tồn tại (gitignored, CI tự viết từ secret) thì ký bằng keystore đó; không có thì fallback về debug key như trước. Đã build-test cả 2 nhánh local. |
| `app/android/{Gemfile,Gemfile.lock,fastlane/}`, `app/ios/{Gemfile,Gemfile.lock,fastlane/}` | `Fastfile`/`Appfile` cho lane `upload_to_play` (Android, dùng `fastlane supply`) và `release_to_testflight` (iOS, dùng `fastlane pilot` + App Store Connect API key). `Gemfile`/`Gemfile.lock` pin version fastlane — xem mục [Fastlane](#fastlane-cách-hoạt-động--test-local) ngay dưới. |
| `app/ios/ExportOptions-prod.plist` | Dùng cho `flutter build ipa --export-options-plist=...`. `signingStyle` đang là `automatic` vì chưa có provisioning profile App Store thật. |

> **Phân biệt 3 khái niệm hay nhầm:** Shorebird release/patch = tạo
> baseline/patch **OTA** (chỉ code Dart, không qua store review). Firebase
> App Distribution = phân phối cho **tester nội bộ**, không phải public.
> `store-release.yml` = nộp bản build **thật** lên Play Console / App Store
> Connect cho người dùng thật — đây mới là "lên store".

Để `ci.yml` xanh ngay từ đầu, một số lỗi format/lint cũ (không liên quan gì
tới pipeline này) cũng đã được sửa máy móc: format lại
`account_page.dart`/`item_member.dart`/v.v., đổi `__` → `_` ở
`login_page.dart`, xoá 1 import dư ở `user_bloc.dart`, và thêm exclude
`build/**` vào `app/analysis_options.yaml`. Không đổi behavior gì.

> **Bug đã fix (ảnh hưởng cả 5 workflow, có từ trước chứ không phải do phần
> store-release mới thêm):** `melos.yaml` khai `sdkPath: .fvm/flutter_sdk`
> để dev local dùng đúng bản Flutter ghim bởi FVM, nhưng `.fvm/` bị
> gitignore nên không tồn tại trên GitHub Actions runner — khiến **mọi**
> lệnh `melos` (ở cả `ci.yml`, `firebase-distribute.yml`,
> `shorebird-release.yml`, `shorebird-patch.yml`, `store-release.yml`) fail
> ngay với lỗi `melos.yaml: SDK path is not valid`. Đã fix bằng 1 step mới
> ngay sau `subosito/flutter-action@v2` ở cả 5 file, tự tạo lại symlink đó
> trỏ vào đúng bản Flutter mà action vừa cài (cùng version `.fvmrc`):
> ```yaml
> - name: Point .fvm/flutter_sdk at the installed Flutter (required by melos.yaml sdkPath)
>   run: |
>     mkdir -p .fvm
>     ln -sfn "$(dirname "$(dirname "$(command -v flutter)")")" .fvm/flutter_sdk
> ```
> Đã test lại bằng cách mô phỏng đúng tình huống này ở local (xoá symlink,
> tạo lại bằng chính lệnh trên) — `melos` chạy qua được, không còn lỗi SDK
> path.

## Lệnh chạy nhanh (cheat sheet)

### 1. Chạy CI local trước khi push (y hệt `ci.yml`)

Chạy lần lượt (dừng ngay khi 1 bước fail, đỡ phải chờ GitHub Actions mới biết
lỗi format/lint/test):

```sh
dart pub global activate melos   # chỉ cần chạy 1 lần/máy
melos bootstrap
melos run analyze
melos exec --no-fail-fast -- 'if [ -d test ]; then flutter test; else echo "(no test/ directory, skipping)"; fi'
melos exec -- "dart format --output=none --set-exit-if-changed ."
```

Gộp thành 1 lệnh duy nhất (dùng `&&`, dừng ở bước đầu tiên fail):

```sh
melos bootstrap && melos run analyze && melos exec --no-fail-fast -- 'if [ -d test ]; then flutter test; else echo "(no test/ directory, skipping)"; fi' && melos exec -- "dart format --output=none --set-exit-if-changed ."
```

### 2. Trigger workflow CD từ terminal (cần GitHub CLI)

Cài & đăng nhập 1 lần:
```sh
brew install gh
gh auth login
```

Mỗi workflow `workflow_dispatch` chạy bằng `gh workflow run <file> -f <input>=<value>`
— tên input phải khớp đúng cái khai trong file:

```sh
# Firebase App Distribution — input: flavor (dev|stag)
gh workflow run firebase-distribute.yml -f flavor=dev

# Shorebird release — input: flavor (dev|stag|prod), platform (android|ios)
gh workflow run shorebird-release.yml -f flavor=prod -f platform=android
gh workflow run shorebird-release.yml -f flavor=prod -f platform=ios

# Shorebird patch — input: flavor, platform (giống trên)
gh workflow run shorebird-patch.yml -f flavor=prod -f platform=android

# Store release — input: platform (android|ios)
gh workflow run store-release.yml -f platform=android
gh workflow run store-release.yml -f platform=ios
```

Theo dõi run vừa bấm:
```sh
gh run list --limit 5        # xem run nào mới chạy, lấy run id
gh run watch                 # theo dõi run gần nhất, live log
gh run view --log            # xem log đầy đủ sau khi chạy xong
```

### 3. Lệnh tổng hợp: CI local + toàn bộ CD cho 1 lần ra version `prod` mới

Thứ tự này khớp với mục ["Quy trình hằng ngày"](#quy-trình-hằng-ngày-khi-mọi-thứ-đã-live)
ở cuối file — **Store release không bắt buộc phải chờ Shorebird release xong
mới chạy được** (2 workflow độc lập), nhưng chạy theo thứ tự này cho dễ theo
dõi và khớp cùng 1 version:

```sh
set -e

# 1) CI local — fail sớm, không tốn phút Actions nếu lint/test/format sai
melos bootstrap
melos run analyze
melos exec --no-fail-fast -- 'if [ -d test ]; then flutter test; else echo "(no test/ directory, skipping)"; fi'
melos exec -- "dart format --output=none --set-exit-if-changed ."

# 2) Push — CI thật (ci.yml) chạy trên GitHub, kèm Firebase distribute nếu push vào dev/staging
git push

# 3) Shorebird release cho bản prod, cả 2 platform
gh workflow run shorebird-release.yml -f flavor=prod -f platform=android
gh workflow run shorebird-release.yml -f flavor=prod -f platform=ios

# 4) Store release — nộp lên Play Console (internal track) / TestFlight
gh workflow run store-release.yml -f platform=android
gh workflow run store-release.yml -f platform=ios
```

Lưu lại thành `scripts/release-prod.sh` nếu muốn chạy lại nhiều lần — xem
[Checklist triển khai](#checklist-triển-khai-theo-thứ-tự) để biết secret nào
cần có trước khi bước 3–4 ra kết quả thật (thiếu secret thì job tự skip với
warning, không lỗi).

## Fastlane: cách hoạt động & test local

[Fastlane](https://fastlane.tools) là tool Ruby dùng để build/upload app lên
store bằng 1 lệnh thay vì làm tay qua giao diện Play Console/Xcode Organizer.
Repo có 2 bộ riêng — **không chung 1 Fastlane cho cả 2 platform** vì Android
và iOS cần gem/action khác nhau:

```
app/android/
  Gemfile          # pin version fastlane cho Android
  Gemfile.lock     # version đã resolve, commit vào git để CI dùng y hệt local
  fastlane/
    Appfile        # package_name + đường dẫn tới service account JSON (đọc từ env)
    Fastfile        # định nghĩa lane `upload_to_play`

app/ios/
  Gemfile, Gemfile.lock, fastlane/Appfile, fastlane/Fastfile  # tương tự, lane `release_to_testflight`
```

`Gemfile`/`Gemfile.lock` tồn tại để **pin đúng 1 version fastlane** — không
có file này, mỗi lần CI chạy `gem install fastlane` sẽ tải version mới nhất
tại thời điểm đó, dễ bất ngờ gãy khi fastlane ra bản mới không tương thích.
`store-release.yml` dùng `bundler-cache: true` của action `ruby/setup-ruby`,
tự chạy `bundle install` và cache lại, rồi gọi `bundle exec fastlane ...`.

Biến môi trường mỗi lane cần (đã khai trong `store-release.yml`, chỉ ghi lại
đây để tham khảo khi test local):

| Lane | Biến môi trường | Ý nghĩa |
|---|---|---|
| `android upload_to_play` | `ANDROID_AAB_PATH` | Đường dẫn file `.aab` đã build sẵn. |
| | `PLAY_TRACK` | Track Play Console, mặc định `internal` nếu bỏ trống. |
| | `ANDROID_PACKAGE_NAME` | applicationId, mặc định `com.fm.expense` nếu bỏ trống (xem `Appfile`). |
| | `PLAY_SERVICE_ACCOUNT_JSON` | Đường dẫn file JSON service account (đã decode từ secret). |
| `ios release_to_testflight` | `IOS_IPA_PATH` | Đường dẫn file `.ipa` đã build sẵn. |
| | `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY_PATH` | 3 phần của App Store Connect API key — xem [mục 4.5](#45-app-store-connect-api-key). |

### Cài & test local trước khi đụng tới CI

Có máy Mac với Ruby sẵn (kiểm tra `ruby -v`, cần ≥ 3.0; fastlane sẽ sớm yêu
cầu ≥ 3.3) là cài được, không cần máy CI:

```sh
cd app/android        # hoặc app/ios
bundle install         # đọc Gemfile, cài đúng version đã lock trong Gemfile.lock
bundle exec fastlane lanes   # list lane có trong Fastfile, không chạy gì — dùng để kiểm tra Fastfile parse đúng cú pháp
```

Chạy thử 1 lane thật ở local (cần đã có AAB/IPA build sẵn và credential
thật — hữu ích để debug lỗi `supply`/`pilot` nhanh hơn là debug qua CI):

```sh
cd app/android
ANDROID_AAB_PATH=../build/app/outputs/bundle/prodRelease/app-prod-release.aab \
PLAY_SERVICE_ACCOUNT_JSON=/duong/dan/toi/play-sa.json \
PLAY_TRACK=internal \
bundle exec fastlane upload_to_play
```

```sh
cd app/ios
IOS_IPA_PATH=../build/ios/ipa/ten-file.ipa \
APP_STORE_CONNECT_KEY_ID=$KEY_ID \
APP_STORE_CONNECT_ISSUER_ID=$ISSUER_ID \
APP_STORE_CONNECT_API_KEY_PATH=/duong/dan/toi/AuthKey_XXXX.p8 \
bundle exec fastlane release_to_testflight
```

Sau khi sửa `Fastfile`/`Appfile`, cập nhật lại lockfile rồi commit cả 2 file:
```sh
bundle lock   # ghi lại Gemfile.lock nếu vừa đổi version trong Gemfile
```

> **Lưu ý đặt tên lane:** đừng đặt lane trùng tên action built-in của
> fastlane (ví dụ `upload_to_testflight` là alias có sẵn của action
> `pilot`) — fastlane vẫn chạy được nhưng in warning "Name of the lane ...
> is already taken by the action...". Đây là lý do lane iOS trong repo đặt
> tên `release_to_testflight` thay vì `upload_to_testflight`.

## Cách set GitHub secret

Hai cách, chọn 1:

**Cách A — GitHub CLI (`gh`)**, nhanh, dùng được trong mọi lệnh ví dụ ở dưới:

```sh
# cài nếu chưa có (macOS)
brew install gh
gh auth login
```

Set 1 secret dạng text:
```sh
gh secret set TEN_SECRET --body "gia-tri-thuc"
```

Set 1 secret dạng file (ví dụ đã base64-encode 1 file nhị phân):
```sh
base64 -i duong/dan/file | gh secret set TEN_SECRET
```

**Cách B — Giao diện web**: repo trên GitHub → **Settings → Secrets and
variables → Actions → New repository secret** → điền `Name` + `Value` → Add
secret. Dùng cách này nếu không muốn cài `gh`.

Kiểm tra đã set đủ secret chưa (chỉ thấy tên, không thấy giá trị):
```sh
gh secret list
```

---

## 1. Shorebird (code push / OTA)

**Cần:** tài khoản Shorebird (free), 3 app Shorebird (1/flavor), 1 token cho CI.

```sh
curl --compressed -o- -L https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh | bash
shorebird login
cd app
shorebird apps create fm-expenses-dev
shorebird apps create fm-expenses-stag
shorebird apps create fm-expenses-prod
```

Mỗi lệnh `apps create` in ra 1 `app_id` — mở `app/shorebird.yaml` và thay 3
dòng `TODO_REPLACE_WITH_...` bằng `app_id` tương ứng (field `app_id` ở đầu
file dùng id của `prod`, còn `flavors:` map đủ cả 3).

Tạo token cho CI, rồi set secret:
```sh
shorebird login:ci
# lệnh trên in ra 1 token — copy giá trị đó, chạy tiếp:
gh secret set SHOREBIRD_TOKEN --body "$TOKEN_VUA_COPY"
```

**Dùng về sau:**
- Sắp ra version mới để nộp lên Play/App Store → chạy workflow **Shorebird
  release** (GitHub → Actions → Shorebird release → Run workflow) cho
  flavor/platform đó 1 lần.
- Sửa 1 lỗi Dart-only sau khi đã release → chạy workflow **Shorebird patch**.
  Lên tay người dùng ngay, không cần qua review của store.

---

## 2. Firebase (test nội bộ + crash report)

**Cần:** 1 project Firebase, app con cho mỗi flavor, 1 service account cho CI.

Project này có applicationId Android và bundle id iOS khác nhau theo flavor,
map thành các "app" riêng trong cùng 1 project Firebase:

| Flavor | Android applicationId | iOS bundle id |
|---|---|---|
| dev | `com.example.app.dev` | `com.fm.expense.dev` |
| stag | `com.example.app.stag` | `com.fm.expense.stag` |
| prod | `com.fm.expense` | `com.fm.expense` |

> `com.example.app.*` của dev/stag vẫn còn tiền tố mặc định từ template —
> đổi trước khi release thật (`com.example.*` bị Play Store từ chối khi
> publish production); không ảnh hưởng nếu chỉ test nội bộ.

### 2.1. Tạo project + app con

1. https://console.firebase.google.com → Add project → đặt tên (ví dụ
   `fm-expenses`).
2. Trong project đó, Add app 6 lần (3 flavor × 2 platform), dùng đúng
   applicationId/bundle id ở bảng trên cho từng app.

### 2.2. Sinh config thật cho Dart

```sh
dart pub global activate flutterfire_cli
flutterfire configure \
  --project=fm-expenses \
  --out=app/lib/firebase/firebase_options_dev.dart \
  --android-package-name=com.example.app.dev \
  --ios-bundle-id=com.fm.expense.dev
```
Lặp lại cho `stag`/`prod`, đổi `--out` và 2 id. Lệnh này ghi đè file
placeholder bằng key thật, tự tải `google-services.json` /
`GoogleService-Info.plist` nếu cần.

Sau khi cả 3 flavor xong, mở `app/lib/firebase/firebase_bootstrap.dart`, đổi
`kFirebaseConfigured = false` → `true`.

### 2.3. Service account cho CI

1. Firebase Console → ⚙️ Project settings → Service accounts → Generate new
   private key → tải file JSON (ví dụ lưu là `firebase-sa.json`).
2. Set secret:
```sh
base64 -i firebase-sa.json | gh secret set FIREBASE_SERVICE_ACCOUNT_KEY_BASE64
```
3. Firebase Console → Project settings → General → cuộn xuống "Your apps" →
   với mỗi app Android dev/stag, copy **App ID** (dạng
   `1:1234567890:android:abcdef...`, **không phải** applicationId,
   **không phải** Shorebird app_id):
```sh
gh secret set FIREBASE_ANDROID_APP_ID_DEV --body "1:...:android:..."
gh secret set FIREBASE_ANDROID_APP_ID_STAG --body "1:...:android:..."
```
4. Firebase Console → App Distribution → Testers & Groups → New group → tạo
   2 group tên đúng `dev-testers` và `stag-testers` (hoặc đổi tên group
   trong `firebase-distribute.yml` cho khớp nếu bạn muốn tên khác).

Từ giờ, push vào `dev`/`staging` sẽ tự build APK và gửi cho tester trong 2
group đó.

---

## 3. Android — ký release thật + nộp Play Store

**Cần:** keystore `.jks` thật, Play Console account, service account cho
Play Developer API.

### 3.1. Tạo keystore

```sh
cd app/android/app
keytool -genkeypair -v \
  -keystore release.jks \
  -alias fm_expenses_prod \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -storepass "$CHON_1_PASSWORD_MANH" \
  -keypass "$CHON_1_PASSWORD_MANH_KHAC"
```
Trả lời các câu hỏi CN/OU/O/L/S/C bất kỳ (không ảnh hưởng chức năng). **Lưu
file `release.jks` + 2 password này ở nơi an toàn (password manager) — mất là
không tạo lại được, và Google không cho đổi keystore của 1 app đã publish.**

### 3.2. Set secret cho CI

```sh
cd app/android/app
base64 -i release.jks | gh secret set ANDROID_KEYSTORE_BASE64
gh secret set ANDROID_KEYSTORE_PASSWORD --body "$CHON_1_PASSWORD_MANH"
gh secret set ANDROID_KEY_ALIAS --body "fm_expenses_prod"
gh secret set ANDROID_KEY_PASSWORD --body "$CHON_1_PASSWORD_MANH_KHAC"
rm release.jks   # xoá bản local, CI sẽ tự decode lại từ secret mỗi lần chạy
```

(Muốn test build ký release ở máy local trước khi đụng CI: copy
`app/android/key.properties.example` thành `app/android/key.properties`
trong `app/android/`, điền 4 giá trị trên, chạy
`flutter build apk --flavor prod --release` trong `app/` — file này đã
gitignore nên không bao giờ bị commit nhầm.)

### 3.3. Tạo app trong Play Console + service account

1. https://play.google.com/console → trả $25 (1 lần, nếu chưa có account
   developer) → Create app → package name `com.fm.expense`, điền tên/mô
   tả/ngôn ngữ cơ bản.
2. **Upload bản AAB đầu tiên bằng tay** (Google bắt buộc, CI chỉ dùng được từ
   lần 2): build 1 AAB có ký (dùng chính `release.jks` ở bước 3.1):
   ```sh
   cd app
   flutter build appbundle --flavor prod --dart-define=FLAVOR=prod --release
   ```
   rồi vào Play Console → app vừa tạo → Testing → Internal testing → Create
   new release → upload file
   `app/build/app/outputs/bundle/prodRelease/app-prod-release.aab`.
3. Điền metadata bắt buộc (Play Console sẽ dẫn bạn qua từng bước): tên app,
   mô tả ngắn/dài, ít nhất 2 ảnh chụp màn hình, icon, privacy policy URL,
   content rating questionnaire, data safety form. Phần này không tự động
   hoá được, phải làm tay.
4. Tạo service account cho API: Google Cloud Console (link có sẵn ở Play
   Console → Setup → **API access**) → chọn project liên kết với app (hoặc
   tạo mới) → IAM & Admin → Service Accounts → Create service account (ví
   dụ tên `play-deploy-ci`) → Keys → Add key → Create new key → JSON → tải
   file (ví dụ `play-sa.json`).
5. Quay lại Play Console → Setup → **API access** → tìm service account vừa
   tạo → Grant access → cấp quyền ít nhất: "View app information", "Manage
   production releases" hoặc đủ để upload lên track `internal` (tick phần
   release cho track bạn dùng).
6. Set secret:
   ```sh
   base64 -i play-sa.json | gh secret set PLAY_SERVICE_ACCOUNT_JSON_BASE64
   rm play-sa.json
   ```

Sau bước này, chạy workflow **Store release** chọn platform `android` sẽ tự
build AAB (build number = số run của GitHub Actions) và upload lên track
`internal` bằng `fastlane supply`.

---

## 4. iOS — ký App Store + nộp TestFlight

**Cần:** Apple Developer Program account, certificate + provisioning profile
loại **App Store** (khác loại Ad Hoc đang dùng cho Firebase App
Distribution), App Store Connect API key.

### 4.1. Tạo certificate

1. Trên Mac: mở **Keychain Access** → menu Certificate Assistant → Request a
   Certificate From a Certificate Authority → điền email, Common Name, chọn
   "Saved to disk" → lưu file `CertificateSigningRequest.certSigningRequest`.
2. https://developer.apple.com/account → Certificates, Identifiers & Profiles
   → Certificates → nút `+` → chọn **Apple Distribution** → upload file CSR
   ở bước 1 → Download file `.cer` vừa tạo.
3. Double-click file `.cer` để import vào Keychain Access.
4. Trong Keychain Access, tìm certificate vừa import (danh mục "My
   Certificates"), chuột phải → Export → chọn định dạng `.p12`, đặt 1
   password (đây là `IOS_APPSTORE_CERTIFICATE_PASSWORD`) → lưu thành
   `distribution.p12`.

### 4.2. Tạo provisioning profile

1. Cùng trang Certificates, Identifiers & Profiles → Identifiers → đảm bảo
   bundle id `com.fm.expense` đã được đăng ký (tạo mới nếu chưa).
2. Profiles → `+` → chọn **App Store** (dưới mục Distribution) → chọn App ID
   `com.fm.expense` → chọn certificate vừa tạo ở 4.1 → đặt tên profile rõ
   ràng, ví dụ `fm-expenses-prod-appstore` → Generate → Download file
   `.mobileprovision`.

### 4.3. Set secret + cập nhật ExportOptions

```sh
base64 -i distribution.p12 | gh secret set IOS_APPSTORE_CERTIFICATE_BASE64
gh secret set IOS_APPSTORE_CERTIFICATE_PASSWORD --body "$PASSWORD_DAT_O_BUOC_4.1"
base64 -i fm-expenses-prod-appstore.mobileprovision | gh secret set IOS_APPSTORE_PROVISIONING_PROFILE_BASE64
```

Lấy đúng tên profile (field `Name` bên trong file, phải khớp 100% ký tự với
tên đặt ở bước 4.2):
```sh
security cms -D -i fm-expenses-prod-appstore.mobileprovision | plutil -extract Name xml1 -o - -
```

Mở `app/ios/ExportOptions-prod.plist`, đổi:
```xml
<key>signingStyle</key>
<string>automatic</string>
```
thành:
```xml
<key>signingStyle</key>
<string>manual</string>
<key>provisioningProfiles</key>
<dict>
	<key>com.fm.expense</key>
	<string>fm-expenses-prod-appstore</string>
</dict>
```
(thay `fm-expenses-prod-appstore` bằng tên thật lấy được ở trên nếu khác).

### 4.4. App record trong App Store Connect

1. https://appstoreconnect.apple.com → My Apps → `+` → New App → bundle id
   `com.fm.expense`, điền tên app, SKU (tuỳ ý, ví dụ `fm-expenses-prod`).
2. Điền các mục bắt buộc trước khi submit thật (không bắt buộc để test
   TestFlight nội bộ, nhưng bắt buộc nếu sau này submit App Store review):
   ảnh chụp màn hình, mô tả, privacy policy URL, export compliance (khai báo
   có dùng mã hoá hay không — app thường thì chọn "No" nếu không tự implement
   encryption riêng).

### 4.5. App Store Connect API key

1. App Store Connect → Users and Access → Integrations tab → Keys → `+` →
   đặt tên, chọn role **App Manager** (đủ quyền upload TestFlight) →
   Generate.
2. Trang kết quả hiện **Key ID** và **Issuer ID** (copy cả 2, hiện mãi ở
   trang Integrations, xem lại được), và cho tải file `.p8` **đúng 1 lần
   duy nhất** — tải ngay, không tải lại được.
3. Set secret:
```sh
gh secret set APP_STORE_CONNECT_KEY_ID --body "$KEY_ID"
gh secret set APP_STORE_CONNECT_ISSUER_ID --body "$ISSUER_ID"
base64 -i AuthKey_XXXXXXXXXX.p8 | gh secret set APP_STORE_CONNECT_API_KEY_BASE64
```

Sau bước này, chạy workflow **Store release** chọn platform `ios` sẽ tự
build IPA (build number = số run của GitHub Actions) và upload lên
TestFlight bằng `fastlane pilot`. Lưu ý job này chạy trên `macos-latest`
(tính phí runner cao hơn Linux).

---

## Checklist triển khai (theo thứ tự)

Làm theo thứ tự này nếu muốn đi từ đầu đến khi `store-release.yml` chạy ra
kết quả thật. Mỗi dòng trỏ vào mục chi tiết ở trên.

- [ ] **Test workflow ngay bây giờ (không cần gì cả):** GitHub → Actions →
  **Store release** → Run workflow → chọn platform. Job sẽ rơi vào nhánh
  `*-not-configured`, in 1 warning, không build/upload gì — xác nhận
  workflow tồn tại và chạy được trước khi điền credential thật.
- [ ] [1. Shorebird](#1-shorebird-code-push--ota) — `SHOREBIRD_TOKEN` +
  3 app_id trong `app/shorebird.yaml`.
- [ ] [2. Firebase](#2-firebase-test-nội-bộ--crash-report) —
  `FIREBASE_SERVICE_ACCOUNT_KEY_BASE64`, 2× `FIREBASE_ANDROID_APP_ID_*`, 2
  tester group, 3 flavor config Dart + `kFirebaseConfigured = true`.
- [ ] Đổi applicationId `com.example.app.dev`/`.stag` sang domain thật của
  bạn (không bắt buộc để test nội bộ, bắt buộc trước khi publish production
  thật — Play Store từ chối `com.example.*`).
- [ ] [3. Android](#3-android--ký-release-thật--nộp-play-store) — Play
  Console account + app record, `ANDROID_KEYSTORE_BASE64/PASSWORD`,
  `ANDROID_KEY_ALIAS/PASSWORD`, upload AAB đầu tay 1 lần,
  `PLAY_SERVICE_ACCOUNT_JSON_BASE64`.
- [ ] [4. iOS](#4-ios--ký-app-store--nộp-testflight) — Apple Developer
  account, certificate + profile App Store,
  `IOS_APPSTORE_CERTIFICATE_BASE64/PASSWORD`,
  `IOS_APPSTORE_PROVISIONING_PROFILE_BASE64`, sửa `ExportOptions-prod.plist`,
  app record App Store Connect, `APP_STORE_CONNECT_API_KEY_BASE64/KEY_ID/ISSUER_ID`.
- [ ] `gh secret list` để soát lại đủ secret chưa.
- [ ] Chạy thật: Actions → **Store release** → Run workflow → `android` (và
  /hoặc `ios`) → theo dõi log.

## Quy trình hằng ngày khi mọi thứ đã live

1. Push vào `dev` → CI chạy, rồi 1 bản APK tự gửi lên Firebase App
   Distribution cho dev tester.
2. Push vào `staging` → tương tự, cho `stag` tester.
3. Sẵn sàng ra version mới → tăng phần `x.y.z` trong `version:` của
   `app/pubspec.yaml` (không cần sửa build number sau `+`, vì
   `store-release.yml` tự dùng `github.run_number`), chạy **Shorebird
   release** cho `prod`, rồi chạy **Store release** (chọn platform) để build
   + nộp lên Play Console track `internal` / TestFlight.
4. Phát hiện lỗi Dart-only trên version đã phát hành → chạy **Shorebird
   patch** cho flavor/platform đó. Lên tay người dùng ngay, không cần qua
   review của store.
