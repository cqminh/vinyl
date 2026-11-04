import 'package:firebase_auth/firebase_auth.dart';
import 'package:vinyl/features/auth/data/app_user.dart';

abstract final class _AuthErrorCodes {
  static const popupClosedByUser = 'popup-closed-by-user';
  static const cancelledPopupRequest = 'cancelled-popup-request';
  static const credentialAlreadyInUse = 'credential-already-in-use';
}

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

    try {
      await currentUser.linkWithPopup(GoogleAuthProvider());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case _AuthErrorCodes.popupClosedByUser:
        case _AuthErrorCodes.cancelledPopupRequest:
          return;
        case _AuthErrorCodes.credentialAlreadyInUse:
          final credential = e.credential;
          if (credential == null) rethrow;
          await _auth.signInWithCredential(credential);
          return;
      }
      rethrow; 
    }
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