
import 'package:flutter/material.dart';
import 'package:login_flutter_app/UtilityClasses/utility.dart';
import 'package:login_flutter_app/constant.dart';
import 'package:share/share.dart';
import 'package:login_flutter_app/ModalClass/db_wrapper.dart';

class Popup extends StatelessWidget {
  Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {
    String appUrl = Utility.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kGooglePlayUrl);
    String portfolioUrl = Utility.getPlatformSpecificUrl(
        iOSUrl: kAppPortfolioApple, androidUrl: kappPortfolioGoogle);

    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Selected value: $value');
          if (value == rMoreOptionKeys.clearAll.index) {
            Utility.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
                  DBWrapper.sharedInstance.deleteAllDoneTodos();
                  getTodosAndDones();
                });
          } else if (value == rMoreOptionKeys.moreApps.index) {
            Utility.launchURL(portfolioUrl);
          } else if (value == rMoreOptionKeys.aboutUs.index) {
            Utility.launchURL(kAboutPageUrl);
          } else if (value == rMoreOptionKeys.shareApp.index) {
            Share.share('Check out this awesome app ' + appUrl);
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();

          for (int i = 0; i < rMoreOptionsMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(rMoreOptionsMap[i])));

            if (i == 0) {
              list.add(PopupMenuDivider(
                height: 5,
              ));
            }
          }

          return list;
        });
  }
}
