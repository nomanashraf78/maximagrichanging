import 'package:flutter/material.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:maximagri/widgets/drawer/dealer_drawer.dart';
import 'package:maximagri/widgets/navigation/dealer_navigation.dart';
import 'package:maximagri/widgets/home_page_option.dart';

import 'package:maximagri/pages/dealer/place_order/dealer_place_order_desktop_page.dart';
import 'package:maximagri/pages/dealer/place_order/dealer_place_order_mobile_page.dart';
import 'package:maximagri/pages/dealer/place_order/dealer_place_order_tablet_page.dart';

import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_desktop_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_tablet_page.dart';
import 'package:maximagri/pages/terms_conditions/terms_conditions/terms_conditions_mobile_page.dart';

import 'package:maximagri/pages/contact/contact_us/contact_us_mobile_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_tablet_page.dart';
import 'package:maximagri/pages/contact/contact_us/contact_us_desktop_page.dart';

import 'package:maximagri/pages/about/about_us/about_us_desktop_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_mobile_page.dart';
import 'package:maximagri/pages/about/about_us/about_us_tablet_page.dart';

import 'package:maximagri/pages/dealer/orders_list/dealer_orders_list_desktop_page.dart';
import 'package:maximagri/pages/dealer/orders_list/dealer_orders_list_mobile_page.dart';
import 'package:maximagri/pages/dealer/orders_list/dealer_orders_list_tablet_page.dart';

class DealerDashboardMobilePage extends StatelessWidget {
  const DealerDashboardMobilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DealerDrawer(),
      bottomNavigationBar: const DealerNavigation(selectedIndex: 0),
      appBar: AppBar(
        title: const Text('Dealers Dashboard'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomePageOption(
                pageIcon: const Icon(Icons.add_shopping_cart),
                pageTitle: 'Place Order',
                pageSubtitle: 'Place New Order',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: DealerPlaceOrderMobilePage(),
                      tabletPage: DealerPlaceOrderTabletPage(),
                      desktopPage: DealerPlaceOrderDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.list),
                pageTitle: 'Orders List',
                pageSubtitle: 'View Your Orders List',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: DealerOrdersListMobilePage(),
                      tabletPage: DealerOrdersListTabletPage(),
                      desktopPage: DealerOrdersListDesktopPage(),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.support_agent),
                pageTitle: 'Contact Us',
                pageSubtitle: 'Contact With Us',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: ContactUsMobilePage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      tabletPage: ContactUsTabletPage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      desktopPage: ContactUsDesktopPage(
                        pageDrawer: DealerDrawer(),
                      ),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.business),
                pageTitle: 'About Us',
                pageSubtitle: 'Learn More About Us',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: AboutUsMobilePage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      tabletPage: AboutUsTabletPage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      desktopPage: AboutUsDesktopPage(
                        pageDrawer: DealerDrawer(),
                      ),
                    ),
                  ),
                ),
              ),
              HomePageOption(
                pageIcon: const Icon(Icons.checklist),
                pageTitle: 'Terms & Conditions',
                pageSubtitle: 'Check Terms Conditions',
                pageRoute: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Responsiveness(
                      mobilePage: TermsAndConditionsMobilePage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      tabletPage: TermsAndConditionsTabletPage(
                        pageDrawer: DealerDrawer(),
                        pageNavigation: DealerNavigation(selectedIndex: 3),
                      ),
                      desktopPage: TermsAndConditionsDesktopPage(
                        pageDrawer: DealerDrawer(),
                      ),
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
