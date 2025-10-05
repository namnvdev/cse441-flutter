import '../repositories/auth_repository.dart';


class SignOut {
  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  Future<void> call() {
    return _authRepository.signOut();
  }
}