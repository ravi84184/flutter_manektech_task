import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'image_widget.dart';

class RestaurantWidget extends StatelessWidget {
  double rating = 3;
  String name, image;
  var onClick;
  var onMapClick;

  RestaurantWidget(
      {this.rating, this.name, this.image, this.onClick, this.onMapClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onClick,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: <Widget>[
              ImageWidget(
                image: image,
                height: 70,
                width: 70,
              ),
              Expanded(
                child: Container(
                  height: 70,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      RatingBar(
                        initialRating: rating,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 20,
                        ignoreGestures: true,
                        ratingWidget: RatingWidget(
                          full: _image('assets/Star-fill.png'),
                          half: _image('assets/Star-empty.png'),
                          empty: _image('assets/Star-empty.png'),
                        ),
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onMapClick,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.green),
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/map.png",
                    height: 30,
                    width: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(image) {
    return Image.asset(
      image,
      height: 20,
      width: 20,
    );
  }
}
