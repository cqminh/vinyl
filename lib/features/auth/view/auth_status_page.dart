import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl/features/auth/cubit/auth_cubit.dart';
import 'package:vinyl/features/auth/cubit/auth_state.dart';

class AuthStatusPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return switch (state) {
              AuthUnknown() => CircularProgressIndicator(),
              AuthGuest(:final user) => 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Khách - UID: ${user.uid}'),
                    TextButton(
                      onPressed: () => context.read<AuthCubit>().signInWithGoogle(), 
                      child: Text('Login with Google')
                    )
                  ],
                ),
              AuthSignedIn(:final user) =>
                Text('Đã đăng nhập - UID: ${user.uid}'),
            };
          }
        ),
      ),
    );
  }
}