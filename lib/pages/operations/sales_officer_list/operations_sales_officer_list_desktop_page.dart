import 'package:flutter/material.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_desktop_page.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_mobile_page.dart';
import 'package:maximagri/pages/operations/user_orders_list/operations_user_orders_list_tablet_page.dart';
import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/user_profile_card.dart';

class OperationsSalesOfficerListDesktopPage extends StatefulWidget {
  const OperationsSalesOfficerListDesktopPage({Key? key}) : super(key: key);

  @override
  State<OperationsSalesOfficerListDesktopPage> createState() =>
      _OperationsSalesOfficerListDesktopPageState();
}

class _OperationsSalesOfficerListDesktopPageState
    extends State<OperationsSalesOfficerListDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Sales Officers List'),
      ),
      body: Row(
        children: [
          const OperationsDrawer(),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('userProfile')
                  .where('userType', isEqualTo: 'salesOfficer')
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
                        final userProfile = UserProfile.fromJson(json);
                        return UserProfileCard(
                          userProfile: userProfile,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Responsiveness(
                                mobilePage: OperationsUserOrdersListMobilePage(
                                    userType: userProfile.userType.toString(),
                                    userUID: userProfile.userUID),
                                tabletPage: OperationsUserOrdersListTabletPage(
                                    userType: userProfile.userType.toString(),
                                    userUID: userProfile.userUID),
                                desktopPage:
                                    OperationsUserOrdersListDesktopPage(
                                        userType: userProfile.userType.toString(),
                                        userUID: userProfile.userUID),
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
