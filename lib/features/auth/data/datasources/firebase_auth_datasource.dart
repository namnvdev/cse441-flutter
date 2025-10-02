import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserEntity?> signIn(String email, String password) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(cred.user);
  }

  Future<UserEntity?> signUp(String email, String password) async {
    final cred = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(cred.user);
  }

  Future<void> signOut() async => _firebaseAuth.signOut();

  Stream<UserEntity?> get user =>
      _firebaseAuth.authStateChanges().map(_userFromFirebase);

  UserEntity? _userFromFirebase(User? user) {
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email);
  }
}
