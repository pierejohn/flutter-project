abstract class planteCareStates{}

class planteCareInitialState extends planteCareStates{}

class planteCareGetUserLoadingState extends planteCareStates{}

class planteCareGetUserSuccessState extends planteCareStates{}

class planteCareGetUserErrorState extends planteCareStates{
  final String error;

  planteCareGetUserErrorState(this.error);

}
class planteCareDeletePlantLoadingState extends planteCareStates{}

class planteCareDeletePlantSuccessState extends planteCareStates{}

class planteCareDeletePlantCancelState extends planteCareStates{


}

class planteCareGetAllPlantsLoadingState extends planteCareStates{}

class planteCareGetAllPlantsSuccessState extends planteCareStates{}

class planteCareGetAllPlantsErrorState extends planteCareStates{
  final String error;

  planteCareGetAllPlantsErrorState(this.error);

}


class planteCareGetAllMyPlantsLoadingState extends planteCareStates{}

class planteCareGetAllMyPlantsSuccessState extends planteCareStates{}

class planteCareGetAllMyPlantsErrorState extends planteCareStates{
  final String error;

  planteCareGetAllMyPlantsErrorState(this.error);

}


class planteCareAddPlantToMyPlantsLoadingState extends planteCareStates{}
class planteCareAddPlantToMyPlantsSuccessState extends planteCareStates{}

class planteCareAddPlantToMyPlantsErrorState extends planteCareStates{
  final String error;

  planteCareAddPlantToMyPlantsErrorState(this.error);

}

class planteCareGetAllUsersLoadingState extends planteCareStates{}

class planteCareGetAllUsersSuccessState extends planteCareStates{}

class planteCareGetAllUsersErrorState extends planteCareStates{
  final String error;

  planteCareGetAllUsersErrorState(this.error);

}




class planteCareChangeBottomNavState extends planteCareStates{}

class planteCareNewPostState extends planteCareStates{}

class planteCareProfileImagePickedSuccessState extends planteCareStates{}
class planteCareProfileImagePickedErrorState extends planteCareStates{

}

class planteCareCoverImagePickedSuccessState extends planteCareStates{}
class planteCareCoverImagePickedErrorState extends planteCareStates{

}

class planteCareUploadProfileImageSuccessState extends planteCareStates{}
class planteCareUploudProfileImageErrorState extends planteCareStates{

}

class planteCareUploadCoverImageSuccessState extends planteCareStates{}
class planteCareUploudCoverImageErrorState extends planteCareStates{

}class PlantCareTaskCompletedSuccessState extends planteCareStates{}
class PlantCareTaskCompletedErrorState extends planteCareStates{
  final String error;

  PlantCareTaskCompletedErrorState(this.error);
}

class planteCareUserUpdateErrorState extends planteCareStates{

}
class planteCareUserUpdateLoadingState extends planteCareStates{}

class planteCareAddTasksSuccessState extends planteCareStates{}
class FunctionTriggered extends planteCareStates{}

class planteCareGetTasksLoadingState extends planteCareStates{}
class planteCareGetTasksSucssesState extends planteCareStates{}
class planteCareGetTasksErrorState extends planteCareStates{
  final String error;

  planteCareGetTasksErrorState(this.error);
}
