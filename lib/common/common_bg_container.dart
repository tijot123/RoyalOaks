import 'package:flutter/material.dart';

class CommonBackgroundContainer extends StatelessWidget {
  final Widget child;

  const CommonBackgroundContainer({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/bg.png"), fit: BoxFit.cover)),
      child: child,
    );
  }
}
