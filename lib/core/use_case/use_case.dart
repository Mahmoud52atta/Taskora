import 'package:dartz/dartz.dart';
import 'package:to_do_app/featuers/regester/domain/repos/auth_repo.dart';

abstract class UseCase<type, Params> {
  Future<Either<Failuer, type>> call(Params params);
}
