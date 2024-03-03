




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/modules/plante_care_app/plante_care_login/login_screen.dart';
import 'package:flutter_projects/shared/components/componantes.dart';
import 'package:flutter_projects/shared/network/local/cashHelper.dart';
import 'package:flutter_projects/shared/styles/icon_broken.dart';
import 'package:flutter_projects/shared/styles/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel

{
final String ? image;
final String ? title;
final String ? body;

BordingModel({
  @required this.image,
  @required this.title,
  @required this.body,
});

}
var onBordingController =PageController();

class onBordingScreen extends StatefulWidget {


  @override
  State<onBordingScreen> createState() => _onBordingScreenState();
}

class _onBordingScreenState extends State<onBordingScreen> {
  List<BordingModel> boarding=[
    BordingModel(
        image: 'assets/images/onBording5.png',
        title: 'Welcome',
        body: 'we are trying to help your plants'),
    BordingModel(
        image: 'assets/images/onBording4.png',
        title: 'Plant irrigation',
        body: 'We help you not to forget irrigation your plants'),
    BordingModel(
        image: 'assets/images/onBording6.png',
        title: 'Leaf disease detection',
        body: 'By the help of AI we can help you to detect some leaf disease'),
  ];

  bool isLast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
                onPressed: (){
                  CasheHelper
                      .saveData(key: 'onBoarding', value: true)
                      .then((value) {
                    navigateAndFinish(context, planteCareLoginScreen());
                  })
                      .catchError(
                          (error){
                            print(error.toString());
                          });
                  },
                child:
                Text('SKIP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                )),
          )
        ],
      ),

      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: onBordingController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index==boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });

                    }else
                      {
                        setState(() {
                          isLast=false;
                        });
                      }
                },

                itemBuilder: (context,index)=>buildBordringItem(boarding[index]),
                itemCount:boarding.length,

              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: onBordingController,
                    count: boarding.length,
                    effect:ExpandingDotsEffect(
                      dotColor: CupertinoColors.inactiveGray,
                      activeDotColor: defultColor,
                    ) ,
                ),

                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast==true){
                    CasheHelper
                        .saveData(key: 'onBoarding', value: true)
                        .then((value) {
                      navigateAndFinish(context, planteCareLoginScreen());
                    })
                        .catchError(
                            (error){
                          print(error.toString());
                        });
                  }else
                  onBordingController.nextPage(duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);


                },
                child:  Icon(IconBroken.Arrow___Right_2,size: 30,)
                  )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBordringItem(BordingModel item)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Expanded(child:

      Center(child: Image(image: AssetImage('${item.image}')))),
      SizedBox(height: 30,),
      Text('${item.title}',style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),),
      SizedBox(height: 30,),
      Text('${item.body}',style: TextStyle(
        fontSize: 18,
      ),),
      SizedBox(height: 30,),

    ],
  );
}
