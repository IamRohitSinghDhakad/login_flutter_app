import 'package:flutter/material.dart';
import 'package:login_flutter_app/UtilityClasses/appColors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

enum rMoreOptionKeys{
  clearAll,
  moreApps,
  aboutUs,
  shareApp,
}

Map<int, String> rMoreOptionsMap = {
  rMoreOptionKeys.clearAll.index: "Clear Done",
  rMoreOptionKeys.moreApps.index: "More Apps",
  rMoreOptionKeys.aboutUs.index: "About Us",
  rMoreOptionKeys.shareApp.index: "Share App",
};

class Utility{
  static void hideKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static String getWelcomeMessage(){
    final hour = DateTime.now().hour;
    String msg;

    if (hour < 12){
      msg = "Good Morning";
    }else if (hour < 18){
      msg = "Good Afternoon";
    }else {
      msg = "Good Evening";
    }
    return msg;
  }

  static void launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    }else{
      print("Could not launch $url");
    }
  }

  static String getPlatformSpecificUrl({String iOSUrl, String androidUrl}){
    if (Platform.isIOS){
      return iOSUrl;
    }else if(Platform.isAndroid){
      return androidUrl;
    }
  }

  static void showCustomDialog(BuildContext context,{
    String title,
    String msg,
    String noBtnTitle: "Close",
    Function onConfirm,
    String confirmBtnTitle: "Yes"}) {

    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        if (onConfirm != null)
          RaisedButton(
            color: Color(AppColors.kPrimaryColorCode),
            onPressed: (){
              onConfirm();
              Navigator.pop(context);
            },
            child: Text(
              confirmBtnTitle,
              style: TextStyle(
                  color: Colors.white,
              ),
            ),
          ),
        RaisedButton(
          color: Color(AppColors.kSecondaryColorCode),
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            noBtnTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  showDialog(context: context, builder: (x) => dialog);
  }

}


