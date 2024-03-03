import 'dart:ffi';


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_projects/shared/styles/icon_broken.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../styles/colors.dart';

Widget defultButton({

  bool isUpperCase=true,
  double width=double.infinity,
  Color background =Colors.blue,
  double raduis=10,
  required VoidCallback onPressedFunction,
  required String text,
  })=>Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(raduis),
    color: background,
  ),
  child: MaterialButton(onPressed: onPressedFunction,


    child: Text(isUpperCase?text.toUpperCase():text,style: TextStyle(color: Colors.white),),

  ),
);


AppBar  defultAppBar(
{
  @required BuildContext ? context,
  String ? title,
  List<Widget> ? actions,
}
    )=>
    AppBar(
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context!);
        },

        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5,
      title: Text(title!),
      actions: actions,
);



Widget defultTextButton(
{
 required var text,
  required VoidCallback onPressed,


}
    )=>
    TextButton(onPressed: onPressed, child: Text(text));
// ............................................................


Widget defultFormField({
  required TextEditingController controller,
  required TextInputType keyboardtybe,
  required String labeltext,
  void Function(String)? onSubmit,
  required String? Function(String?) validate,
  IconData ? prefix,
  IconData ? suffix,
  isPassword =false,
  void Function()? suffixPressed,
  void Function()? onTap,
  bool isClickable=true,
  Function(String)?onChange,


})=>TextFormField(
controller: controller,
enabled: isClickable,
keyboardType: keyboardtybe,
decoration: InputDecoration(
labelText: labeltext,
prefixIcon: Icon(prefix),
border: OutlineInputBorder(),
suffixIcon: IconButton(
  onPressed: suffixPressed,
    icon: Icon(suffix)),
),
obscureText: isPassword,
onFieldSubmitted:onSubmit,
validator: validate,
  onTap: onTap,
  onChanged: onChange,
);













void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
      builder:(context)=>widget)
);

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder:(context)=>widget),(route) => false,
);




void DefultFlutterToast({
  required massege,
  required color,
  var lenght=Toast.LENGTH_LONG,
  var gravity=ToastGravity.BOTTOM,
  int time=5,
  var textColor=Colors.green,
  double fontSize=16,

}) => Fluttertoast.showToast(
msg: massege,
toastLength: lenght,
gravity: gravity,
timeInSecForIosWeb:time,
backgroundColor: color,
textColor: textColor,
fontSize: fontSize,
);