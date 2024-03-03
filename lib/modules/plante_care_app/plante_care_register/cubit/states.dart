

abstract class planteCareRegisterStates{}

class planteCareRegisterInitalState extends planteCareRegisterStates{}
class planteCareRegisterIsLoadingState extends planteCareRegisterStates{}
class planteCareRegisterSuccessState extends planteCareRegisterStates{

}
class planteCareRegisterErrorState extends planteCareRegisterStates{
  final String error;

  planteCareRegisterErrorState({required this.error});
}

class planteCareCreateUserSuccessState extends planteCareRegisterStates{

}
class planteCareCreateUserErrorState extends planteCareRegisterStates{
  final String error;

  planteCareCreateUserErrorState(this.error);
}


class planteCareChangePasswordRegisterVisabiltyState extends planteCareRegisterStates{}

class removePasswordRegix extends planteCareRegisterStates{}
