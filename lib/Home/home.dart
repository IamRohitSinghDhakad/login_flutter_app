import 'dart:html';

import 'package:flutter/material.dart';
import 'package:login_flutter_app/Drawer/side_drawer.dart';
import 'package:login_flutter_app/ModalClass/todo_model.dart' as Model;
import 'package:login_flutter_app/UtilityClasses/utility.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(backgroundColor: Color(0xfffff5eb)),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _title = "Home";
  String welcomeMsg;
  //make
  List<Model.Todo> todos;
  List<Model.Todo> dones;


  @override
  void initState(){
    super.initState();
    welcomeMsg = Utility.getWelcomeMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(_title),
//        backgroundColor: Colors.blue,
//      ),
        drawer: SideMenu(kuchbhi: (str){
          setState(() {
            _title = str;
          });
        },) ,

      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            Utility.hideKeyboard(context);
          },
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(

                backgroundColor: Theme.of(context).backgroundColor,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(_title),
                  background: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Header(

                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),

              )
            ],
          ),
        ),



      ),
    );
  }
}
