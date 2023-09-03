import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maximagri/widgets/drawer/zonal_manager_drawer.dart';
import 'package:maximagri/widgets/navigation/zonal_manager_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maximagri/models/credit_model/dealer_credit_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/dealers_credit_display_card.dart';
import 'package:maximagri/pages/zonal_manager/user_orders_list/zonal_manager_user_orders_list_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/user_orders_list/zonal_manager_user_orders_list_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/user_orders_list/zonal_manager_user_orders_list_tablet_page.dart';

class ZonalManagerCreditCenterMobilePage extends StatefulWidget {
  const ZonalManagerCreditCenterMobilePage({Key? key}) : super(key: key);

  @override
  State<ZonalManagerCreditCenterMobilePage> createState() =>
      _ZonalManagerCreditCenterMobilePageState();
}

class _ZonalManagerCreditCenterMobilePageState
    extends State<ZonalManagerCreditCenterMobilePage> {
  double totalAvailableCredit = 0;
  double totalCreditLimit = 0;
  final numberFormat = NumberFormat('#,##,##,##,###');

  getZonalManagersCredit(UserProfile dealersCreditAccount) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('userProfile')
        .where('userUID', isEqualTo: dealersCreditAccount.userUID)
        .get();
    final json = snapshot.docs.first.data();
    UserProfile profile = UserProfile.fromJson(json);

    if (profile.zonalManagerUID == FirebaseAuth.instance.currentUser?.uid) {
      totalAvailableCredit += dealersCreditAccount.availableCredit;
      totalCreditLimit += dealersCreditAccount.creditLimit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zonal Manager Credit Center'),
      ),
      drawer: const ZonalManagerDrawer(),
      bottomNavigationBar: const ZonalManagerNavigation(selectedIndex: 2),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('dealersCredit')
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
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  final json = snapshot.data!.docs[i].data();

                  final dealersCreditAccount = UserProfile.fromJson(json);
                  getZonalManagersCredit(dealersCreditAccount);
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final json = snapshot.data!.docs[index].data();
                      final dealersCredit = DealersCredit.fromJson(json);
                      return Column(
                        children: [
                          index == 0
                              ? FittedBox(
                                  //  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.all(15),
                                        color: Colors.blue,
                                        child: Text(
                                          'CREDIT LIMIT: ${numberFormat.format(totalCreditLimit).toString()}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.all(15),
                                        color: Colors.green,
                                        child: Text(
                                          'CREDIT AVAILABLE: ${numberFormat.format(totalAvailableCredit).toString()}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('userProfile')
                                  .where('userUID',
                                      isEqualTo: dealersCredit.dealerUID)
                                  .get(),
                              builder: (context, snap) {
                                if (snap.connectionState !=
                                    ConnectionState.done) {
                                  return const SizedBox();
                                }
                                if (!snap.hasData) {
                                  return const SizedBox();
                                } else {
                                  final json = snap.data?.docs.first.data();
                                  final userProfile =
                                      UserProfile.fromJson(json!);
                                  if (userProfile.zonalManagerUID ==
                                      FirebaseAuth.instance.currentUser?.uid) {
                                    return DealerCreditProfileCard(
                                      userProfile: userProfile,
                                   //   dealersCredit: dealersCredit,
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Responsiveness(
                                            mobilePage:
                                                ZonalManagerUserOrdersListMobilePage(
                                                    userType:
                                                        userProfile.userType.toString(),
                                                    userUID:
                                                        userProfile.userUID),
                                            tabletPage:
                                                ZonalManagerUserOrdersListTabletPage(
                                                    userType:
                                                        userProfile.userType.toString(),
                                                    userUID:
                                                        userProfile.userUID),
                                            desktopPage:
                                                ZonalManagerUserOrdersListDesktopPage(
                                                    userType:
                                                        userProfile.userType.toString(),
                                                    userUID:
                                                        userProfile.userUID),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                }
                              }),
                        ],
                      );
                    });
              }
            }),
      ),
    );
  }
}
