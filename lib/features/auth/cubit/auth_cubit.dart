import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vinyl/features/auth/cubit/auth_state.dart';
import 'package:vinyl/features/auth/data/app_user.dart';
import 'package:vinyl/features/auth/data/auth_repository.dart';

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(
    this._authRepository
  ) : super(const AuthUnknown()) {
    _subscription = _authRepository.authStateChanges.listen(_onUserChanged);
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<AppUser?> _subscription;

  void _onUserChanged(AppUser? user) {
    if (user == null) {
      unawaited(_authRepository.signInAnonymously());
      return;
    } 
    emit(user.isAnonymous 
      ? AuthGuest(user: user) 
      : AuthSignedIn(user: user));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}