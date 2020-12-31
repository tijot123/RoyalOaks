import 'package:flutter/material.dart';

class CommonBgInnerContainer extends StatelessWidget {
  final Widget child;

  const CommonBgInnerContainer({Key key, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/application_bg.png"), fit: BoxFit.cover)),
      child: child,
    );
  }
}
