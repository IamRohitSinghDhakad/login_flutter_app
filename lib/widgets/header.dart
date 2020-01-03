import 'package:flutter/material.dart';

class Header extends StatelessWidget{
  final String msg;

  Header({this.msg});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LimitedBox(
      child: Container(
        padding: EdgeInsets.only(left: 15.0, top: 30.0),
        child: Text(msg, style: Theme.of(context).textTheme.headline.copyWith(fontFamily: ""),),

      ),
    );
  }


}