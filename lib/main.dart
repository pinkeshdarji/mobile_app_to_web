import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'screens/home.dart';
import 'screens/product_details_page.dart';
import 'screens/products.dart';

void main() {
  runApp(MyApp());
}

// LOCATIONS
class HomeLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context) => [
        BeamPage(
          key: ValueKey('home'),
          child: HomePage(),
        ),
      ];
}

class ProductsLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/products/:productId'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context) => [
        ...HomeLocation().pagesBuilder(context),
        if (pathSegments.contains('products'))
          BeamPage(
            key: ValueKey('products-${queryParameters['title'] ?? ''}'),
            child: ProductsPage(),
          ),
        if (pathParameters.containsKey('productId'))
          BeamPage(
            key: ValueKey('product-${pathParameters['productId']}'),
            child: ProductDetailsPage(
              productId: pathParameters['productId'],
            ),
          ),
      ];
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerRouterDelegate(
    beamLocations: [
      HomeLocation(),
      ProductsLocation(),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
        create: (context) => Cart(),
        child: MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerRouteInformationParser(),
          backButtonDispatcher:
              BeamerBackButtonDispatcher(delegate: routerDelegate),
          theme: ThemeData(
            primarySwatch: Colors.teal,
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
        ));
  }
}
