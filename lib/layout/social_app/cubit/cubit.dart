import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/layout/social_app/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../models/models_plante_care_app/plante_care_plants_add_model.dart';
import '../../../models/models_plante_care_app/plante_care_plants_model.dart';
import '../../../models/models_plante_care_app/plante_care_plants_tasks_model.dart';
import '../../../models/models_plante_care_app/plante_care_user_model.dart';

import '../../../modules/plante_care_app/home/home_screen.dart';
import '../../../modules/plante_care_app/image_scan/image_scan_screen.dart';
import '../../../modules/plante_care_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import '../../../shared/network/local/cashHelper.dart';

class planteCareCubit extends Cubit<planteCareStates>
{ //same

  planteCareCubit() :super(planteCareInitialState());

  static planteCareCubit get(context)=>BlocProvider.of(context);
//change
  planteCareUserModel ? usermodel;



  void getUserData() {
    emit(planteCareGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(CasheHelper.getData(key: 'uId')).get().then((value) {
      print(value.data());
      usermodel = planteCareUserModel.fromJson(value.data()!);
      emit(planteCareGetUserSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(planteCareGetUserErrorState(error.toString()));
      print('uid b nulllllllllllllllllllllll');
    });
  }

  List<String> MyPlantesIds=[];

  int currentIndex=0;
  List<String> titles=[
    'Home',
    'camera',
    'Settings',
  ];
  List<Widget> screens=[
    homeScreen(),
    imageScanScreen(),
    settingsScreeen(),

  ];

  void changeBottomNav(int index)
  {

        currentIndex =index;
        emit(planteCareChangeBottomNavState());


  }


  File ? profileImage;
  var picker= ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile =await picker.pickImage(
        source:ImageSource.gallery);
    if(pickedFile!=null)
    {
      profileImage=File(pickedFile.path);
      emit(planteCareProfileImagePickedSuccessState());

    }else
    {
      print('No image selected');
      emit(planteCareProfileImagePickedErrorState());
    }

  }



  File ? coverImage;

  Future<void> getCoveImage() async
  {
    final pickedFile =await picker.pickImage(
        source:ImageSource.gallery);
    if(pickedFile!=null)
    {
      coverImage=File(pickedFile.path);
      emit(planteCareCoverImagePickedSuccessState());

    }else
    {
      print('No image selected');
      emit(planteCareCoverImagePickedErrorState());
    }

  }

  void uploadProfileImage({
    @required String ?name,
    @required String ?phone,
    @required String ?bio,
})
  {
    emit(planteCareUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value) {

                // emit(SocialUploadProfileImageSuccessState());
                print(value);
                updateuser(name: name, phone: phone, bio: bio,image: value);

          })
              .catchError((error){
            emit(planteCareUploudProfileImageErrorState());
          });
    })
        .catchError((error){
      emit(planteCareUploudProfileImageErrorState());
    });
  }
  void uploadCoverImage({
    @required String ?name,
    @required String ?phone,
    @required String ?bio,
})
  {
    emit(planteCareUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {

        // emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateuser(name: name, phone: phone, bio: bio,cover: value);
      })
          .catchError((error){
        emit(planteCareUploudCoverImageErrorState());
      });
    })
        .catchError((error){
      emit(planteCareUploudCoverImageErrorState());
    });
  }



  void updateuser(
      {
        @required String ?name,
        @required String ?phone,
        @required String ?bio,
        String ?cover,
        String ?image,
}
      )



  {
    planteCareUserModel model=planteCareUserModel(

      name: name,
      phone: phone,
      bio:bio,
      email: usermodel!.email,
      image: image??usermodel!.image,
      uId: usermodel!.uId,
      coverImage: cover??usermodel!.coverImage,
      isEmailVerified: usermodel!.isEmailVerified,

    );
    FirebaseFirestore.instance.collection('users')
        .doc(usermodel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    })
        .catchError((error){
      emit(planteCareUserUpdateErrorState());
    });
  }


  List<planteCarePlantsModel> plantsModel=[];


  void getAllPlantsData() {

    emit(planteCareGetAllPlantsLoadingState());
    plantsModel=[];

    FirebaseFirestore.instance.collection('plantsDataBase').orderBy('id').get().then((value) {

      value.docs.forEach((element) {
           plantsModel.add(planteCarePlantsModel.fromJson(element.data()));});

           emit(planteCareGetAllPlantsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(planteCareGetAllPlantsErrorState(error.toString()));

    });
  }




  List<planteCarePlantsAddModel> myPlantsModel=[];


  void getAllMyPlantsData() {

    emit(planteCareGetAllMyPlantsLoadingState());
    myPlantsModel=[];
    MyPlantesIds=[];

    FirebaseFirestore.instance.collection('users').doc(CasheHelper.getData(key: 'uId')).collection('myPlants').orderBy('createdAt').get().then((value) {

      value.docs.forEach((element) {

        myPlantsModel.add(planteCarePlantsAddModel.fromJson(element.data()));
        MyPlantesIds.add(element.id);
      });

      emit(planteCareGetAllMyPlantsSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(planteCareGetAllMyPlantsErrorState(error.toString()));

    });
  }







  void deleteSpecificPlant(int plantId) async {
    String userId = CasheHelper.getData(key: 'uId');
    String idOfPlantWantToDelete = MyPlantesIds[plantId];

    // First, delete the plant document itself
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('myPlants')
        .doc(idOfPlantWantToDelete)
        .delete()
        .then((_) {
      print("Plant document deleted successfully");
      // Then, proceed to delete all related tasks
      deleteRelatedTasks(userId, idOfPlantWantToDelete);
    })
        .catchError((error) {
      print("Error deleting plant document: $error");
    });
  }

  void deleteRelatedTasks(String userId, String plantId) async {
    // Query all tasks related to the plantId
    var tasksCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Tasks')
        .where('plantId', isEqualTo: plantId);

    // Retrieve the tasks
    var querySnapshot = await tasksCollection.get();

    // Use a Future.wait to delete all tasks concurrently and wait for all to complete
    await Future.wait(querySnapshot.docs.map((doc) => doc.reference.delete()));

    // After all deletions are complete, refresh the tasks data
    getAllMyTasksData();
  }









  void removePlantById(List<String> plants, String idToRemove) {
    plants.removeWhere((plant) => plant == idToRemove);
  }

void addToMyPlantes(
      {
  @required String ? name,
  @required int ? id,
  @required String ? image,
  @required int ? fertilizeIn,
  @required int ? irrigationIn,
  @required String ? dateTime,
  @required String ? lastWateredDate,




      })
{
  emit(planteCareAddPlantToMyPlantsLoadingState());
  planteCarePlantsAddModel model=planteCarePlantsAddModel(
      name:name,
      id:id,
    image:image,
    fertilizeIn:fertilizeIn,
    irrigationIn:irrigationIn,
    dateTime:dateTime,
    lastWateredDate:lastWateredDate,


  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(usermodel?.uId)
      .collection('myPlants')
      .add(model.toMap())
      .then((DocumentReference documentReference) {

    String documentId = documentReference.id;
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel?.uId)
        .collection('myPlants')
        .doc(documentId)
        .update({'idForTasks': documentId})
        .then((_) {
      model.idForTasks = documentId;
       getAllMyPlantsData();
       print(model.idForTasks);
      emit(planteCareAddPlantToMyPlantsSuccessState());
      saveWateringTask(model);



    })
        .catchError((error) {
      print("Error updating document: $error");
      emit(planteCareAddPlantToMyPlantsErrorState(error));
    });
  })
      .catchError((error) {
    emit(planteCareAddPlantToMyPlantsErrorState(error));
    print(error.toString());
  });
}

  showDeleteConfirmDialog(BuildContext context,index,item) {
    // Show dialog returns a Future that can be awaited to get the user action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        emit(planteCareDeletePlantLoadingState());
       String name=item.name;
        return AlertDialog(

          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete $name '),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Dismiss the dialog and return false
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); // Dismiss the dialog and return true
              },
            ),
          ],
        );
      },
    ).then((result) {
      if (result) {
        deleteSpecificPlant(index);
        getAllMyPlantsData();
        emit(planteCareDeletePlantSuccessState());


      } else {
        emit(planteCareDeletePlantSuccessState());


      }
    });
  }


  void saveWateringTask(planteCarePlantsAddModel plant) async {
    final nextWateringDates = getNextWateringDates(plant.irrigationIn!);
    for (final date in nextWateringDates) {

      String formattedDate = DateFormat('yyyy-MM-dd').format(date);


      DocumentReference docRef = await FirebaseFirestore.instance.collection('users').doc(usermodel?.uId).collection('Tasks').add({
        'plantId': plant.idForTasks.toString(),
        'task': 'Water ${plant.name}',
        'date': formattedDate, // Use the formatted date
        'completed': false,
        'image': plant.image,

      });

      await docRef.update({
        'taskId': docRef.id,
      });

    }
    emit(planteCareAddTasksSuccessState());
  }


  // void saveWateringTask(planteCarePlantsAddModel plant) async {
  //   final nextWateringDates = getNextWateringDates(plant!.irrigationIn!);
  //   for (final date in nextWateringDates) {
  //     // Format the date to "YYYY-MM-DD"
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //
  //     await FirebaseFirestore.instance.collection('users').doc(usermodel?.uId).collection('Tasks').add({
  //       'plantId': plant.idForTasks.toString(),
  //       'task': 'Water ${plant.name}',
  //       'date': formattedDate, // Use the formatted date
  //       'completed': false,
  //       'image':plant.image,
  //     });
  //   }
  //   emit(planteCareAddTasksSuccessState());
  //
  // }

  List<DateTime> getNextWateringDates(int wateringFrequency) {
    DateTime today = DateTime.now();
    List<DateTime> nextWateringDates = [];
    DateTime oneWeekFromNow = today.add(Duration(days: 7));

    int intervalDays = 7 ~/ wateringFrequency;

    for (int i = 1; i <= wateringFrequency && today.add(Duration(days: intervalDays * i)).isBefore(oneWeekFromNow); i++) {
      DateTime nextWateringDate = today.add(Duration(days: intervalDays * i));
      nextWateringDates.add(nextWateringDate);
    }

    return nextWateringDates;
  }


  Future<void> refreshTasks() async {
    final Completer<void> completer = Completer<void>();

    setCurrentDate(DateTime.now());
    currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
    getAllMyTasksData();
    countTodayTasks();


    completer.complete();
    return completer.future;
  }


  List<planteCareTasksModel> TasksModel =[];

  void getAllMyTasksData() {
    emit(planteCareGetTasksLoadingState());
    TasksModel.clear(); // Assuming TasksModel is a List<PlanteCareTasksModel>

    FirebaseFirestore.instance
        .collection('users')
        .doc(CasheHelper.getData(key: 'uId'))
        .collection('Tasks')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        TasksModel.add(planteCareTasksModel.fromJson(element.data(), docId: element.id));
      });

      emit(planteCareGetTasksSucssesState());
    }).catchError((error) {
      print(error.toString());
      emit(planteCareGetTasksErrorState(error.toString()));
    });
  }




  int countTodayTasks() {
    String todayFormatted = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var todayTasks = TasksModel.where((task) {
      // Parse the task's date
      DateTime taskDate = DateFormat('yyyy-MM-dd').parse(task!.date!);
      String taskDateFormatted = DateFormat('yyyy-MM-dd').format(taskDate);

      // Check if the task's date is today and the task is not completed
      return taskDateFormatted == todayFormatted && task.completed == false;
    }).toList();

    return todayTasks.length;
  }


  void completeTask(String id) {



      FirebaseFirestore.instance
          .collection('users')
          .doc(CasheHelper.getData(key: 'uId'))
          .collection('Tasks')
          .doc(id)
          .update({'completed': true})
          .then((_) {
        // Assuming this function is part of a Bloc or Cubit, you might want to emit a state indicating success
        emit(PlantCareTaskCompletedSuccessState());
      })
          .catchError((error) {
        // Handle errors, for example by emitting an error state
      emit(PlantCareTaskCompletedErrorState(error.toString()));
      });

  }



  DateTime getCurrentDate() => DateTime.now();
  String getCurrentDateString() => DateFormat('yyyy-MM-dd').format(DateTime.now());
// to handle the day change
  Timer? _timer;



  void setCurrentDate(DateTime currentDate) {

    // Optionally do something with the current date
    // For now, just schedule the function for the next midnight
    _scheduleNextMidnight();

  }


  void _scheduleNextMidnight() {
    _timer?.cancel(); // Cancel any existing timer

    DateTime now = DateTime.now();
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);
    Duration timeUntilMidnight = nextMidnight.difference(now);

    _timer = Timer(timeUntilMidnight, () {
      _triggerFunction();
    });
  }

  void _triggerFunction() {
    // This is where you execute the function you want to run at midnight

     getAllMyTasksData();

    currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
    print("the day changed");
    emit(FunctionTriggered());

    // Schedule the next trigger
    _scheduleNextMidnight();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }


}
//  void sendMessage(
//       {
//           @required String ? receiverId,
//           @required String ? dateTime,
//           @required String ? text,
//
//       }
//      )
//  {
// MessageModel model=MessageModel(
//   dateTime: dateTime,
//   reseverId: receiverId,
//   text: text,
//   senderId: usermodel?.uId,
// );
// //set my chats
// FirebaseFirestore
//     .instance
//     .collection('users')
//     .doc(usermodel?.uId)
//     .collection('chats')
//     .doc(receiverId)
//     .collection('messages')
//     .add(model.toMap())
//     .then((value) {
//       emit(SocialSendMessageSuccessState());
// })
//     .catchError((error){
//       emit(SocialSendMessageErrorState());
//       print(error.toString());});
//







//     void getAllUsers()
//
//     {
//       users=[];
//       FirebaseFirestore
//           .instance
//           .collection('users')
//           .get()
//           .then((value) {
//             value.docs.forEach((element) {
//               if(element.data()['uId']!=usermodel?.uId)
//              users.add(SocialUserModel.fromJson(element.data()));
//             });
//             emit(SocialGetAllUsersSuccessState());
//
//       })
//           .catchError((error){
//             print(error.toString());
//             emit(SocialGetAllUsersErrorState(error.toString()));
//           });
//
//     }












//
//   File ? postImage;
//
//   Future<void> getpostImage() async
//   {
//     final pickedFile =await picker.pickImage(
//         source:ImageSource.gallery);
//     if(pickedFile!=null)
//     {
//       postImage=File(pickedFile.path);
//       emit(SocialPostImagePickedSuccessState());
//
//     }else
//     {
//       print('No image selected');
//       emit(SocialPostImagePickedErrorState());
//     }
//
//   }
//
//   void uploadPostImage({
//
//     @required String ? dateTime,
//     @required String ? text,
//
//   })
//   {
//     emit(SocialCreatePostLoadingState());
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
//         .putFile(postImage!)
//         .then((value) {
//       value.ref.getDownloadURL()
//           .then((value) {
//
//
//         print(value);
//         createPost(dateTime: dateTime, text: text,postImage: value);
//
//       })
//           .catchError((error){
//         emit(SocialCreatePostErrorState());
//       });
//     })
//         .catchError((error){
//       emit(SocialCreatePostErrorState());
//     });
//   }
//
//
//   void createPost(
//       {
//         @required String ? dateTime,
//         @required String ? text,
//         String ? postImage,
//       }
//       )
//   {
//     emit(SocialCreatePostLoadingState());
//     PostModel model=PostModel(
//       name: usermodel!.name,
//       image: usermodel!.image,
//       uId: usermodel!.uId,
//       text:text,
//       postImage:postImage??'',
//       dateTime:dateTime,
//     );
//     FirebaseFirestore.instance
//         .collection('posts')
//         .add(model.toMap())
//         .then((value) {
//           emit(SocialCreatePostSuccessState());
//
//     })
//         .catchError((error){
//       emit(SocialCreatePostErrorState());
//     });
//   }
//
//   void removePostImage()
//       {
//         postImage=null;
//         emit(SocialPostImageRemovedSuccsesState());
//       }
//       List<PostModel> posts=[];
//       List<String> postId=[];
//
//       void getPosts()
//       {
//         FirebaseFirestore
//             .instance
//             .collection('posts')
//             .get()
//             .then((value) {
//               value.docs.forEach((element) {
//
//                 posts.add(PostModel.fromJson(element.data()));
//                 postId.add(element.id);
//
//               });
//
//               emit(SocialGetPostsSuccessState());
//         })
//             .catchError((error){
//               emit(SocialGetPostsErrorState(error.toString()));
//         });
//       }
//     void likePost(String postId)
//     {
//       FirebaseFirestore
//           .instance
//           .collection('posts')
//           .doc(postId)
//           .collection('likes')
//           .doc(usermodel?.uId)
//           .set({'like':true})
//           .then((value) {
//             emit(SocialLikePostSuccessState());
//       })
//           .catchError((error){
//             emit(SocialLikePostErrorState(error.toString()));
//       });
//     }
// List<SocialUserModel> users=[];
//     void getAllUsers()
//
//     {
//       users=[];
//       FirebaseFirestore
//           .instance
//           .collection('users')
//           .get()
//           .then((value) {
//             value.docs.forEach((element) {
//               if(element.data()['uId']!=usermodel?.uId)
//              users.add(SocialUserModel.fromJson(element.data()));
//             });
//             emit(SocialGetAllUsersSuccessState());
//
//       })
//           .catchError((error){
//             print(error.toString());
//             emit(SocialGetAllUsersErrorState(error.toString()));
//           });
//
//     }
//
//  void sendMessage(
//       {
//           @required String ? receiverId,
//           @required String ? dateTime,
//           @required String ? text,
//
//       }
//      )
//  {
  // MessageModel model=MessageModel(
  //   dateTime: dateTime,
  //   reseverId: receiverId,
  //   text: text,
  //   senderId: usermodel?.uId,
  // );
  // //set my chats
  // FirebaseFirestore
  //     .instance
  //     .collection('users')
  //     .doc(usermodel?.uId)
  //     .collection('chats')
  //     .doc(receiverId)
  //     .collection('messages')
  //     .add(model.toMap())
  //     .then((value) {
  //       emit(SocialSendMessageSuccessState());
  // })
  //     .catchError((error){
  //       emit(SocialSendMessageErrorState());
  //       print(error.toString());});
  //
  // //set reciver chats
  //
  // FirebaseFirestore
  //     .instance
  //     .collection('users')
  //     .doc(receiverId)
  //     .collection('chats')
  //     .doc(usermodel?.uId)
  //     .collection('messages')
  //     .add(model.toMap())
  //     .then((value) {
  //   emit(SocialSendMessageSuccessState());
  // })
  //     .catchError((error){
  //   emit(SocialSendMessageErrorState());
  //   print(error.toString());});


 // List<MessageModel>messages=[];
 //    void getMessages({
 //      @required String ? receiverId,
 //    })
 //    {
 //      FirebaseFirestore
 //          .instance
 //          .collection('users')
 //          .doc(usermodel?.uId)
 //          .collection('chats')
 //          .doc(receiverId)
 //          .collection('messages')
 //          .orderBy('dateTime')
 //          .snapshots()
 //          .listen((event)
 //          {
 //            messages=[];
 //            event.docs.forEach((element)
 //            {
 //              messages.add(MessageModel.fromJson(element.data()));
 //            });
 //            emit(SocialGetMessagesSuccessState());
 //
 //          });
 //    }
