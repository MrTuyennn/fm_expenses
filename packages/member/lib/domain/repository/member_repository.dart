import 'package:member/domain/entities/entities.dart';

abstract class MemberRepository {
  Future<Iterable<IMemberEntity>> getMembers();
}
