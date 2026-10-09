part of 'user_bloc.dart';

enum UserType { init, loading, success, error }

class UserState extends Equatable {
  const UserState({
    this.userType = UserType.init,
    this.user = const UserEntity(),
  });

  final UserType userType;
  final IUserEntity user;

  @override
  List<Object?> get props => [userType, user];

  UserState copyWith({UserType? newUserType, IUserEntity? newUser}) {
    return UserState(userType: newUserType ?? userType, user: newUser ?? user);
  }
}
