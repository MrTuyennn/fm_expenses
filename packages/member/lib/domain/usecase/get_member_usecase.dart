import 'package:injectable/injectable.dart';
import 'package:member/domain/entities/entities.dart';
import 'package:service/service.dart';

import '../repository/member_repository.dart';

@lazySingleton
final class GetMemberUsecase
    extends NoParamsUseCase<Result<Iterable<IMemberEntity>>> {
  const GetMemberUsecase(this.memberRepository);

  final MemberRepository memberRepository;
  @override
  Future<Result<Iterable<IMemberEntity>>> call() {
    return Result.guardFuture(() => memberRepository.getMembers());
  }
}
