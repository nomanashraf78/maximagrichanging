import 'package:flutter/material.dart';
import 'package:maximagri/widgets/drawer/zonal_manager_drawer.dart';
import 'package:maximagri/widgets/home_page_option.dart';
import 'package:maximagri/widgets/navigation/zonal_manager_navigation.dart';
import 'package:maximagri/utilities/responsiveness.dart';

import 'package:maximagri/pages/zonal_manager/credit_center/zonal_manager_credit_center_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/credit_center/zonal_manager_credit_center_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/credit_center/zonal_manager_credit_center_tablet_page.dart';

import 'package:maximagri/pages/zonal_manager/sales_manager_list/zonal_manager_sales_manager_list_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/sales_manager_list/zonal_manager_sales_manager_list_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/sales_manager_list/zonal_manager_sales_manager_list_tablet_page.dart';

import 'package:maximagri/pages/zonal_manager/dealers_list/zonal_manager_dealers_list_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/dealers_list/zonal_manager_dealers_list_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/dealers_list/zonal_manager_dealers_list_tablet_page.dart';

import 'package:maximagri/pages/zonal_manager/orders_list/zonal_manager_orders_list_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/orders_list/zonal_manager_orders_list_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/orders_list/zonal_manager_orders_list_tablet_page.dart';

import 'package:maximagri/pages/zonal_manager/sales_officer_list/zonal_manager_sales_officer_list_desktop_page.dart';
import 'package:maximagri/pages/zonal_manager/sales_officer_list/zonal_manager_sales_officer_list_mobile_page.dart';
import 'package:maximagri/pages/zonal_manager/sales_officer_list/zonal_manager_sales_officer_list_tablet_page.dart';

import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_desktop_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_tablet_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_mobile_page.dart';

import 'package:maximagri/pages/contact/contact_us/contact_us_mobile_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_tablet_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_desktop_page.dart';

import 'package:maximagri/pages/about/about_us/about_us_desktop_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_mobile_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_tablet_page.dart';

class ZonalManagerDashboardTabletPage extends StatefulWidget {
  const ZonalManagerDashboardTabletPage({Key? key}) : super(key: key);

  @override
  State<ZonalManagerDashboardTabletPage> createState() =>
      _ZonalManagerDashboardTabletPageState();
}

class _ZonalManagerDashboardTabletPageState
    extends State<ZonalManagerDashboardTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zonal Manager Dashboard'),
      ),
      drawer: const ZonalManagerDrawer(),
      bottomNavigationBar: const ZonalManagerNavigation(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.credit_score),
                      pageTitle: 'CREDIT CENTER',
                      pageSubtitle: 'Enter Credit Center',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: ZonalManagerCreditCenterMobilePage(),
                            tabletPage: ZonalManagerCreditCenterTabletPage(),
                            desktopPage: ZonalManagerCreditCenterDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.people),
                      pageTitle: 'SALES MANAGERS',
                      pageSubtitle: 'View Sales Managers List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage:
                                ZonalManagerSalesManagerListMobilePage(),
                            tabletPage:
                                ZonalManagerSalesManagerListTabletPage(),
                            desktopPage:
                                ZonalManagerSalesManagerListDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.people),
                      pageTitle: 'SALES OFFICERS',
                      pageSubtitle: 'View Sales Officers List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage:
                                ZonalManagerSalesOfficerListMobilePage(),
                            tabletPage:
                                ZonalManagerSalesOfficerListTabletPage(),
                            desktopPage:
                                ZonalManagerSalesOfficerListDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.people),
                      pageTitle: 'DEALERS LIST',
                      pageSubtitle: 'View Dealers List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: ZonalManagerDealersListMobilePage(),
                            tabletPage: ZonalManagerDealersListTabletPage(),
                            desktopPage: ZonalManagerDealersListDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.view_list),
                      pageTitle: 'ORDERS LIST',
                      pageSubtitle: 'View Orders List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: ZonalManagerOrdersListMobilePage(),
                            tabletPage: ZonalManagerOrdersListTabletPage(),
                            desktopPage: ZonalManagerOrdersListDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.support_agent),
                      pageTitle: 'CONTACT US',
                      pageSubtitle: 'Contact With Us',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: ContactUsMobilePage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            tabletPage: ContactUsTabletPage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            desktopPage: ContactUsDesktopPage(
                                pageDrawer: ZonalManagerDrawer()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.corporate_fare),
                      pageTitle: 'ABOUT US',
                      pageSubtitle: 'Learn More About Us',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: AboutUsMobilePage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            tabletPage: AboutUsTabletPage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            desktopPage: AboutUsDesktopPage(
                                pageDrawer: ZonalManagerDrawer()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.checklist_outlined),
                      pageTitle: 'TERMS & CONDITIONS',
                      pageSubtitle: 'Check Terms Conditions',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: TermsAndConditionsMobilePage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            tabletPage: TermsAndConditionsTabletPage(
                              pageDrawer: ZonalManagerDrawer(),
                              pageNavigation: ZonalManagerNavigation(
                                selectedIndex: 1,
                              ),
                            ),
                            desktopPage: TermsAndConditionsDesktopPage(
                                pageDrawer: ZonalManagerDrawer()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
