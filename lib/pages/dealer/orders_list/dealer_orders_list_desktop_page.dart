import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/pages/dealer/order_details/dealer_order_details_desktop_page.dart';
import 'package:maximagri/pages/dealer/order_details/dealer_order_details_mobile_page.dart';
import 'package:maximagri/pages/dealer/order_details/dealer_order_details_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/dealer_drawer.dart';
import 'package:maximagri/widgets/order_display_card.dart';

// import 'package:maximagri/pages/dealer/order_details/dealer_order_details_desktop_page.dart';
// import 'package:maximagri/pages/dealer/order_details/dealer_order_details_mobile_page.dart';
// import 'package:maximagri/pages/dealer/order_details/dealer_order_details_tablet_page.dart';

class DealerOrdersListDesktopPage extends StatefulWidget {
  const DealerOrdersListDesktopPage({Key? key}) : super(key: key);

  @override
  State<DealerOrdersListDesktopPage> createState() =>
      _DealerOrdersListDesktopPageState();
}

class _DealerOrdersListDesktopPageState
    extends State<DealerOrdersListDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Orders List'),
      ),
      body: Row(
        children: [
          const DealerDrawer(),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ordersList')
                    .where('dealerUID',
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
                                  mobilePage: DealerOrderDetailsMobilePage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  tabletPage: DealerOrderDetailsTabletPage(
                                    orderDetails: orderInfo,
                                    orderDocID: orderDocID,
                                  ),
                                  desktopPage: DealerOrderDetailsDesktopPage(
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
