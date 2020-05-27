import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  String image;
  double height, width;

  ImageWidget(
      {this.image = "assets/img.png", this.height = 60, this.width = 60});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        child: FadeInImage(
          height: height,
          width: width,
          image: NetworkImage(image),
          placeholder: AssetImage("assets/img.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
