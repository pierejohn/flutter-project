import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';
import 'package:flutter_projects/shared/components/componantes.dart';
import 'package:flutter_projects/shared/styles/colors.dart';

import 'package:flutter_projects/shared/styles/icon_broken.dart';
import 'package:intl/intl.dart';

import '../../../layout/social_app/cubit/cubit.dart';
import '../../../models/models_plante_care_app/plante_care_plants_add_model.dart';
import '../../../models/models_plante_care_app/plante_care_plants_model.dart';
import '../../../models/models_plante_care_app/plante_care_plants_tasks_model.dart';
import '../../../shared/components/constants.dart';

class homeScreen extends StatelessWidget {

  @override
  var scaffoldKey=GlobalKey<ScaffoldState>();
  bool isBottomSheetShowen=false;
  Widget build(BuildContext context) {
    var userModel=planteCareCubit.get(context).usermodel;
    return BlocConsumer<planteCareCubit,planteCareStates>(
      listener: (BuildContext context, planteCareStates state) {
        if (state is FunctionTriggered) {
          // Do something when the midnight function is triggered
         currentDate= planteCareCubit.get(context).getCurrentDateString();

          }
      },
      builder: (BuildContext context, planteCareStates state) {

        planteCareCubit.get(context).plantsModel;


         return Scaffold(
           key: scaffoldKey,

         // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  list Of The taskes of the Day
              Container(

                  child: Text('Taskes of the day',style: TextStyle(fontSize: 20),)),

              Expanded(
                child: ConditionalBuilder(

                  condition:planteCareCubit.get(context).countTodayTasks() > 0,

                  builder: (context) => RefreshIndicator(

                    onRefresh: () async {

                      await planteCareCubit.get(context).refreshTasks();

                    },
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildTasksOfTheDayItem(planteCareCubit.get(context).TasksModel[index], context),
                      separatorBuilder: (context, index) => SizedBox(),
                      itemCount: planteCareCubit.get(context).TasksModel.length,
                    ),
                  ),
                  fallback: (context) {
                    if (state is planteCareGetTasksLoadingState ) {
                      // Corrected condition to == 0 and fixed the typo in the text
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await planteCareCubit.get(context).refreshTasks();
                        },
                        child: LayoutBuilder( // Use LayoutBuilder to get the parent container's constraints
                          builder: (context, constraints) => SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Container(
                              height: constraints.maxHeight, // Use the maximum height available
                              child: Center(
                                child: Text(
                                  "You don't have Tasks yet",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )

                      ;
                    }
                  }
                ),
              ),

              SizedBox(height: 20,),

              // List of my plantes
              Text('My plantes',style: TextStyle(fontSize: 20),),
              Expanded(
                  child: ConditionalBuilder(
                    condition: planteCareCubit.get(context).myPlantsModel.length>0,
                    builder: (context) =>ListView.separated(
                        itemBuilder: (context, index) => buildMyplantsItem(planteCareCubit.get(context).myPlantsModel[index],context,index),
                        separatorBuilder:(context, index) => SizedBox(height: 0,),
                        itemCount: planteCareCubit.get(context).myPlantsModel.length
                    ) ,
                    fallback: (context) {
                    if (state is planteCareAddPlantToMyPlantsSuccessState || state is planteCareDeletePlantLoadingState) {
                      // Corrected condition to == 0 and fixed the typo in the text
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text('You don\'t have plants yet', style: TextStyle(fontSize: 20)));
                    }
                  }
                    ,),
                ),
            ],
          ),
        ),
           floatingActionButton:  SingleChildScrollView(
             child: FloatingActionButton(
               onPressed: () {
                 if(isBottomSheetShowen)
                   {
                     print(currentDate);
                     // currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
                     // print(currentDate);

                     print(planteCareCubit.get(context).TasksModel.length);
                     Navigator.maybePop(context);

                     isBottomSheetShowen=false;
                   }else
                     {
                       print(planteCareCubit.get(context).getCurrentDateString());

                       currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
                       print(currentDate);
                       scaffoldKey.currentState?.showBottomSheet((context) => Container(
                         color: Colors.grey.shade300,
                           width: double.infinity,
                         height: 300,


                         child: ListView.separated(
                             itemBuilder:(context, index) =>  buildAllThePlants(planteCareCubit.get(context).plantsModel[index],context),
                             separatorBuilder:(context, index) => SizedBox(height: 0,),
                             itemCount: planteCareCubit.get(context).plantsModel.length),

                         ),
                       );
                       isBottomSheetShowen=true;

                     }

               },
               child: Icon(Icons.add),
             ),
           ),
         );
      },

    );


  }



  Widget buildAllThePlants(planteCarePlantsModel item,context)=>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: InkWell(
      onTap:(){
        planteCareCubit.get(context).countTodayTasks();
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);

        planteCareCubit.get(context).addToMyPlantes(
            name: item.name,
            id: item.id,
            image: item.image,
            fertilizeIn: item.fertilizeIn,
            irrigationIn: item.irrigationIn,
            dateTime: formattedDate,
            lastWateredDate: now.toString(),

        );
        Navigator.maybePop(context);
        isBottomSheetShowen=false;

      } ,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200)),

        height: 90,
        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
          ),
          elevation: 20,

          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(

              children: [
                Container(

                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: CircleAvatar(

                    backgroundImage: NetworkImage('${item.image}'),
                  ),



                ),
                Spacer(),
                Text('${item.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,),),
                Spacer(),

                Row(children: [
                  Text('${item.irrigationIn}',style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5,),
                  Text('per week',style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5,),
                  Icon(Icons.water_drop_rounded,color: Colors.blue,size: 15,)

                ],
                ), Spacer(),

                Row (children: [
                  Text('${item.fertilizeIn}',style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5,),
                  Text('per month',style: TextStyle(fontSize: 12)),
                  SizedBox(width: 5,),
                  Icon(Icons.sanitizer_outlined,color: Colors.blue,size: 15,)
                ],
                )

              ],
            ),
          ),
        ),
      ),
    ),
  );


  Widget buildMyplantsItem(planteCarePlantsAddModel item,context,index)=>Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200)),

    height: 90,
    child: Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      elevation: 5,

      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(

          children: [
            Container(

              height: 70,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: CircleAvatar(

                backgroundImage: NetworkImage('${item.image}'),
              ),



            ),
            Spacer(),
            Text('${item.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,),),
            Spacer(),
            Row(children: [
              Text('${item.irrigationIn}',style: TextStyle(fontSize: 12)),
              SizedBox(width: 5,),
              Text('/week',style: TextStyle(fontSize: 12)),
              SizedBox(width: 5,),
              Icon(Icons.water_drop_rounded,color: Colors.blue,size: 15,)

            ],
            ),
            Spacer(),
            Row (children: [
              Text('${item.fertilizeIn}',style: TextStyle(fontSize: 12)),
              SizedBox(width: 5,),
              Text('/month',style: TextStyle(fontSize: 12)),
              SizedBox(width: 5,),
              Icon(Icons.sanitizer_outlined,color: Colors.blue,size: 15,)
            ],
            ),
            Spacer(),
            IconButton(onPressed: (){
              planteCareCubit.get(context).showDeleteConfirmDialog(context,index,item);
            }, icon: Icon(IconBroken.Delete,color: Colors.red,))


          ],
        ),
      ),
    ),
  );


  // Widget buildTasksOfTheDayItem(planteCareTasksModel item,context)=>Container(
  //   decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(200)),
  //
  //   height: 90,
  //   child: Card(
  //
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
  //     ),
  //     elevation: 5,
  //
  //     child: Padding(
  //       padding: const EdgeInsets.all(5.0),
  //       child: Row(
  //
  //         children: [
  //           Container(
  //
  //             height: 70,
  //             width: 60,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20)
  //             ),
  //             child: CircleAvatar(
  //
  //               backgroundImage: NetworkImage('${item.image}'),
  //             ),
  //
  //
  //
  //           ),
  //           Spacer(),
  //           Text('${item.task}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,),),
  //           Spacer(),
  //
  //
  //           Spacer(),
  //
  //           Spacer(),
  //           IconButton(onPressed: (){
  //
  //           }, icon: Icon(IconBroken.Shield_Done,color: Colors.blue,))
  //
  //
  //         ],
  //       ),
  //     ),
  //   ),
  // );

  Widget buildTasksOfTheDayItem(planteCareTasksModel item, BuildContext context) => Dismissible(
    key: Key(item.taskId.toString()),
    background: Container(
      color: Colors.green,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.check, color: Colors.white),
        ),
      ),
    ),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {

      planteCareCubit.get(context).completeTask(item.taskId.toString());
      planteCareCubit.get(context).getAllMyTasksData();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task "${item.task}" is Done')),
      );
    },
    child: ConditionalBuilder(
      condition: currentDate == item.date,
      builder: (context) => ConditionalBuilder(
        condition: !item!.completed!,
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 90,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${item.image}'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${item.task}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                      planteCareCubit.get(context).completeTask(item.taskId.toString());
                      planteCareCubit.get(context).getAllMyTasksData();
                    },
                    icon: Icon(Icons.check_circle, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
        fallback: (context) => SizedBox(), // Adjusted fallback to a more descriptive text
      ),
      fallback: (context) => SizedBox(), // Adjusted fallback to a more descriptive text
    ),
  );









  // Widget buildTasksOfTheDayItem(planteCareTasksModel item, BuildContext context) => ConditionalBuilder(
  //   condition: currentDate == item.date, // Ensure tasks match the current date
  //   builder: (context) => Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20), // Adjusted for consistency
  //     ),
  //     height: 90,
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
  //       ),
  //       elevation: 5,
  //       child: Padding(
  //         padding: const EdgeInsets.all(5.0),
  //         child: Row(
  //           children: [
  //             Container(
  //               height: 70,
  //               width: 60,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               child: CircleAvatar(
  //                 backgroundImage: NetworkImage('${item.image}'),
  //               ),
  //             ),
  //             SizedBox(width: 10), // Added to provide a fixed gap
  //             Expanded( // Use Expanded for text to utilize available space efficiently
  //               child: Text(
  //                 '${item.task}',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 16, // Adjusted font size for better visibility
  //                 ),
  //               ),
  //             ),
  //             IconButton(
  //               onPressed: () {
  //
  //                 planteCareCubit.get(context).completeTask(item.taskId.toString());
  //                 // Your code here
  //               },
  //               icon: Icon(Icons.check_circle, color: Colors.blue), // Adjusted icon for simplicity
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  //   fallback: (context) => SizedBox(), // Adjusted fallback to a more descriptive text
  // );

}
