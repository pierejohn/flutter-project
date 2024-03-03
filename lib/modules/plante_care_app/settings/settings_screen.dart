import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';
import 'package:flutter_projects/shared/components/componantes.dart';
import 'package:flutter_projects/shared/styles/icon_broken.dart';

import '../../../shared/network/local/cashHelper.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../plante_care_login/login_screen.dart';


class settingsScreeen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<planteCareCubit,planteCareStates>(

      listener: (BuildContext context, planteCareStates state)
      {

      },
      builder: (BuildContext context, planteCareStates state) {

        var userModel=planteCareCubit.get(context).usermodel;


        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(

                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userModel?.coverImage}'),
                              fit: BoxFit.cover,

                            )




                        ),



                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      radius: 63,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${userModel?.image}'),
                        ),
                    )
                  ],
                ),
              ),
              Text('${userModel?.name}',style: Theme.of(context).textTheme.bodyText1,),
              Text('${userModel?.bio}',style: Theme.of(context).textTheme.caption,),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20
                ),

              ),
              Row(
                children: [


                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        planteCareCubit.get(context).profileImage=null ;
                        planteCareCubit.get(context).coverImage=null;
                        navigateTo(context, EditProfileScreen());  },
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Edit profile'),
                            SizedBox(width: 10,),
                            Icon(IconBroken.Edit)
                          ]),
                    ),
                  ),
                  SizedBox(width: 10,),
                  OutlinedButton(onPressed: (){
                    CasheHelper().removeData(
                      key: 'uId',

                    ).then((value) {
                      navigateAndFinish(context, planteCareLoginScreen());
                      print(value);
                    });

                  }, child: Icon(Icons.logout))
                ],
              )
            ],
          ),
        );
    },

    );
  }
}