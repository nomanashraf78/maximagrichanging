import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/pages/place_order/place_order_desktop_page.dart';
import 'package:maximagri/pages/place_order/place_order_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/dealer_drawer.dart';
import 'package:maximagri/widgets/navigation/dealer_navigation.dart';
import 'package:maximagri/pages/place_order/place_order_mobile_page.dart';

class DealerPlaceOrderTabletPage extends StatefulWidget {
  const DealerPlaceOrderTabletPage({Key? key}) : super(key: key);

  @override
  State<DealerPlaceOrderTabletPage> createState() =>
      _DealerPlaceOrderTabletPageState();
}

class _DealerPlaceOrderTabletPageState
    extends State<DealerPlaceOrderTabletPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('userProfile')
            .where('userUID', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Responsiveness(
                mobilePage: ProgressIndicatorMobilePage(),
                tabletPage: ProgressIndicatorTabletPage(),
                desktopPage: ProgressIndicatorDesktopPage());
          } else if (!snapshot.hasData) {
            return const Responsiveness(
                mobilePage: ProgressIndicatorMobilePage(),
                tabletPage: ProgressIndicatorTabletPage(),
                desktopPage: ProgressIndicatorDesktopPage());
          } else {
            final json = snapshot.data?.docs.first.data();
            final dealerProfile = UserProfile.fromJson(json!);
            return Responsiveness(
              mobilePage: PlaceOrderMobilePage(
                pageNavigation: const DealerNavigation(
                  selectedIndex: 1,
                ),
                pageDrawer: const DealerDrawer(),
                dealerProfile: dealerProfile,
              ),
              tabletPage: PlaceOrderTabletPage(
                pageNavigation: const DealerNavigation(
                  selectedIndex: 1,
                ),
                pageDrawer: const DealerDrawer(),
                dealerProfile: dealerProfile,
              ),
              desktopPage: PlaceOrderDesktopPage(
                pageDrawer: const DealerDrawer(),
                dealerProfile: dealerProfile,
              ),
            );
          }
        });
  }
}
