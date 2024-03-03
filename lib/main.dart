
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/cubit.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';
import 'package:flutter_projects/layout/social_app/plante_care_layout.dart';
import 'package:flutter_projects/shared/bloc-observer.dart';
import 'package:flutter_projects/shared/components/constants.dart';
import 'package:flutter_projects/shared/network/local/cashHelper.dart';
import 'package:flutter_projects/shared/network/remote/dio_helper.dart';
import 'package:flutter_projects/shared/styles/themes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'modules/plante_care_app/on_boarding/on_bording_screen.dart';
import 'modules/plante_care_app/plante_care_login/login_screen.dart';






Future<void> main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Bloc.observer = MyBlocObserver();

  await CasheHelper.init();




  bool onBoarding=CasheHelper.getData(key: "onBoarding") ?? false;
  print(onBoarding);

Widget widget;



    // token = CasheHelper.getData(key: "token") ;
  uId=CasheHelper.getData(key: "uId") ;



//
//   if(onBoarding!=null)
// {
//   if(token!=null) widget=shopLayout();
//   else widget=ShopLoginScreen();
// }else
// {
//   widget = OnBoardinScreen();
//   }

  if(uId!=null)
    {
      widget=planteCareLayout();
    }else
      {
        if(onBoarding==false)
          {
            widget=onBordingScreen();

          }else
            {
              widget=planteCareLoginScreen();

            }

      }
  DioHelper.init();
  runApp( MyApp(

    startWidget:widget,

  ));

}


//to use the shop screen use startWidget in home

class MyApp extends StatelessWidget{

  // final bool isBlack;
   final Widget startWidget;


  MyApp({ required this.startWidget});
  @override

  Widget build( context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>planteCareCubit()..getAllPlantsData()..getAllMyPlantsData()..getAllMyTasksData()..countTodayTasks()..setCurrentDate(DateTime.now())),

      ],
      child: BlocConsumer<planteCareCubit,planteCareStates>(
        listener: ( context,  state) {
        },
        builder: ( context,  state) {
          print('building');
          return MaterialApp(
            theme:lightheme,


            // AppCubit.get(context).isBlack? ThemeMode.dark :ThemeMode.light ,
            //darkTheme: darktheme,
            debugShowCheckedModeBanner: false,

             home:startWidget,
             // home:onBordingScreen(),

          );
        },

      ),
    );
  }


}
// BMIscreen()
// BMI_result()