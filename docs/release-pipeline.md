# Release pipeline: CI/CD + Shorebird + Firebase

Repo này là Melos monorepo; app thật nằm ở `app/` và đã có sẵn 3 flavor trên
cả 2 platform: `dev`, `stag`, `prod` (Android product flavor trong
`app/android/app/build.gradle.kts`, Xcode scheme trong
`app/ios/Runner.xcodeproj`).

Toàn bộ phần dưới đây là **scaffold**: workflow, file config, code Dart đã
đúng cấu trúc và không làm hỏng build hiện tại, nhưng cần tài khoản/thông
tin xác thực (credentials) thật trước khi chạy được thật sự. Hiện tại
**chưa có gì tự động chạy vào service thật cả** — và quan trọng hơn,
**chưa có workflow nào thực sự nộp bản build lên Play Store / App Store**
(xem phần "Thiếu gì để release lên Store" ở cuối).

## Những gì đã được nối sẵn

| File | Vai trò |
|---|---|
| `.github/workflows/ci.yml` | `melos bootstrap`, `analyze`, `test`, format check trên mọi PR và push vào `main`/`dev`/`staging`. Chạy được ngay, không cần setup gì — đã verify xanh ở local (`melos run analyze`, format check, và bước test chỉ chạy `flutter test` ở package nào thật sự có thư mục `test/`, bỏ qua các package còn lại thay vì fail CI vì thiếu test). |
| `.github/workflows/firebase-distribute.yml` | Build APK flavor `dev`/`stag` rồi gửi lên Firebase App Distribution cho tester. Phần Android chạy được ngay khi có Firebase + secret service account (không cần keystore — build type `release` hiện đang ký bằng debug key, đủ dùng để test nội bộ). Job iOS chỉ là placeholder, tự skip tới khi có secret ký Apple. |
| `.github/workflows/shorebird-release.yml` | Chạy tay (`workflow_dispatch`) — tạo bản **release** Shorebird đầu tiên cho 1 flavor/platform/version. Chạy 1 lần cho mỗi version trước khi patch. |
| `.github/workflows/shorebird-patch.yml` | Chạy tay (`workflow_dispatch`) — đẩy 1 bản **patch OTA** lên trên release đã có. Đây là workflow Shorebird dùng hàng ngày. |
| `app/shorebird.yaml` | Config app Shorebird, mỗi flavor 1 `app_id`. Đang là placeholder — xem checklist dưới. |
| `app/lib/firebase/firebase_options_{dev,stag,prod}.dart` | Config Firebase theo từng flavor, đúng format mà FlutterFire CLI xuất ra nên `flutterfire configure --out=...` ghi đè trực tiếp được. Đang là placeholder. |
| `app/lib/firebase/firebase_bootstrap.dart` | Init Firebase + Crashlytics, chặn bằng cờ `kFirebaseConfigured = false`. Chỉ bật `true` khi các file trên đã có giá trị thật. Trước đó nó no-op, `main.dart` chạy đúng như cũ. |

Để `ci.yml` xanh ngay từ đầu, một số lỗi format/lint cũ (không liên quan gì
tới pipeline này) cũng đã được sửa máy móc: format lại
`account_page.dart`/`item_member.dart`/v.v., đổi `__` → `_` ở
`login_page.dart`, xoá 1 import dư ở `user_bloc.dart`, và thêm exclude
`build/**` vào `app/analysis_options.yaml` để cache iOS pod/SPM ở local
không bị lint vào. Không đổi behavior gì.

> **Lưu ý quan trọng:** Shorebird **release/patch** và Firebase **App
> Distribution** không phải là "nộp lên store". Shorebird chỉ tạo
> baseline/patch OTA cho bản đã có; Firebase App Distribution chỉ phân phối
> cho tester nội bộ. Cả hai **không** thay thế được bước build + nộp binary
> lên Play Console / App Store Connect — bước đó vẫn phải làm riêng (xem
> phần cuối).

## Việc cần làm 1 lần (thủ công)

### 1. Shorebird (code push / OTA)

```sh
curl --compressed -o- -L https://raw.githubusercontent.com/shorebirdtech/install/main/install.sh | bash
shorebird login
cd app
shorebird apps create fm-expenses-dev
shorebird apps create fm-expenses-stag
shorebird apps create fm-expenses-prod
```

Dán 3 `app_id` vừa tạo vào `app/shorebird.yaml`.

Cho CI: `shorebird login:ci` tạo ra 1 token — lưu vào GitHub secret
`SHOREBIRD_TOKEN`.

Cách dùng về sau:
- Sắp ra version mới để nộp lên Play/App Store → chạy **Shorebird release**
  (workflow_dispatch) cho flavor/platform đó 1 lần.
- Sửa 1 lỗi Dart-only sau khi đã release → chạy **Shorebird patch**
  (workflow_dispatch). Không cần qua review của store.

### 2. Firebase

Tạo **1** project Firebase (ví dụ `fm-expenses`) rồi đăng ký app cho từng
flavor cần phân phối/theo dõi — project này đã có applicationId Android và
bundle id iOS khác nhau theo flavor, nên chúng map thành các "app" riêng
trong cùng 1 project Firebase:

| Flavor | Android applicationId | iOS bundle id |
|---|---|---|
| dev | `com.example.app.dev` | `com.fm.expense.dev` |
| stag | `com.example.app.stag` | `com.fm.expense.stag` |
| prod | `com.fm.expense` | `com.fm.expense` |

> Lưu ý: ID Android của `dev`/`stag` vẫn còn giữ tiền tố mặc định
> `com.example.app` từ template — nên đổi trước khi release thật, vì
> `com.example.*` sẽ bị Play Store từ chối khi publish production (không
> ảnh hưởng nếu chỉ dùng để test nội bộ).

Sau đó, với mỗi flavor muốn nối thật:

```sh
dart pub global activate flutterfire_cli
flutterfire configure \
  --project=fm-expenses \
  --out=app/lib/firebase/firebase_options_dev.dart \
  --android-package-name=com.example.app.dev \
  --ios-bundle-id=com.fm.expense.dev
# lặp lại cho stag / prod với --out và ID riêng
```

Lệnh này sẽ ghi đè file placeholder bằng key thật, đồng thời tự tải
`google-services.json` / `GoogleService-Info.plist` nếu cần. Sau khi cả 3
flavor xong, bật `kFirebaseConfigured = true` trong
`app/lib/firebase/firebase_bootstrap.dart`.

Cho CI (Firebase App Distribution), tạo 1 service account với quyền
**Firebase App Distribution Admin**, tải file JSON key, rồi:

```sh
base64 -i service-account.json | pbcopy   # dán vào GitHub secret dưới
```

GitHub secrets cần thêm:
- `FIREBASE_SERVICE_ACCOUNT_KEY_BASE64`
- `FIREBASE_ANDROID_APP_ID_DEV`, `FIREBASE_ANDROID_APP_ID_STAG` (là
  "App ID" của Firebase, dạng `1:1234567890:android:abcdef`, lấy ở Project
  settings → Your apps — **không** phải Shorebird app_id, **không** phải
  applicationId)

Trong Firebase Console → App Distribution → Testers & Groups, tạo 2 group
tên `dev-testers` và `stag-testers` (hoặc đổi tên group trong
`firebase-distribute.yml` theo ý bạn).

### 3. Ký code (code signing)

Chưa setup. Build type `release` của Android hiện đang ký bằng debug key
(xem `app/android/app/build.gradle.kts`) — đủ cho test nội bộ qua Firebase
App Distribution nhưng **không đủ** để upload lên Play Store. Khi sẵn sàng:

- **Android**: tạo keystore `.jks`, encode base64, thêm secret
  `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`,
  `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`; viết `signingConfigs.release`
  thật trong `build.gradle.kts` đọc từ file đã decode trong CI.
- **iOS**: export certificate distribution (.p12) và provisioning profile,
  encode base64 cả hai, thêm secret `IOS_DIST_CERTIFICATE_BASE64`,
  `IOS_DIST_CERTIFICATE_PASSWORD`, `IOS_PROVISIONING_PROFILE_BASE64`,
  `APPLE_TEAM_ID`. Khi `IOS_DIST_CERTIFICATE_BASE64` tồn tại, các job iOS
  trong `firebase-distribute.yml` / `shorebird-release.yml` /
  `shorebird-patch.yml` sẽ không tự skip nữa — nhưng mỗi job hiện vẫn chỉ là
  bước placeholder, cần viết thêm lệnh import certificate + `flutter build
  ipa` / `shorebird release ios` thật.

## Đang thiếu gì để CI/CD release THẬT lên Store

Đây là phần quan trọng nhất đang **chưa có**: hiện repo chưa có bất kỳ
workflow nào build + nộp bản build lên Play Console hoặc App Store Connect.
Pipeline đã build ở trên chỉ phục vụ test nội bộ (Firebase) và OTA patch
(Shorebird). Để release thật lên store, cần thêm những thứ sau — phần nào
cần làm thủ công 1 lần (ngoài khả năng của CI) được ghi rõ.

### Android — Google Play Store

| Thiếu | Ghi chú |
|---|---|
| Tài khoản Google Play Console (phí $25 một lần) | Thủ công, phải làm trước tất cả. |
| App đã được tạo trong Play Console, package name khớp applicationId | `com.fm.expense` cho prod — phải tạo app record trong Play Console trước. |
| **Upload thủ công lần đầu tiên** | Google bắt buộc: lần đầu tiên phải upload AAB bằng tay qua Play Console, CI/API chỉ được dùng cho các lần sau. |
| Keystore release thật (`.jks`) | Hiện ký bằng debug key — Play Store sẽ từ chối bản ký debug khi submit production. Xem mục "Ký code" ở trên. |
| Service account cho Google Play Developer API | Tạo trong Google Cloud Console, rồi cấp quyền ở Play Console → Setup → API access, để CI tự upload AAB lên track (internal/alpha/beta/production). |
| Chiến lược tăng `versionCode` | Play Store yêu cầu versionCode tăng dần, không được trùng/giảm giữa các lần nộp — cần quyết định tự tăng ở đâu (CI hay thủ công). |
| 1 workflow mới build + upload AAB | Chưa có file này. Cần `flutter build appbundle --flavor prod` + công cụ upload (phổ biến nhất: Fastlane `fastlane supply`, hoặc Gradle Play Publisher plugin). |
| Metadata/listing trên Play Console | Tên app, mô tả, ảnh chụp màn hình, privacy policy URL, content rating, data safety form — đều điền thủ công, CI không làm được. |

### iOS — App Store

| Thiếu | Ghi chú |
|---|---|
| Tài khoản Apple Developer Program (phí $99/năm) | Thủ công, phải làm trước tất cả. |
| Bundle ID đăng ký trong Apple Developer portal + app record trong App Store Connect | Cho `com.fm.expense` (prod); `dev`/`stag` thường chỉ cần profile development/ad-hoc nếu chỉ test nội bộ. |
| Certificate + Provisioning Profile loại **App Store** (khác loại Ad Hoc dùng cho Firebase App Distribution) | Chưa có certificate nào trong repo. |
| App Store Connect API Key (.p8 + Key ID + Issuer ID) | Dùng để CI tự upload qua `xcrun altool`/`notarytool` hoặc Fastlane `pilot`/`deliver`, an toàn hơn cách dùng Apple ID + app-specific password. |
| 1 workflow mới build + upload IPA | Chưa có file này thật sự chạy được. Cần `ExportOptions.plist` method `app-store`, `flutter build ipa --flavor prod --export-options-plist=...`, rồi upload lên TestFlight/App Store. Các job iOS hiện tại trong `firebase-distribute.yml`/`shorebird-release.yml` mới chỉ là placeholder in ra dòng TODO, chưa build/upload gì cả. |
| Nội dung App Store Connect | Ảnh chụp màn hình, mô tả, privacy policy, export compliance (khai báo mã hoá) — điền thủ công, Fastlane `deliver` có thể set metadata nhưng vẫn cần chuẩn bị nội dung trước. |
| Runner macOS trong CI | Đã khai `runs-on: macos-latest` sẵn trong 3 workflow, nhưng macOS runner của GitHub Actions tính phí cao hơn Linux nhiều — cân nhắc chi phí khi chạy thường xuyên. |

### Việc chung cần quyết định

- Có muốn tôi viết thêm 1 workflow mới (ví dụ `store-release.yml`) để tự
  động build AAB/IPA và upload lên track nội bộ của Play Console/App Store
  Connect không? Cách làm chuẩn và ít rủi ro nhất là qua **Fastlane**
  (`fastlane supply` cho Android, `fastlane pilot`/`deliver` cho iOS) —
  repo hiện chưa có `Fastfile`/`Appfile`.
- Dù có CI tự động upload, **lần nộp đầu tiên lên mỗi store luôn phải làm
  thủ công** (Google bắt buộc; Apple thực tế cũng cần review thủ công lần
  đầu cho export compliance/thông tin app).

## Quy trình hằng ngày khi mọi thứ đã live

1. Push vào `dev` → CI chạy, rồi 1 bản APK tự gửi lên Firebase App
   Distribution cho dev tester.
2. Push vào `staging` → tương tự, cho `stag` tester.
3. Sẵn sàng ra version mới → tăng version trong `app/pubspec.yaml`, chạy
   **Shorebird release** cho `prod` (android, rồi ios khi đã có signing),
   sau đó build + nộp bản đó lên store (xem phần "Thiếu gì" ở trên — hiện
   vẫn phải làm tay hoặc chờ workflow store-release được viết thêm).
4. Phát hiện lỗi Dart-only trên version đã phát hành → chạy **Shorebird
   patch** cho flavor/platform đó. Lên tay người dùng ngay, không cần qua
   review của store.
