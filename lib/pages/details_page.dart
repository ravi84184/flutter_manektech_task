import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttermanektechtask/model/RestaurantData.dart';

import 'web_view_page.dart';

class DetailsPage extends StatefulWidget {
  RestaurantData model;

  DetailsPage(this.model);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: FadeInImage(
                      image: NetworkImage(widget.model.thumb),
                      placeholder: AssetImage("assets/img.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewExample(widget.model.photos_url)));
                    },
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )),
                  Positioned(
                      left: 20,
                      right: 0,
                      top: 50,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                              size: 30,
                            )),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.model.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.model.phoneNumbers,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      RatingBar(
                        initialRating: double.parse(widget.model.rating),
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 15,
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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "(",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: [
                            TextSpan(
                                text: "${widget.model.votes} ",
                                style: TextStyle(color: Colors.green)),
                            TextSpan(text: "Reviews )"),
                          ]))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.model.description),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.model.address),
                ],
              ),
            )
          ],
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
