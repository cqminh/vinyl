import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinyl/features/auth/cubit/auth_cubit.dart';
import 'package:vinyl/features/auth/cubit/auth_state.dart';
import 'package:vinyl/features/auth/data/app_user.dart';
import 'package:vinyl/features/auth/data/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const guestUser = AppUser(uid: 'guest-1', isAnonymous: true);
  const googleUser = AppUser(uid: 'google-1', isAnonymous: false);
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
  });

  test('state ban đầu là AuthUnknown', () {
    when(() => authRepository.authStateChanges)
        .thenAnswer((_) => const Stream.empty());

    final cubit = AuthCubit(authRepository);

    expect(cubit.state, const AuthUnknown());
    cubit.close();
  });


  blocTest<AuthCubit, AuthState>(
    'emit AuthGuest khi stream phát user ẩn danh', 
    setUp: () {
      when(() => authRepository.authStateChanges)
        .thenAnswer((_) => Stream.value(guestUser));
    },
    build: () => AuthCubit(authRepository),
    expect: () => [
      AuthGuest(
        user: guestUser
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'emit AuthSignedIn khi stream phát user Google', 
    setUp: () {
      when(() => authRepository.authStateChanges)
        .thenAnswer((_) => Stream.value(googleUser));
    },
    build: () => AuthCubit(authRepository),
    expect: () => [
      AuthSignedIn(
        user: googleUser
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'xác nhận signInAnonymously đã bị gọi đúng 1 lần', 
    setUp: () {
      when(() => authRepository.authStateChanges)
        .thenAnswer((_) => Stream.value(null));

      when(() => authRepository.signInAnonymously())
        .thenAnswer((_) async {});
    },
    verify: (_) {
      verify(() => authRepository.signInAnonymously()).called(1);
    },
    build: () => AuthCubit(authRepository),
    expect: () => [],
  );
}