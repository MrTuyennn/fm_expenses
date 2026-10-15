#!/usr/bin/env bash
# Sanity-check cho store-release.yml + Fastlane + Android signing scaffold
# TRƯỚC khi push. Không build/upload gì thật, không cần secret nào — chỉ
# check cú pháp + load thử lane. Chạy qua `melos run verify_store_release`.
set -euo pipefail
cd "$(dirname "$0")/.."

echo "[1/6] Kiểm tra YAML store-release.yml..."
ruby -ryaml -e "YAML.load_file('.github/workflows/store-release.yml')"

echo "[2/6] Kiểm tra cú pháp Ruby của Fastlane (Android + iOS)..."
ruby -c app/android/fastlane/Fastfile app/android/fastlane/Appfile app/ios/fastlane/Fastfile app/ios/fastlane/Appfile

echo "[3/6] Kiểm tra app/ios/ExportOptions-prod.plist..."
plutil -lint app/ios/ExportOptions-prod.plist

echo "[4/6] Load lane Android (upload_to_play)..."
(cd app/android && bundle install --quiet && FASTLANE_SKIP_UPDATE_CHECK=1 FASTLANE_OPT_OUT_USAGE=1 bundle exec fastlane lanes)

echo "[5/6] Load lane iOS (release_to_testflight)..."
(cd app/ios && bundle install --quiet && FASTLANE_SKIP_UPDATE_CHECK=1 FASTLANE_OPT_OUT_USAGE=1 bundle exec fastlane lanes)

echo "[6/6] Kiểm tra app/android/app/build.gradle.kts vẫn evaluate đúng..."
(cd app/android && ./gradlew :app:tasks --console=plain -q | head -3)

echo "=== ALL CHECKS PASSED ==="
