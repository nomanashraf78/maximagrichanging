import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';
import 'package:maximagri/widgets/order_display_card.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';

import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';

import 'package:maximagri/pages/sales_officer/order_details/sales_officer_order_details_desktop_page.dart';
import 'package:maximagri/pages/sales_officer/order_details/sales_officer_order_details_mobile_page.dart';
import 'package:maximagri/pages/sales_officer/order_details/sales_officer_order_details_tablet_page.dart';

class SalesOfficerDealerOrdersListDesktopPage extends StatefulWidget {
  final String dealerUID;
  const SalesOfficerDealerOrdersListDesktopPage(
      {Key? key, required this.dealerUID})
      : super(key: key);

  @override
  State<SalesOfficerDealerOrdersListDesktopPage> createState() =>
      _SalesOfficerDealerOrdersListDesktopPageState();
}

class _SalesOfficerDealerOrdersListDesktopPageState
    extends State<SalesOfficerDealerOrdersListDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Dealer Orders List'),
      ),
      body: Row(
        children: [
          const SalesOfficerDrawer(),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ordersList')
                    .where('dealerUID', isEqualTo: widget.dealerUID)
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
                                      SalesOfficerOrderDetailsMobilePage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  tabletPage:
                                      SalesOfficerOrderDetailsTabletPage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  desktopPage:
                                      SalesOfficerOrderDetailsDesktopPage(
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
          )
        ],
      ),
    );
  }
}
