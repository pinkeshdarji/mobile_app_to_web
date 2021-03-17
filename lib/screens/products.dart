// Copyright 2020 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_to_web/models/cart.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class ProductsPage extends StatelessWidget {
  static String routeName = '/';
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
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              return GridView.builder(
                itemCount: 100,
                itemBuilder: (context, index) => ItemTile(index),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 700 ? 4 : 1,
                  childAspectRatio: 5,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    var cartList = Provider.of<Cart>(context);
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () => context.updateCurrentLocation(
          pathBlueprint: '/products/:productId',
          pathParameters: {'productId': '$itemNo'},
        ),
        leading: Container(
          width: 50,
          height: 30,
          child: Placeholder(
            color: color,
          ),
        ),
        title: Text(
          'Product $itemNo',
          key: Key('text_$itemNo'),
        ),
        trailing: IconButton(
          key: Key('icon_$itemNo'),
          icon: cartList.items.contains(itemNo)
              ? Icon(Icons.shopping_cart)
              : Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            !cartList.items.contains(itemNo)
                ? cartList.add(itemNo)
                : cartList.remove(itemNo);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(cartList.items.contains(itemNo)
                    ? 'Added to cart.'
                    : 'Removed from cart.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
