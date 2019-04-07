import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  String text = '';
  Function onPress;
  dynamic args;

  MyButton(this.text, this.onPress, {this.args});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      minWidth: 200.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).accentColor,
        child: Text(text,textScaleFactor: 1.2,),
        onPressed: args==null? ()=>onPress(): ()=>onPress(args),
      ),
    );
  }
}
