import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthStatus {}

class AuthInitial extends AuthStatus {}

class AuthLoading extends AuthStatus {}

class AuthAuthenticated extends AuthStatus {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthStatus {}

class AuthFailure extends AuthStatus {
  final String message;
  AuthFailure(this.message);
  
}