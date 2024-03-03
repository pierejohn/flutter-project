import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/social_app/plante_care_layout.dart';
import 'package:flutter_projects/modules/plante_care_app/on_boarding/on_bording_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/componantes.dart';
import '../../../shared/network/local/cashHelper.dart';
import '../../../shared/styles/colors.dart';

import '../plante_care_register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class planteCareLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>planteCareLoginCubit(),
      child: BlocConsumer<planteCareLoginCubit,planteCareLoginStates>(
        listener: (BuildContext context, Object? state) {
              if(state is planteCareLoginErrorState){
                DefultFlutterToast(
                  massege: state.error,
                  color: Colors.red,);
              }
        if(state is planteCareLoginSuccessState)
          {
            print(state.uId);
            CasheHelper.saveData(
                key: 'uId',
                value:state.uId,

            ).then((value) {

              planteCareCubit.get(context).getAllMyPlantsData();
              planteCareCubit.get(context).getAllMyTasksData();

              navigateAndFinish(context, planteCareLayout());



            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('LOGIN',style:Theme.of(context).textTheme.headline5,),
                        Text('login now to care your plants',style:Theme.of(context).textTheme.bodyText1?.copyWith(color: defultColor.withOpacity(0.4)),),
                        SizedBox(height: 30,),
                        defultFormField(
                            controller: emailController,
                            keyboardtybe: TextInputType.emailAddress,
                            labeltext: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'pls enter your email';
                              }
                              return null;
                            }),
                        SizedBox(height: 10,),
                        defultFormField(
                            controller: passwordController,
                            keyboardtybe: TextInputType.visiblePassword,
                            suffix: planteCareLoginCubit.get(context).Suffix,
                            isPassword: planteCareLoginCubit.get(context).isPassword,
                            onSubmit: (value){
                              if(formKey.currentState!.validate())
                              {
                                planteCareLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            suffixPressed: (){
                              planteCareLoginCubit.get(context).ChangeSuffixIcon();

                            },
                            labeltext: 'Password',
                            prefix: Icons.lock_outline,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'pls enter your password';
                              }
                              return null;
                            }),
                        SizedBox(height: 30,),


                        ConditionalBuilder(
                            condition: state is! planteCareLoginIsLoadingState? true:false,
                            builder: (BuildContext context) =>defultButton(
                                onPressedFunction: (){
                                  if(formKey.currentState!.validate())
                                  {
                                    planteCareLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);



                                  }

                                },
                                text: 'LOGIN',
                                background: defultColor),
                            fallback: (context) =>Center(child: CircularProgressIndicator())
                        ),





                        SizedBox(height: 30,),
                        Row(children: [
                          Text('dont have an account ?'),
                          Spacer(),
                          defultTextButton(text: 'Register now', onPressed: (){

                            navigateTo(context,planteCareRegisterScreen());
                          })
                        ],),
                        SizedBox(height:30),
                        TextButton(onPressed: (){
                          CasheHelper
                              .saveData(key: 'onBoarding', value: false).then((value) {navigateAndFinish(context, onBordingScreen());});
                        }, child: Text('onbording',style: TextStyle(fontSize: 5),)),
                        // TextButton(onPressed: (){
                        //   casheHelper.updateData(key: 'onBoarding', value: null);
                        //   navigateAndFinish(context, OnBoardinScreen());
                        // }, child:Text('show trial again',style: TextStyle(fontSize: 5),) )


                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },


      ),
    );
  }
}
