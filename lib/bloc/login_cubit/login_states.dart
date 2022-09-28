abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginSucState extends LoginStates {
  final String token;

  LoginSucState(this.token);
}

class LoginLoadingState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error ;

  LoginErrorState(this.error);
}

class RegisterSucState extends LoginStates {}

class RegisterLoadingState extends LoginStates {}

class RegisterErrorState extends LoginStates {

}

class HidePasswordSucState extends LoginStates {}
