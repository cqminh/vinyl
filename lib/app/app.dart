import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinyl/core/config/app_config.dart';
import 'package:vinyl/features/auth/cubit/auth_cubit.dart';
import 'package:vinyl/features/auth/data/auth_repository.dart';
import 'package:vinyl/features/auth/view/auth_status_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.config,
    required this.authRepository,
  });

  final AppConfig config;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(authRepository),
      child: MaterialApp(
        title: 'Vinyl',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const AuthStatusPage(),
      ),
    );
  }
}