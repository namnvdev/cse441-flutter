import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
// import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  final SignIn _signIn;
  final SignUp _signUp;
  final SignOut _signOut;

  AuthController(
    this._signIn,
    this._signUp,
    this._signOut,
  ) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _signIn.call(email, password);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _signUp.call(email, password);  
      state = const AsyncValue.data(null);
    }catch(e, st){
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _signOut.call();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }
}
