import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/sales_manager_drawer.dart';
import 'package:maximagri/widgets/order_display_card.dart';

import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';

import 'package:maximagri/pages/sales_manager/order_details/sales_manager_order_details_desktop_page.dart';
import 'package:maximagri/pages/sales_manager/order_details/sales_manager_order_details_mobile_page.dart';
import 'package:maximagri/pages/sales_manager/order_details/sales_manager_order_details_tablet_page.dart';

class SalesManagerUserOrdersListDesktopPage extends StatefulWidget {
  final String userType;
  final String userUID;
  const SalesManagerUserOrdersListDesktopPage(
      {Key? key, required this.userType, required this.userUID})
      : super(key: key);

  @override
  State<SalesManagerUserOrdersListDesktopPage> createState() =>
      _SalesManagerUserOrdersListDesktopPageState();
}

class _SalesManagerUserOrdersListDesktopPageState
    extends State<SalesManagerUserOrdersListDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Manager User Orders List'),
      ),
      body: Row(
        children: [
          const SalesManagerDrawer(),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ordersList')
                    .where('${widget.userType}UID', isEqualTo: widget.userUID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) {
                    return const Responsiveness(
                      mobilePage: ProgressIndicatorMobilePage(),
                      tabletPage: ProgressIndicatorTabletPage(),
                      desktopPage: ProgressIndicatorDesktopPage(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Responsiveness(
                      mobilePage: ProgressIndicatorMobilePage(),
                      tabletPage: ProgressIndicatorTabletPage(),
                      desktopPage: ProgressIndicatorDesktopPage(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          final json = snapshot.data!.docs[index].data();
                          final orderDocID = snapshot.data!.docs[index].id;
                          final orderInfo = SingleOrder.fromJson(json);
                          return SingleOrderDisplayCard(
                            orderInfo: orderInfo,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Responsiveness(
                                  mobilePage:
                                      SalesManagerOrderDetailsMobilePage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  tabletPage:
                                      SalesManagerOrderDetailsTabletPage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  desktopPage:
                                      SalesManagerOrderDetailsDesktopPage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
