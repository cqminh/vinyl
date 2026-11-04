import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinyl/features/auth/data/app_user.dart';

class AuthRepository {
  const AuthRepository(this._auth);

  final FirebaseAuth _auth;

  Future<void> signOut() => _auth.signOut();

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Future<void> linkWithGoogle() async {
    final currentUser = _auth.currentUser 
      ?? (throw StateError('linkWithGoogle called with no signed-in user'));

    await currentUser.linkWithPopup(GoogleAuthProvider());
  }

  Stream<AppUser?> get userChanges => 
    _auth.userChanges().map((user) => 
      user == null 
        ? null 
        : AppUser(
          uid: user.uid, 
          isAnonymous: user.isAnonymous,
        ));
}