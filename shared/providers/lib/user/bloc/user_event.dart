part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserEvent extends UserEvent {}

final class GetListUserEvent extends UserEvent {}
