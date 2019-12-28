import 'package:flutter/material.dart';
import 'package:login_flutter_app/Drawer/side_drawer.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _title = "Home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        backgroundColor: Colors.blue,
      ),
        drawer: SideMenu(kuchbhi: (str){
          setState(() {
            _title = str;
          });
        },) ,

      body: SingleChildScrollView(



      ),
    );
  }
}
