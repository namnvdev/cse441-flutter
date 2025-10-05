// Repository Provider
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_app/features/auth/domain/usecases/sign_out.dart';
import 'package:my_app/features/auth/domain/usecases/sign_up.dart';

import '../../data/repositories/auth_repositories_impl.dart';
// import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in.dart';
import '../controller/auth_controller.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(FirebaseAuth.instance);
});

final signInProvider = Provider<SignIn>((ref){
  return SignIn(ref.read(authRepositoryProvider));
});
final signUpProvider = Provider<SignUp>((ref){
  return SignUp(ref.read(authRepositoryProvider));
});
final signOutProvider = Provider<SignOut>((ref){
  return SignOut(ref.read(authRepositoryProvider));
});


final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final signIn = ref.read(signInProvider);
  final signUp = ref.read(signUpProvider);
  final signOut = ref.read(signOutProvider);
  return AuthController(signIn, signUp, signOut);
});
