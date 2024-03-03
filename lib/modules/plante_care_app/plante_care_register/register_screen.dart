import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/shared/components/componantes.dart';
import '../../../shared/network/local/cashHelper.dart';
import '../../../shared/styles/colors.dart';
import '../plante_care_login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class planteCareRegisterScreen extends StatelessWidget {
  @override


  var formKey=GlobalKey<FormState>();

  var emailController=TextEditingController();

  var nameController=TextEditingController();

  var phoneController=TextEditingController();

  var passwordController=TextEditingController();

  CasheHelper casheHelper = CasheHelper();

  @override
  Widget build( context) {
    return BlocProvider(
      create: ( context) =>planteCareRegisterCubit(),
      child: BlocConsumer<planteCareRegisterCubit,planteCareRegisterStates  >(
        listener: ( context, state)
        {
          if(state is planteCareCreateUserSuccessState)
          {
            navigateAndFinish(context, planteCareLoginScreen());
          }

        },
        builder: ( context, Object? state) {
          dynamic reqirmentsOfPaswword=true;
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

                        Text('Register',style:Theme.of(context).textTheme.headline5,),
                        Text('Register now to help your plants',style:Theme.of(context).textTheme.bodyText1?.copyWith(color: defultColor.withOpacity(0.4)),),
                        SizedBox(height: 30,),
                        defultFormField(
                            controller: nameController,
                            keyboardtybe: TextInputType.text,
                            labeltext: 'Name',
                            prefix: Icons.person,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'pls enter your name';
                              }
                              return null;
                            }),
                        SizedBox(height: 10,),
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
                        ConditionalBuilder(
                          condition:(state !is planteCareRegisterErrorState ? false:true) ,
                          builder: (context) =>Container(child: Column(children: [

                            Row(
                              children: [


                              ],
                            ),

                          ],),)

                          ,
                          fallback: (context) =>  Text( 'The email address is already in use by another account',style: TextStyle(fontSize: 10,color: Colors.red),) ,),
                        SizedBox(height: 10,),

                        defultFormField(
                            controller: passwordController,
                            keyboardtybe: TextInputType.visiblePassword,
                            suffix: planteCareRegisterCubit.get(context).Suffix,
                            isPassword: planteCareRegisterCubit.get(context).isPassword,
                            onSubmit: (value){
                            },
                            suffixPressed: (){
                              planteCareRegisterCubit.get(context).ChangeSuffixIcon();

                            },
                            labeltext: 'Password',
                            prefix: Icons.lock_outline,
                            onChange: (value){
                              planteCareRegisterCubit.get(context).changeState();

                                  reqirmentsOfPaswword=false;



                            },

                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }

                              List<String> errors = [];

                              // Check for minimum length
                              if (value.length < 8) {
                                errors.add('Password must be at least 8 characters');
                              }
                              // Check for at least one uppercase letter
                              if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                errors.add('Password must include an uppercase letter');
                              }
                              // Check for at least one lowercase letter
                              if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                                errors.add('Password must include a lowercase letter');
                              }
                              // Check for at least one number
                              if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                                errors.add('Password must include a number');
                              }
                              // Check for at least one special character
                              if (!RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]]').hasMatch(value)) {
                                errors.add('Password must include a special character');
                              }

                              // If any conditions are not met, return all errors
                              if (errors.isNotEmpty) {
                                return errors.join('\n');
                              }

                              // If all conditions are met
                              return null;
                            }





                        ),

                          ConditionalBuilder(
                              condition:(state is removePasswordRegix || state is planteCareChangePasswordRegisterVisabiltyState || state is planteCareRegisterErrorState? false:true) ,
                              builder: (context) =>Container(child: Column(children: [

                                Row(
                                children: [
                                  Icon(Icons.circle_rounded,color:Colors.grey.shade500,size: 10 ),
                                  Text( 'Be at least 8 characters long',style: TextStyle(fontSize: 10,color: Colors.grey.shade500),),
                                ],
                              ),
                                Row(
                                  children: [
                                    Icon(Icons.circle_rounded,color:Colors.grey.shade500,size: 10 ),
                                    Text( 'Include at least one uppercase letter',style: TextStyle(fontSize: 10,color: Colors.grey.shade500),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle_rounded,color:Colors.grey.shade500,size: 10 ),
                                    Text( 'Include at least one lowercase letter',style: TextStyle(fontSize: 10,color: Colors.grey.shade500),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle_rounded,color:Colors.grey.shade500,size: 10 ),
                                    Text( 'Include at least one number',style: TextStyle(fontSize: 10,color: Colors.grey.shade500),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle_rounded,color:Colors.grey.shade500,size: 10 ),
                                    Text( 'Include at least one special character (e.g., !@#%^&*())',style: TextStyle(fontSize: 10,color: Colors.grey.shade500),),
                                  ],
                                ),
                              ],),)

                              ,
                              fallback: (context) => Column(),),


                        SizedBox(height: 10,),

                        defultFormField(
                            controller: phoneController,
                            keyboardtybe: TextInputType.number,
                            labeltext: 'Mobile number',
                            prefix: Icons.phone,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'pls enter your mobile number';
                              }
                              return null;
                            }),
                        SizedBox(height: 10,),
                        SizedBox(height: 30,),


                        ConditionalBuilder(
                            condition: state is! planteCareRegisterIsLoadingState,
                            builder: (BuildContext context) =>defultButton(
                                onPressedFunction: (){

                                  if(formKey.currentState!.validate())
                                  {

                                    planteCareRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name:nameController.text,
                                        phone: phoneController.text);

                                  }


                                },
                                text: 'REGISTER',
                                background: defultColor),
                            fallback: (context) =>Center(child: CircularProgressIndicator())
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        },

      ),
    );


  }
}
