import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/pages/place_order/place_order_desktop_page.dart';
import 'package:maximagri/pages/place_order/place_order_mobile_page.dart';
import 'package:maximagri/pages/place_order/place_order_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';
import 'package:maximagri/widgets/navigation/sales_officer_navigation.dart';
import 'package:maximagri/widgets/user_profile_card.dart';

class SalesOfficerPlaceOrderTabletPage extends StatefulWidget {
  const SalesOfficerPlaceOrderTabletPage({Key? key}) : super(key: key);

  @override
  State<SalesOfficerPlaceOrderTabletPage> createState() =>
      _SalesOfficerPlaceOrderTabletPageState();
}

class _SalesOfficerPlaceOrderTabletPageState
    extends State<SalesOfficerPlaceOrderTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Place Order'),
      ),
      drawer: const SalesOfficerDrawer(),
      bottomNavigationBar: const SalesOfficerNavigation(selectedIndex: 2),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('userProfile')
              .where('salesOfficerUID',
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .where('userType', isEqualTo: 'dealer')
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
              final filteredDocs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final json = filteredDocs[index].data();
                    final dealerProfile = UserProfile.fromJson(json);
                    return UserProfileCard(
                      userProfile: dealerProfile,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Responsiveness(
                            mobilePage: PlaceOrderMobilePage(
                              pageNavigation: const SalesOfficerNavigation(
                                  selectedIndex: 1),
                              pageDrawer: const SalesOfficerDrawer(),
                              dealerProfile: dealerProfile,
                            ),
                            tabletPage: PlaceOrderTabletPage(
                              pageNavigation: const SalesOfficerNavigation(
                                selectedIndex: 1,
                              ),
                              pageDrawer: const SalesOfficerDrawer(),
                              dealerProfile: dealerProfile,
                            ),
                            desktopPage: PlaceOrderDesktopPage(
                              pageDrawer: const SalesOfficerDrawer(),
                              dealerProfile: dealerProfile,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
