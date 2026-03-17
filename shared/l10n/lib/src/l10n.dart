import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'src/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @hello.
  ///
  /// In vi, this message translates to:
  /// **'Xin Chào'**
  String get hello;

  /// No description provided for @update.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In vi, this message translates to:
  /// **'Thêm'**
  String get add;

  /// No description provided for @search.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm'**
  String get search;

  /// No description provided for @account.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin tài khoản'**
  String get account;

  /// No description provided for @txt_username.
  ///
  /// In vi, this message translates to:
  /// **'Tên đăng nhập'**
  String get txt_username;

  /// No description provided for @txt_enter_username.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tên đăng nhập'**
  String get txt_enter_username;

  /// No description provided for @txt_password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get txt_password;

  /// No description provided for @txt_enter_password.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu'**
  String get txt_enter_password;

  /// No description provided for @txt_login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get txt_login;

  /// No description provided for @txt_please_enter_username.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên đăng nhập'**
  String get txt_please_enter_username;

  /// No description provided for @txt_please_enter_password.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mật khẩu'**
  String get txt_please_enter_password;

  /// No description provided for @txt_home.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get txt_home;

  /// No description provided for @txt_transaction.
  ///
  /// In vi, this message translates to:
  /// **'Sổ giao dịch'**
  String get txt_transaction;

  /// No description provided for @txt_member.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên'**
  String get txt_member;

  /// No description provided for @txt_account.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get txt_account;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'vi':
      return L10nVi();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
