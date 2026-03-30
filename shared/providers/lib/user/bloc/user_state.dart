part of 'user_bloc.dart';

enum UserType { init, loading, success, error }

class UserState extends Equatable {
  const UserState({
    this.userType = UserType.init,
    this.user = const UserEntity(),
    this.lsUser = const [],
  });

  final UserType userType;
  final IUserEntity user;
  final Iterable<IUserEntity> lsUser;

  @override
  List<Object?> get props => [userType, user, lsUser];

  UserState copyWith({
    UserType? newUserType,
    IUserEntity? newUser,
    Iterable<IUserEntity>? newLsUser,
  }) {
    return UserState(
      userType: newUserType ?? userType,
      user: newUser ?? user,
      lsUser: newLsUser ?? lsUser,
    );
  }
}
