import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../../modules/plante_care_app/plante_care_login/login_screen.dart';
import '../network/local/cashHelper.dart';
import 'componantes.dart';
// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=d30ccd2d90d24e568709d628942aab7c

// https://newsapi.org/v2/everything?q=tesla&apiKey=d30ccd2d90d24e568709d628942aab7c//


void signOut(context){
  CasheHelper().removeData(key:'token').then((value)
  {
    navigateAndFinish(context, planteCareLoginScreen());
  });


}

dynamic token='';

dynamic uId='';

dynamic currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());