import 'package:injectable/injectable.dart';
import 'package:member/data/dtos/get_member_response.dart';
import 'package:member/domain/entities/member_entity.dart';
import 'package:member/domain/repository/member_repository.dart';
import 'package:service/service.dart';

@LazySingleton(as: MemberRepository)
class MemberRepositoryImpl with ApiScopeMixin implements MemberRepository {
  const MemberRepositoryImpl(this.restClient);

  final IRestClient restClient;

  @override
  Future<Iterable<IMemberEntity>> getMembers() {
    final data = runApiScope(
      request: () => restClient.get('/user/list'),
      deserialize: GetMemberResponse.fromJson,
    ).then((data) => data.items);
    return data;
  }
}
