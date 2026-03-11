// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class L10nVi extends L10n {
  L10nVi([String locale = 'vi']) : super(locale);

  @override
  String get hello => 'Xin Chào';

  @override
  String get update => 'Cập nhật';

  @override
  String get delete => 'Xóa';

  @override
  String get add => 'Thêm';

  @override
  String get search => 'Tìm kiếm';

  @override
  String get account => 'Thông tin tài khoản';

  @override
  String get txt_username => 'Tên đăng nhập';

  @override
  String get txt_enter_username => 'Nhập tên đăng nhập';

  @override
  String get txt_password => 'Mật khẩu';

  @override
  String get txt_enter_password => 'Nhập mật khẩu';
}
