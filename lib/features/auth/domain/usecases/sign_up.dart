import '../repositories/auth_repository.dart';


class SignUp {
  final AuthRepository _authRepository;

  SignUp(this._authRepository);

  Future<void> call(String email, String password) {
    return _authRepository.signUp(email, password);
  }
}