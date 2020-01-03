import 'package:flutter/material.dart';
import 'package:login_flutter_app/Animation/FadeAnimation.dart';
import 'package:login_flutter_app/ModalClass/side_menu_option.dart';


class SideMenu extends StatefulWidget {
  int _selected_index = 0;
  final kuchbhi;
  SideMenu({this.kuchbhi});

  @override
  SideMenuState createState() => SideMenuState(kuchbhi);
}

class SideMenuState extends State<SideMenu> {
  final kuchbhi;
  SideMenuState(this.kuchbhi);

  @override
  Widget build(BuildContext context) {

    var arrListItem = this.fillDataModal();
    var arrMenu = <Widget>[];
    for (var i = 0; i < arrListItem.length; i++){

      if (arrListItem[i].name == "Divider") {
        arrMenu.add(Divider());
      }else if (arrListItem[i].name == ""){

        arrMenu.add(Container(
          height: 200,

          child: Stack(
            children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                        ),
                      FadeAnimation(0.1,Container(
                        height: 100,

                  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/flutter.png")
                        )
                  ),
                )),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Rohit Singh Dhakad",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                        Text("rdxsingh30@gmail.com",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),)
                    ])
            ],
          ),
        ));

      }else{
        arrMenu.add(Container(
          child: ListTile(
            title: Text(arrListItem[i].name),
            leading: CircleAvatar(
              backgroundImage: arrListItem[i].image,
              backgroundColor: Colors.white,
              radius: 15,
            ),
            onTap: (){
              _onMenuSelected(i);
              kuchbhi(arrListItem[i].name);
              Navigator.of(context).pop();
            },
          ),
        ));
      }
    }

    return Drawer(
      child: ListView(
        children: arrMenu,
      ),


    );
  }

  void _snackBar(String text){
   Scaffold.of(context).showSnackBar(SnackBar(content: Text("$text clicked")));
  }

  void _onMenuSelected(int index){
    setState(() {
      widget._selected_index = index;
      if(index == 7){
        Navigator.of(context).pop();
      }
    });
  }


  List<SideMenuModal>fillDataModal(){

    var arr = [

      SideMenuModal(name: "",image: AssetImage("")),
      SideMenuModal(name: "Home",image: AssetImage("assets/images/home.png")),
      SideMenuModal(name: "My Account",image: AssetImage("assets/images/account.png")),
      SideMenuModal(name: "Divider",isDivider: true),
      SideMenuModal(name: "About",image: AssetImage("assets/images/about.png")),
      SideMenuModal(name: "Setting",image: AssetImage("assets/images/setting.png")),
      SideMenuModal(name: "Divider",isDivider: true),
      SideMenuModal(name: "Logout",image: AssetImage("assets/images/logout.png")),

    ];
    return arr;

  }

}


typedef kuchbhi = void Function(String);
