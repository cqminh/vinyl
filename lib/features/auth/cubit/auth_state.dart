import 'package:equatable/equatable.dart';
import 'package:vinyl/features/auth/data/app_user.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthUnknown extends AuthState {
  const AuthUnknown();

  @override
  List<Object?> get props => [];
}

final class AuthGuest extends AuthState {
  const AuthGuest({
    required this.user,
  });

  final AppUser user;

  @override
  List<Object?> get props => [user];
}

final class AuthSignedIn extends AuthState {
  const AuthSignedIn({
    required this.user,
  });

  final AppUser user;

  @override
  List<Object?> get props => [user];
}