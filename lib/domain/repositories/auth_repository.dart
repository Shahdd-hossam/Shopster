import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import 'product_repository.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String username, String password);
  Future<Either<Failure, UserEntity>> getUser(int userId);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
