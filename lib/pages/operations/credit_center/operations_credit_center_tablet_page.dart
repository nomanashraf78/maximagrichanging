import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/widgets/navigation/operations_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maximagri/models/credit_model/dealer_credit_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/dealers_credit_display_card.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_desktop_page.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_mobile_page.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_tablet_page.dart';

class OperationsCreditCenterTabletPage extends StatefulWidget {
  const OperationsCreditCenterTabletPage({Key? key}) : super(key: key);

  @override
  State<OperationsCreditCenterTabletPage> createState() =>
      _OperationsCreditCenterTabletPageState();
}

class _OperationsCreditCenterTabletPageState
    extends State<OperationsCreditCenterTabletPage> {
  double totalAvailableCredit = 0;
  double totalCreditLimit = 0;
  final numberFormat = NumberFormat('#,##,##,##,###');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Credit Center'),
      ),
      drawer: const OperationsDrawer(),
      bottomNavigationBar: const OperationsNavigation(selectedIndex: 2),
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
                  totalAvailableCredit += dealersCreditAccount.availableCredit;
                  totalCreditLimit += dealersCreditAccount.creditLimit;
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final json = snapshot.data!.docs[index].data();
                      final dealersCredit = UserProfile.fromJson(json);
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
                                      isEqualTo: dealersCredit.userUID)
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
                                  return DealerCreditProfileCard(
                                    userProfile: userProfile,
                                   // dealersCredit: dealersCredit,
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Responsiveness(
                                          mobilePage:
                                              OperationsUserOrdersListMobilePage(
                                                  userType:
                                                      userProfile.userType.toString(),
                                                  userUID: userProfile.userUID),
                                          tabletPage:
                                              OperationsUserOrdersListTabletPage(
                                                  userType:
                                                      userProfile.userType.toString(),
                                                  userUID: userProfile.userUID),
                                          desktopPage:
                                              OperationsUserOrdersListDesktopPage(
                                                  userType:
                                                      userProfile.userType.toString(),
                                                  userUID: userProfile.userUID),
                                        ),
                                      ),
                                    ),
                                  );
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
