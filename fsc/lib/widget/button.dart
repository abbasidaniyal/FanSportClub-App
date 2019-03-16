import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String text = '';
  Function onPress;

  MyButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      minWidth: 200.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Theme.of(context).primaryColor,
        child: Text(text,textScaleFactor: 1.2,),
        onPressed: onPress,
      ),
    );
  }
}
