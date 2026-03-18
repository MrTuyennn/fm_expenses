part of 'member_bloc.dart';

enum MemberType { init, loading, success, error }

class MemberState extends Equatable {
  const MemberState({this.memberType = MemberType.init});
  final MemberType memberType;

  @override
  List<Object?> get props => [];

  MemberState copyWith({MemberType? newType}) {
    return MemberState(memberType: newType ?? memberType);
  }
}
