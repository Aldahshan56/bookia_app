import 'package:flutter/material.dart';

pushTo(BuildContext context, Widget newScreen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => newScreen));
}

pushWithReplacement(BuildContext context, Widget newScreen) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => newScreen));
}

pushAndRemoveUntil(BuildContext context, Widget newScreen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
    return newScreen;
  }), (route) => false);
}
