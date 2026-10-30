import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinyl/features/auth/data/app_user.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<void> signOut() => _auth.signOut();

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Stream<AppUser?> get authStateChanges => 
    _auth.authStateChanges().map((user) => 
      user == null 
        ? null 
        : AppUser(
          uid: user.uid, 
          isAnonymous: user.isAnonymous,
        ));
}