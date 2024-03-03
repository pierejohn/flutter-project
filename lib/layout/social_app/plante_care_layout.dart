
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';

import 'package:flutter_projects/shared/styles/icon_broken.dart';


import '../../shared/network/local/cashHelper.dart';


class planteCareLayout extends StatelessWidget {


  @override
   Widget build(BuildContext context) {
    planteCareCubit.get(context).currentIndex=0;
    planteCareCubit.get(context).getUserData();



    return BlocConsumer<planteCareCubit,planteCareStates>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=planteCareCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex]
              ),
              actions: [

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap:(index) {
                cubit.changeBottomNav(index);


              },
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(IconBroken.Camera),label: 'Camera'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Setting'),
              ],
            ),

            //email verification
            // ConditionalBuilder(
            //
            //
            //   condition: SocialCubit.get(context).model!=null,
            //   builder: (context){
            //
            //     var  model =SocialCubit.get(context).model;
            //     print(FirebaseAuth.instance.currentUser!.emailVerified );
            //     print('dfsdfds');
            //
            //
            //    return Column(
            //
            //       children: [
            //           if(!FirebaseAuth.instance.currentUser!.emailVerified)
            //
            //         Container(
            //
            //           color: Colors.amber.withOpacity(0.6),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(
            //               horizontal: 20,
            //
            //             ),
            //             child:
            //             Row(
            //               children: [
            //                 Icon(Icons.info_outline),
            //                 SizedBox(width: 15,),
            //                 Expanded(child: Text('please verify your email')),
            //
            //                 defultTextButton(text:'send ', onPressed: (){
            //                   FirebaseAuth.instance.currentUser?.sendEmailVerification().
            //                   then((value){
            //                     DefultFlutterToast(massege: 'check your mail', color: Colors.green);
            //                   }).catchError((error){
            //                     print(error.toString());
            //                   });
            //                 })
            //               ],
            //             ),
            //
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            //   fallback: (context)=>Center(child: CircularProgressIndicator()),
            //
            // ),
          );
        },
    );
  }
}
