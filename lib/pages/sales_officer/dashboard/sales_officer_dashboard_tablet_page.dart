import 'package:flutter/material.dart';
import 'package:maximagri/widgets/drawer/sales_officer_drawer.dart';
import 'package:maximagri/widgets/home_page_option.dart';
import 'package:maximagri/widgets/navigation/sales_officer_navigation.dart';
import 'package:maximagri/utilities/responsiveness.dart';

import 'package:maximagri/pages/sales_officer/create_dealer/sales_officer_create_dealer_desktop_page.dart';
import 'package:maximagri/pages/sales_officer/create_dealer/sales_officer_create_dealer_mobile_page.dart';
import 'package:maximagri/pages/sales_officer/create_dealer/sales_officer_create_dealer_tablet_page.dart';

import 'package:maximagri/pages/sales_officer/dealers_list/sales_officer_dealers_list_desktop_page.dart';
import 'package:maximagri/pages/sales_officer/dealers_list/sales_officer_dealers_list_mobile_page.dart';
import 'package:maximagri/pages/sales_officer/dealers_list/sales_officer_dealers_list_tablet_page.dart';

import 'package:maximagri/pages/sales_officer/place_order/sales_officer_place_order_desktop_page.dart';
import 'package:maximagri/pages/sales_officer/place_order/sales_officer_place_order_mobile_page.dart';
import 'package:maximagri/pages/sales_officer/place_order/sales_officer_place_order_tablet_page.dart';

import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_desktop_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_tablet_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_mobile_page.dart';

import 'package:maximagri/pages/contact/contact_us/contact_us_mobile_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_tablet_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_desktop_page.dart';

import 'package:maximagri/pages/about/about_us/about_us_desktop_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_mobile_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_tablet_page.dart';

import 'package:maximagri/pages/sales_officer/orders_list/sales_officer_orders_list_desktop_page.dart';
import 'package:maximagri/pages/sales_officer/orders_list/sales_officer_orders_list_mobile_page.dart';
import 'package:maximagri/pages/sales_officer/orders_list/sales_officer_orders_list_tablet_page.dart';

class SalesOfficerDashboardTabletPage extends StatefulWidget {
  const SalesOfficerDashboardTabletPage({Key? key}) : super(key: key);

  @override
  State<SalesOfficerDashboardTabletPage> createState() =>
      _SalesOfficerDashboardTabletPageState();
}

class _SalesOfficerDashboardTabletPageState
    extends State<SalesOfficerDashboardTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Officer Dashboard'),
      ),
      drawer: const SalesOfficerDrawer(),
      bottomNavigationBar: const SalesOfficerNavigation(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.add_shopping_cart),
                      pageTitle: 'PLACE ORDER',
                      pageSubtitle: 'View Orders List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: SalesOfficerPlaceOrderMobilePage(),
                            tabletPage: SalesOfficerPlaceOrderTabletPage(),
                            desktopPage: SalesOfficerPlaceOrderDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.view_list),
                      pageTitle: 'ORDERS LIST',
                      pageSubtitle: 'View Orders List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: SalesOfficerOrdersListMobilePage(),
                            tabletPage: SalesOfficerOrdersListTabletPage(),
                            desktopPage: SalesOfficerOrdersListDesktopPage(),
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
                      pageIcon: const Icon(Icons.person_add_alt_1_sharp),
                      pageTitle: 'CREATE DEALER',
                      pageSubtitle: 'View Dealers List',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: SalesOfficerCreateDealerMobilePage(),
                            tabletPage: SalesOfficerCreateDealerTabletPage(),
                            desktopPage: SalesOfficerCreateDealerDesktopPage(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.people),
                      pageTitle: 'DEALERS LIST',
                      pageSubtitle: 'Place New Order',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: SalesOfficerDealersListMobilePage(),
                            tabletPage: SalesOfficerDealersListTabletPage(),
                            desktopPage: SalesOfficerDealersListDesktopPage(),
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
                      pageIcon: const Icon(Icons.support_agent),
                      pageTitle: 'Contact Us',
                      pageSubtitle: 'Contact With Us Here',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: ContactUsMobilePage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            tabletPage: ContactUsTabletPage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            desktopPage: ContactUsDesktopPage(
                              pageDrawer: SalesOfficerDrawer(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: HomePageOption(
                      pageIcon: const Icon(Icons.business),
                      pageTitle: 'About Us',
                      pageSubtitle: 'Learn more about us Here',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: AboutUsMobilePage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            tabletPage: AboutUsTabletPage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            desktopPage: AboutUsDesktopPage(
                              pageDrawer: SalesOfficerDrawer(),
                            ),
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
                      pageIcon: const Icon(Icons.checklist),
                      pageTitle: 'Terms & Conditions',
                      pageSubtitle: 'Check Terms Conditions Here',
                      pageRoute: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Responsiveness(
                            mobilePage: TermsAndConditionsMobilePage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            tabletPage: TermsAndConditionsTabletPage(
                              pageDrawer: SalesOfficerDrawer(),
                              pageNavigation:
                                  SalesOfficerNavigation(selectedIndex: 3),
                            ),
                            desktopPage: TermsAndConditionsDesktopPage(
                              pageDrawer: SalesOfficerDrawer(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
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
