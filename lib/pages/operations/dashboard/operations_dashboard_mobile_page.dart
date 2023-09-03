import 'package:flutter/material.dart';

import 'package:maximagri/widgets/drawer/operations_drawer.dart';
import 'package:maximagri/widgets/home_page_option.dart';
import 'package:maximagri/widgets/navigation/operations_navigation.dart';

import 'package:maximagri/pages/operations/statistics/operations_statistics_desktop_page.dart';
import 'package:maximagri/pages/operations/statistics/operations_statistics_mobile_page.dart';
import 'package:maximagri/pages/operations/statistics/operations_statistics_tablet_page.dart';

import 'package:maximagri/pages/operations/create_account/operations_create_account_desktop_page.dart';
import 'package:maximagri/pages/operations/create_account/operations_create_account_mobile_page.dart';
import 'package:maximagri/pages/operations/create_account/operations_create_account_tablet_page.dart';

import 'package:maximagri/utilities/responsiveness.dart';

import 'package:maximagri/pages/operations/zonal_manager_list/operations_zonal_manager_list_desktop_page.dart';
import 'package:maximagri/pages/operations/zonal_manager_list/operations_zonal_manager_list_mobile_page.dart';
import 'package:maximagri/pages/operations/zonal_manager_list/operations_zonal_manager_list_tablet_page.dart';

import 'package:maximagri/pages/operations/credit_center/operations_credit_center_desktop_page.dart';
import 'package:maximagri/pages/operations/credit_center/operations_credit_center_mobile_page.dart';
import 'package:maximagri/pages/operations/credit_center/operations_credit_center_tablet_page.dart';

import 'package:maximagri/pages/operations/sales_manager_list/operations_sales_manager_list_desktop_page.dart';
import 'package:maximagri/pages/operations/sales_manager_list/operations_sales_manager_list_mobile_page.dart';
import 'package:maximagri/pages/operations/sales_manager_list/operations_sales_manager_list_tablet_page.dart';

import 'package:maximagri/pages/operations/sales_officer_list/operations_sales_officer_list_desktop_page.dart';
import 'package:maximagri/pages/operations/sales_officer_list/operations_sales_officer_list_mobile_page.dart';
import 'package:maximagri/pages/operations/sales_officer_list/operations_sales_officer_list_tablet_page.dart';

import 'package:maximagri/pages/operations/dealers_list/operations_dealers_list_desktop_page.dart';
import 'package:maximagri/pages/operations/dealers_list/operations_dealers_list_mobile_page.dart';
import 'package:maximagri/pages/operations/dealers_list/operations_dealers_list_tablet_page.dart';

import 'package:maximagri/pages/operations/orders_list/operations_orders_list_desktop_page.dart';
import 'package:maximagri/pages/operations/orders_list/operations_orders_list_mobile_page.dart';
import 'package:maximagri/pages/operations/orders_list/operations_orders_list_tablet_page.dart';

import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_desktop_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_tablet_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_mobile_page.dart';

import 'package:maximagri/pages/contact/contact_us/contact_us_mobile_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_tablet_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_desktop_page.dart';

import 'package:maximagri/pages/about/about_us/about_us_desktop_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_mobile_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_tablet_page.dart';

class OperationsDashboardMobilePage extends StatefulWidget {
  const OperationsDashboardMobilePage({Key? key}) : super(key: key);

  @override
  State<OperationsDashboardMobilePage> createState() =>
      _OperationsDashboardMobilePageState();
}

class _OperationsDashboardMobilePageState
    extends State<OperationsDashboardMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Dashboard'),
      ),
      drawer: const OperationsDrawer(),
      bottomNavigationBar: const OperationsNavigation(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomePageOption(
                pageIcon: const Icon(Icons.person_add_alt_1),
                pageTitle: 'CREATE ACCOUNT',
                pageSubtitle: 'Create New User',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsCreateAccountMobilePage(),
                      tabletPage: OperationsCreateAccountTabletPage(),
                      desktopPage: OperationsCreateAccountDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.credit_score),
                pageTitle: 'CREDIT CENTER',
                pageSubtitle: 'Enter Credit Center',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsCreditCenterMobilePage(),
                      tabletPage: OperationsCreditCenterTabletPage(),
                      desktopPage: OperationsCreditCenterDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.people),
                pageTitle: 'ZONAL MANAGERS',
                pageSubtitle: 'View Zonal Managers List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsZonalManagerListMobilePage(),
                      tabletPage: OperationsZonalManagerListTabletPage(),
                      desktopPage: OperationsZonalManagerListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.people),
                pageTitle: 'SALES MANAGERS',
                pageSubtitle: 'View Sales Managers List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsSalesManagerListMobilePage(),
                      tabletPage: OperationsSalesManagerListTabletPage(),
                      desktopPage: OperationsSalesManagerListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.people),
                pageTitle: 'SALES OFFICERS',
                pageSubtitle: 'View Sales Officers List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsSalesOfficerListMobilePage(),
                      tabletPage: OperationsSalesOfficerListTabletPage(),
                      desktopPage: OperationsSalesOfficerListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.people),
                pageTitle: 'DEALERS LIST',
                pageSubtitle: 'View Dealers List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsDealersListMobilePage(),
                      tabletPage: OperationsDealersListTabletPage(),
                      desktopPage: OperationsDealersListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.view_list),
                pageTitle: 'ORDERS LIST',
                pageSubtitle: 'View Orders List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsOrdersListMobilePage(),
                      tabletPage: OperationsOrdersListTabletPage(),
                      desktopPage: OperationsOrdersListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.analytics_outlined),
                pageTitle: 'STATISTICS',
                pageSubtitle: 'Business Statistics & Analyses',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: OperationsStatisticsMobilePage(),
                      tabletPage: OperationsStatisticsTabletPage(),
                      desktopPage: OperationsStatisticsDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.support_agent),
                pageTitle: 'CONTACT US',
                pageSubtitle: 'Contact With Us',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: ContactUsMobilePage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      tabletPage: ContactUsTabletPage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      desktopPage:
                          ContactUsDesktopPage(pageDrawer: OperationsDrawer()),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.corporate_fare),
                pageTitle: 'ABOUT US',
                pageSubtitle: 'Learn More About Us',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: AboutUsMobilePage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      tabletPage: AboutUsTabletPage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      desktopPage:
                          AboutUsDesktopPage(pageDrawer: OperationsDrawer()),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.checklist_outlined),
                pageTitle: 'TERMS & CONDITIONS',
                pageSubtitle: 'Check Terms Conditions',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: TermsAndConditionsMobilePage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      tabletPage: TermsAndConditionsTabletPage(
                        pageDrawer: OperationsDrawer(),
                        pageNavigation: OperationsNavigation(
                          selectedIndex: 1,
                        ),
                      ),
                      desktopPage: TermsAndConditionsDesktopPage(
                          pageDrawer: OperationsDrawer()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
