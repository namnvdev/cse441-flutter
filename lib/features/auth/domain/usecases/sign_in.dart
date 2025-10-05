import '../repositories/auth_repository.dart';

class SignIn {
  final AuthRepository _authRepository;

  SignIn(this._authRepository);

  Future<void> call(String email, String password) {
    return _authRepository.signIn(email, password);
  }

}