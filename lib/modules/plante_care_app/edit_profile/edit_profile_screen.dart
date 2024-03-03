import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';
import 'package:flutter_projects/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/components/componantes.dart';
import '../../../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<planteCareCubit,planteCareStates>(

      listener: (BuildContext context, planteCareStates state) {  },
      builder: (BuildContext context, planteCareStates state) {
        var userModel=planteCareCubit.get(context).usermodel;

        var nameController=TextEditingController();
        var bioController=TextEditingController();
        var phoneController=TextEditingController();

        var profileImage=planteCareCubit.get(context).profileImage;
        var coverImage=planteCareCubit.get(context).coverImage;

        nameController.text=userModel!.name!;
        bioController.text=userModel!.bio!;
        phoneController.text=userModel!.phone!;







        return Scaffold(
          appBar: defultAppBar(
              context: context,
              title: 'Edit profile screen',
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: defultTextButton(text: 'update', onPressed: ()
                  {
                    planteCareCubit.get(context).updateuser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  }),
                )
              ]
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is planteCareUserUpdateLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(

                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image:coverImage==null ?NetworkImage('${userModel?.coverImage}'):FileImage(coverImage) as ImageProvider,
                                      fit: BoxFit.cover,

                                    )




                                ),



                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor:defultColor,
                                    radius: 20,
                                    child:
                                    IconButton(onPressed: (){

                                      planteCareCubit.get(context).getCoveImage();
                                    }
                                    , icon: Icon(IconBroken.Camera,color: Colors.white,))),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              radius: 63,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage==null? NetworkImage('${userModel?.image}'):FileImage(profileImage)as ImageProvider,

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: defultColor,
                                  radius: 15,
                                  child:
                                  IconButton(onPressed: (){
                                    planteCareCubit.get(context).getProfileImage();
                                  }
                                      , icon: Icon(IconBroken.Camera,color: Colors.white,size: 15,))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),


                  if(planteCareCubit.get(context).profileImage!=null || planteCareCubit.get(context).coverImage!=null )
                     Row(
                      children: [

                          if(planteCareCubit.get(context).profileImage!=null)
                            Expanded(
                                child:
                                Column(
                                  children: [
                                    defultButton(
                                        onPressedFunction: (){

                                          planteCareCubit.get(context).uploadProfileImage(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              bio: bioController.text,
                                              );
                                        }
                                        , text: 'uploud profile ', background: defultColor),
                                    if(state is planteCareUserUpdateLoadingState)
                                    SizedBox(height: 5,),
                                    if(state is planteCareUserUpdateLoadingState)
                                    LinearProgressIndicator(),

                                  ],
                                )),
                            SizedBox(width:5,),
                          if(planteCareCubit.get(context).coverImage!=null)
                             Expanded(
                                 child:
                                 Column(
                                   children: [
                                     defultButton(onPressedFunction: (){
                                       planteCareCubit.get(context).uploadCoverImage(
                                         name: nameController.text,
                                         phone: phoneController.text,
                                         bio: bioController.text,
                                       );
                                     }
                                      , text: 'uploud cover  ', background: defultColor),
                                     if(state is planteCareUserUpdateLoadingState)
                                     SizedBox(height: 5,),
                                     if(state is planteCareUserUpdateLoadingState)
                                     LinearProgressIndicator(),
                                   ],
                                 )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  defultFormField(
                      controller: nameController,
                      keyboardtybe: TextInputType.name,
                      labeltext: 'Name',
                      validate: (value){
                        if (value!.isEmpty)
                          {
                            return 'Name must not be empty';
                          }
                      },
                      prefix: IconBroken.User,
                  ),
                  SizedBox(height: 10,),
                  defultFormField(
                    controller: bioController,
                    keyboardtybe: TextInputType.text,
                    labeltext: 'bio',
                    validate: (value){
                      if (value!.isEmpty)
                      {
                        return 'Bio must not be empty';
                      }
                    },
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(height: 10,),
                  defultFormField(
                    controller: phoneController,
                    keyboardtybe: TextInputType.text,
                    labeltext: 'phone',
                    validate: (value){
                      if (value!.isEmpty)
                      {
                        return 'Phon must not be empty';
                      }
                    },
                    prefix: Icons.phone,
                  )


                ],
              ),
            ),
          ),
        );
      },


    );
  }
}
