abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {
  String msg;
  AuthSuccess(this.msg);
}

class AuthFailure extends AuthStates {
  String msg;
  AuthFailure(this.msg);
}
