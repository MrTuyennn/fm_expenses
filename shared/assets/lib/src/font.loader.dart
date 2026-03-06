import 'package:flutter/services.dart';

import 'assets.gen.dart';
import 'fonts.gen.dart';

Future<void> _loadFontByteData(
  String familyWithVariantString,
  Future<ByteData?>? byteData,
) async {
  if (byteData == null) return;
  final fontData = await byteData;
  if (fontData == null) return;

  final fontLoader = FontLoader(familyWithVariantString)
    ..addFont(Future.value(fontData));
  await fontLoader.load();
}

Future<void> loadFontIfNecessary() async {
  Future<void> loadFromRootBundle(
    String familyWithVariantString,
    String fontPath,
  ) async {
    final byteData = rootBundle.load(fontPath);
    return _loadFontByteData(familyWithVariantString, byteData);
  }

  await Future.wait(
    [
      ResAssets.fonts.quicksandBold,
      ResAssets.fonts.quicksandLight,
      ResAssets.fonts.quicksandMedium,
      ResAssets.fonts.quicksandRegular,
      ResAssets.fonts.quicksandSemiBold,
    ].map((e) => loadFromRootBundle(FontFamily.quicksand, e)).toList(),
  );
  await Future.wait(
    [
      ResAssets.fonts.resIcons,
    ].map((e) => loadFromRootBundle(FontFamily.resIcons, e)).toList(),
  );
}

