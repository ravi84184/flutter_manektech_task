import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttermanektechtask/database/repository_service.dart';
import 'package:fluttermanektechtask/model/RestaurantData.dart';
import 'package:fluttermanektechtask/widget/restaurant_widget.dart';
import 'package:http/http.dart' as http;
import 'package:permission/permission.dart';

import 'details_page.dart';
import 'map_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantData> restaurentList = [];
  ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  int _pageNo = 1;
  bool _isLastPage = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    RepositoryService.restaurantsCount().then((value) {
      if (value > 0) {
        fetchDataLocal(isFirstLoad: true);
      } else {
        getApiCall().then((value) async {
          await RepositoryService.addAllRestaurants(value);
          fetchDataLocal(isFirstLoad: true);
        });
      }
    });
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        if (!_isLastPage) {
          _isLoading = true;
          _pageNo += 1;
          fetchDataLocal(isFirstLoad: false);
        }
      });
    }
  }

  Future<Null> fetchDataLocal({bool isFirstLoad = true}) {
    if (isFirstLoad) {
      _isLoading = true;
      _pageNo = 1;
      _isLastPage = false;
    }
    return RepositoryService.getRestaurants(restaurentList.length)
        .then((items) {
      setState(() {
        _isLoading = false;
      });
      if (_pageNo == 1) {
        restaurentList.clear();
      }
      _isLastPage = items.length < 10;
      restaurentList.addAll(items);
    });
  }

  Future<List<RestaurantData>> getApiCall() async {
    _isLoading = true;
    var response = await http.get(
        Uri.encodeFull(
            "http://developers.zomato.com/api/v2.1/search?entity_id=280&entity_type=city&start=0&count=40&collection_id=1"),
        headers: {
          "Accept": "application/json",
          "user-key": "e28a8297677194d81d39a8f271940705"
        });
    Map<String, Object> data = json.decode(response.body);
    final List body = data['restaurants'];
    List _resList = <RestaurantData>[];
    _resList.addAll(
        body.map((c) => RestaurantData.fromAPIJson(c['restaurant'])).toList());

    return _resList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: restaurentList.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  RestaurantData model = restaurentList[index];
                  return RestaurantWidget(
                    name: model.name.toString(),
                    rating: double.parse(model.rating),
                    image: model.thumb,
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(model)));
                    },
                    onMapClick: () {
                      requestPermissions(model);
                    },
                  );
                },
              ),
            ),
            _isLoading ? CircularProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }

  requestPermissions(model) async {
    List<PermissionName> permissionNames = [];
    permissionNames.add(PermissionName.Location);
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((permission) {
      if (permission.permissionStatus == PermissionStatus.allow) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MapPage(model.latitude, model.longitude)));
      }
      print('${permission.permissionName}: ${permission.permissionStatus}\n');
    });
  }
}
