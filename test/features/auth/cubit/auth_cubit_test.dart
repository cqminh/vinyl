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
    when(() => authRepository.userChanges)
      .thenAnswer((_) => const Stream.empty());
  });

  test('state ban đầu là AuthUnknown', () {
    final cubit = AuthCubit(authRepository);

    expect(cubit.state, const AuthUnknown());
    cubit.close();
  });


  blocTest<AuthCubit, AuthState>(
    'emit AuthGuest khi stream phát user ẩn danh', 
    setUp: () {
      when(() => authRepository.userChanges)
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
      when(() => authRepository.userChanges)
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
      when(() => authRepository.userChanges)
        .thenAnswer((_) => Stream.value(null));

      when(() => authRepository.signInAnonymously())
        .thenAnswer((_) async {});
    },
    build: () => AuthCubit(authRepository),
    expect: () => [],
    verify: (_) {
      verify(() => authRepository.signInAnonymously()).called(1);
    },
  );

  blocTest<AuthCubit, AuthState>(
    'signInWithGoogle thành công thì không emit gì', 
    setUp: () {
      when(() => authRepository.linkWithGoogle())
        .thenAnswer((_) async {});
    },
    build: () => AuthCubit(authRepository),
    act: (cubit) => cubit.signInWithGoogle(),
    expect: () => [],
    verify: (_) {
      verify(() => authRepository.linkWithGoogle()).called(1);
    },
  );

  blocTest<AuthCubit, AuthState>(
    'signInWithGoogle lỗi → AuthFailure rồi trở về state cũ', 
    setUp: () {
      when(() => authRepository.linkWithGoogle())
        .thenThrow(Exception());
    },
    build: () => AuthCubit(authRepository),
    seed: () => AuthGuest(user: guestUser),
    act: (cubit) => cubit.signInWithGoogle(),
    expect: () => [
      isA<AuthFailure>(),
      AuthGuest(user: guestUser)
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'lỗi 2 lần liên tiếp → SnackBar hiện cả 2 lần',
    setUp: () {
      when(() => authRepository.linkWithGoogle())
        .thenThrow(Exception());
    },
    build: () => AuthCubit(authRepository),
    seed: () => AuthGuest(user: guestUser), 
    act: (cubit) async {
      await cubit.signInWithGoogle();
      await cubit.signInWithGoogle();
    },
    expect: () => [
      isA<AuthFailure>(),
      const AuthGuest(user: guestUser),
      isA<AuthFailure>(),
      const AuthGuest(user: guestUser)
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'signOut chỉ gọi repository', 
    setUp: () {
      when(() => authRepository.signOut())
        .thenAnswer((_) async {});
    },
    build: () => AuthCubit(authRepository),
    act: (cubit) => cubit.signOut(),
    expect: () => [],
    verify: (_) {
      verify(() => authRepository.signOut()).called(1);
    },
  );
}