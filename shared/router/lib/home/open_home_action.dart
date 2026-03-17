import '../deeplink_route_action.dart';

final class OpenHomePageAction extends DeepLinkActionModel<void> {
  const OpenHomePageAction();

  static const String action = 'open_main_page';

  @override
  String get path => '/main';
}
