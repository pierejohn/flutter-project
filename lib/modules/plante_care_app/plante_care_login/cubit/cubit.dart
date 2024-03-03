import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/modules/plante_care_app/plante_care_login/cubit/states.dart';

import 'package:flutter_projects/shared/network/remote/dio_helper.dart';



class planteCareLoginCubit extends Cubit<planteCareLoginStates>
{
  planteCareLoginCubit() : super(planteCareLoginInitalState());
  
  static planteCareLoginCubit get(context)=>BlocProvider.of(context);
//   SocialLoginModel ? loginModel;

  void userLogin({
    required String email,
    required String password,
}){
    emit(planteCareLoginIsLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) => {

        print('hnaaaaaaaaaaaaaaaaaaaaaaa 5dna 2l uuuuuuuuuuuuuuuuuuuuuuuiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiddddddddddddddddddddddddddddd'),
       emit(planteCareLoginSuccessState(value.user!.uid)),
    })
        .catchError((error){
      emit(planteCareLoginErrorState( error.toString()));
    });
  }


  bool isPassword=true;
IconData Suffix=Icons.visibility_off;
  void ChangeSuffixIcon(){
    emit(planteCareChangePasswordVisabiltyState());
    isPassword=!isPassword;
    Suffix=isPassword ? Icons.visibility_off:Icons.visibility;

  }

}
