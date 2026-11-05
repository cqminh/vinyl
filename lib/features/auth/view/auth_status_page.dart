import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl/features/auth/cubit/auth_cubit.dart';
import 'package:vinyl/features/auth/cubit/auth_state.dart';
import 'package:vinyl/features/auth/data/app_user.dart';

class AuthStatusPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listenWhen: (_, current) => current is AuthFailure,
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          buildWhen: (_, current) => current is! AuthFailure,
          builder: (_, state) {
            return switch (state) {
              AuthUnknown() => CircularProgressIndicator(),
              AuthGuest(:final user) => _GuestView(user: user),
              AuthSignedIn(:final user) => _SignedInView(user: user),
              AuthFailure() => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _GuestView extends StatelessWidget {
  const new({
    required this.user
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Khách - UID: ${user.uid}'),
        TextButton(
          onPressed: () => context.read<AuthCubit>().signInWithGoogle(), 
          child: Text('Login with Google')
        )
      ],
    );
  }
}

class _SignedInView extends StatelessWidget {
  const new({
    required this.user
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Đã đăng nhập - UID: ${user.uid}'),
        TextButton(
          onPressed: () => context.read<AuthCubit>().signOut(), 
          child: Text('Logout')
        )
      ],
    );
  }
}