// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'cart_page.dart';

const List<Map<String, String>> categories = [
  {
    'id': '1',
    'title': 'Top offres',
  },
  {
    'id': '2',
    'title': 'Grocery',
  },
  {
    'id': '3',
    'title': 'Mobiles',
  },
  {
    'id': '4',
    'title': 'Fashion',
  },
  {
    'id': '5',
    'title': 'Electronics',
  },
  {
    'id': '6',
    'title': 'Home',
  },
];

class HomePage extends StatelessWidget {
  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 5;
  int _crossAxisCount = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping App'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, CartPage.routeName);
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Cart'),
              key: Key('cart'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: ClipRect(
              child: Banner(
                message: '50% off',
                location: BannerLocation.topEnd,
                child: Container(
                  height: 100,
                  width: 300,
                  color: Colors.amberAccent,
                  child: Center(
                      child: Text(
                    'BANNER',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: categories
                  .map(
                    (category) => Container(
                      width: 300,
                      height: 200,
                      color: Colors.primaries[int.tryParse(category['id']) %
                          Colors.primaries.length],
                      child: ListTile(
                        title: Text(
                          category['title'],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          context.beamToNamed('/products');
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}

// return PageView(
// /// [PageView.scrollDirection] defaults to [Axis.horizontal].
// /// Use [Axis.vertical] to scroll vertically.
// scrollDirection: Axis.horizontal,
// controller: controller,
// children: const <Widget>[
// Center(
// child: Text('First Page'),
// ),
// Center(
// child: Text('Second Page'),
// ),
// Center(
// child: Text('Third Page'),
// )
// ],
// );
