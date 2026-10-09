part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserEvent extends UserEvent {}

/// Dispatched when the session is gone (explicit logout, or a refresh-token
/// attempt failed) so the auth guard stops thinking the user is signed in.
final class UserLoggedOut extends UserEvent {}
