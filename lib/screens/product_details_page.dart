import 'package:flutter/material.dart';
import 'package:mobile_app_to_web/models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({
    this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      //backgroundColor: product.color,
      appBar: AppBar(
        title: Text('Product details'),
      ),
      body: Center(
        child: Container(
          child: Text(
            'Product $productId',
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    );
  }
}
