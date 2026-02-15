import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatus> {
  final _supabase = Supabase.instance.client;

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// 🔐 LOGIN
  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthStatus> emit,
      ) async {
    emit(AuthLoading());

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      if (response.session != null) {
        emit(AuthAuthenticated(response.user!));
      } else {
        emit(AuthFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  /// 📝 SIGNUP
  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<AuthStatus> emit,
      ) async {
    emit(AuthLoading());

    try {
      final response = await _supabase.auth.signUp(
        email: event.email,
        password: event.password,
      );

      if (response.user != null) {
        emit(AuthAuthenticated(response.user!));
      } else {
        emit(AuthFailure("Signup failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  /// 🔄 CHECK SESSION (Auto-login)
  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event,
      Emitter<AuthStatus> emit,
      ) async {
    final session = _supabase.auth.currentSession;

    if (session != null) {
      emit(AuthAuthenticated(session.user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  /// 🚪 LOGOUT
  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthStatus> emit,
      ) async {
    await _supabase.auth.signOut();
    emit(AuthUnauthenticated());
  }
}