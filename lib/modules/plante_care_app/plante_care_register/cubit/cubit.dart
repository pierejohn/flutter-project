import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/modules/plante_care_app/plante_care_register/cubit/states.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';
import '../../../../models/models_plante_care_app/plante_care_user_model.dart';


class planteCareRegisterCubit extends Cubit<planteCareRegisterStates>
{
  planteCareRegisterCubit() : super(planteCareRegisterInitalState());
  
  static planteCareRegisterCubit get(context)=>BlocProvider.of(context);
  // SocialLoginModel ? loginModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
}){
    emit(planteCareRegisterIsLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email,
        password: password)
        .then((value) => {
          print(value.user?.email),
          print(value.user?.uid),



          userCreate(
          uId: value.user!.uid,
          phone: phone,
          name: name,
          email: email,
          )
    })
        .catchError((error){
      emit(planteCareRegisterErrorState(error: error.toString()));
    });
  }



//tocreate user in firebase database
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
    })
  {
    planteCareUserModel model=planteCareUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio:'write your bio.....',
      coverImage:'https://img.freepik.com/premium-photo/attractive-woman-with-curly-hair-with-loudspeaker_88135-5571.jpg?w=996',
      image: 'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=740&t=st=1706359042~exp=1706359642~hmac=c8d6a721dae7b807347ef62876bfdb14f5c08512381fbf8e4de630d9795b5fbb',
      isEmailVerified:false,

    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(planteCareCreateUserSuccessState());
    })
        .catchError((error){
          emit(planteCareCreateUserErrorState(error.toString()));
          
    });

  }
//
  bool isPassword=true;
  IconData Suffix=Icons.visibility_off;
  void ChangeSuffixIcon(){
    emit(planteCareChangePasswordRegisterVisabiltyState());
    isPassword=!isPassword;
    Suffix=isPassword ? Icons.visibility_off:Icons.visibility;

  }

  void changeState()
  {
    emit(removePasswordRegix());
  }
}
