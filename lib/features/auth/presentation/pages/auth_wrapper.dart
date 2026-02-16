import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholefit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wholefit/features/auth/presentation/bloc/auth_state.dart';
import 'package:wholefit/features/auth/presentation/pages/login_page.dart';
import 'package:wholefit/presentation/screens/homescreen.dart';

import '../bloc/auth_event.dart';
import 'main_navigation_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStatus>(
      builder: (context, state) {

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthAuthenticated) {
          return const MainNavigationScreen();
        }

        if (state is AuthUnauthenticated) {
          return const LoginPage();
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}