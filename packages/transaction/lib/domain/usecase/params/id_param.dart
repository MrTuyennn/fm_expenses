import 'package:service/service.dart';

/// Carries a single resource id for get-by-id / delete-by-id usecases.
class IdParam implements IParam {
  const IdParam(this.id);

  final String id;

  @override
  Map<String, dynamic> toJson() => {};
}
