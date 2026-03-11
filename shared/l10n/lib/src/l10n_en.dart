// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'hello';

  @override
  String get update => 'update';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get search => 'Search';

  @override
  String get account => 'Account Information';

  @override
  String get txt_username => 'Username';

  @override
  String get txt_enter_username => 'Enter username';

  @override
  String get txt_password => 'Password';

  @override
  String get txt_enter_password => 'Enter password';
}
