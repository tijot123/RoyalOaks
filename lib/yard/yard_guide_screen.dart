import 'package:flutter/material.dart';
import 'package:flutter_app/common/common_bg_inner_container.dart';

class YardGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> yards = [
      "assets/img/yard/one_tee.jpg",
      "assets/img/yard/two_tee.jpg",
      "assets/img/yard/three_tee.jpg",
      "assets/img/yard/four_tee.jpg",
      "assets/img/yard/five_tee.jpg",
      "assets/img/yard/six_tee.jpg",
      "assets/img/yard/seven_tee.jpg",
      "assets/img/yard/eight_tee.jpg",
      "assets/img/yard/nine_tee.jpg",
      "assets/img/yard/ten_tee.jpg",
      "assets/img/yard/eleven_tee.jpg",
      "assets/img/yard/twelve_tee.jpg",
      "assets/img/yard/thirteen_tee.jpg",
      "assets/img/yard/fourteen_tee.jpg",
      "assets/img/yard/fifteen_tee.jpg",
      "assets/img/yard/sixteen_tee.jpg",
      "assets/img/yard/seventeen_tee.jpg",
      "assets/img/yard/eightteen_tee.jpg"
    ];
    return CommonBgInnerContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Yardage Guide"),
        ),
        body: PageView.builder(
            itemCount: yards.length,
            itemBuilder: (ctx, index) {
              return FittedBox(
                  fit: BoxFit.fill, child: Image.asset(yards[index]));
            }),
      ),
    );
  }
}
