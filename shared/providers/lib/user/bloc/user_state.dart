part of 'user_bloc.dart';

enum UserType { init, loading, success, error }

class UserState extends Equatable {
  const UserState({this.userType = UserType.init});

  final UserType userType;

  @override
  List<Object?> get props => [userType];

  UserState copyWith({UserType? newUserType}) {
    return UserState(userType: newUserType ?? userType);
  }
}
