import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/models/products_model/products_list_model.dart';
import 'package:maximagri/services/create_order_stops.dart';

class PlaceOrderTabletPage extends StatefulWidget {
  final Widget pageDrawer;
  final Widget pageNavigation;
  final UserProfile dealerProfile;
  const PlaceOrderTabletPage(
      {Key? key,
      required this.pageDrawer,
      required this.pageNavigation,
      required this.dealerProfile})
      : super(key: key);

  @override
  State<PlaceOrderTabletPage> createState() => _PlaceOrderTabletPageState();
}

class _PlaceOrderTabletPageState extends State<PlaceOrderTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
      ),
      drawer: widget.pageDrawer,
      bottomNavigationBar: widget.pageNavigation,
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('productsList').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            if (snapshot.hasData) {
              List<ProductsList> productsList = [];
              int? productCount = snapshot.data?.docs.length;

              for (int i = 0; i < productCount!; i++) {
                final json = snapshot.data?.docs[i].data();
                productsList.add(ProductsList.fromJson(json!));
              }
              return CreateOrderStops(
                  dealerProfile: widget.dealerProfile,
                  productsList: productsList);
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
          }),
    );
  }
}
