
abstract class planteCareLoginStates{}

class planteCareLoginInitalState extends planteCareLoginStates{}
class planteCareLoginIsLoadingState extends planteCareLoginStates{}
class planteCareLoginSuccessState extends planteCareLoginStates{
  final String uId;

  planteCareLoginSuccessState(this.uId);

}
class planteCareLoginErrorState extends planteCareLoginStates{
  final String error;

  planteCareLoginErrorState( this.error);
}
class planteCareChangePasswordVisabiltyState extends planteCareLoginStates{}
