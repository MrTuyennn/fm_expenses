import 'package:meta/meta.dart';

/// The `DeepLinkActionModel` abstract base class is designed to represent a
/// models for handling deep link actions. Each models contains associated route
/// data and abstract properties that must be implemented by any subclass to
/// specify the deep link action and path.
///
/// This class is generic and can handle any type of route data, allowing for
/// flexibility in different deep linking scenarios.
///
/// `TRouteData` is the generic type parameter that represents the type of data
/// associated with the deep link route.
///
/// Example usage:
/// ```dart
/// class MyDeepLinkAction extends DeepLinkActionModel<MyRouteData> {
///   MyDeepLinkAction({MyRouteData? routeData}) : super(routeData: routeData);
///
///   static const String action = 'action_name';
///
///   @override
///   String get path => '/home';
/// }
/// ```
///
/// @param &lt;TRouteData&gt; The type of the data associated with the deep link route.
@immutable
abstract class DeepLinkActionModel<TRouteData> {
  /// Constructs a new instance of `DeepLinkActionModel` with optional route data.
  ///
  /// @param [routeData] The data associated with the deep link route, which can
  ///                    be null.
  const DeepLinkActionModel({this.routeData});

  /// The route data associated with the deep link. It is a generic field that
  /// can be of any type defined by the subclass.
  ///
  /// This field is nullable, allowing for scenarios where no route data is needed.
  final TRouteData? routeData;

  /// An abstract getter that must be overridden to define the specific action
  /// for the deep link.
  ///
  /// The action could represent a variety of behaviors, such as navigation,
  /// displaying a modal, or invoking a specific feature.
  static const String action = '';

  /// An abstract getter that must be overridden to define the path for the deep link.
  ///
  /// This typically represents the URL or route that the deep link corresponds to.
  String get path;
}
