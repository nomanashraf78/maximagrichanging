import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maximagri/models/order_model/order_status_enum.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/models/products_model/products_list_model.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_desktop_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_mobile_page.dart';
import 'package:maximagri/pages/auth/splash_screen/progress_indicator_tablet_page.dart';
import 'package:maximagri/utilities/responsiveness.dart';
import 'package:fl_chart/fl_chart.dart';

class OperationsStatistics extends StatefulWidget {
  const OperationsStatistics({Key? key}) : super(key: key);

  @override
  State<OperationsStatistics> createState() => _OperationsStatisticsState();
}

class _OperationsStatisticsState extends State<OperationsStatistics> {
  final numberFormat = NumberFormat('#,##,##,##,###');
  int canceled = 0;
  int rejected = 0;
  int pending = 0;
  int confirmed = 0;
  int approved = 0;
  int forwarded = 0;
  int processing = 0;
  int dispatched = 0;
  int delivered = 0;
  int orderDispatchTime = 0;
  double totalSales = 0;
  double totalQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ordersList')
            .where('operationsUID',
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
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              final json = snapshot.data!.docs[i].data();
              final orderInfo = SingleOrder.fromJson(json);
              if (orderInfo.orderStatus == OrderStatus.canceled) {
                canceled += 1;
              } else if (orderInfo.orderStatus == OrderStatus.rejected) {
                rejected += 1;
              } else if (orderInfo.orderStatus == OrderStatus.pending) {
                pending += 1;
              } else if (orderInfo.orderStatus == OrderStatus.confirmed) {
                confirmed += 1;
              } else if (orderInfo.orderStatus == OrderStatus.approved) {
                approved += 1;
              } else if (orderInfo.orderStatus == OrderStatus.forwarded) {
                forwarded += 1;
              } else if (orderInfo.orderStatus == OrderStatus.processing) {
                processing += 1;
              } else if (orderInfo.orderStatus == OrderStatus.dispatched) {
                dispatched += 1;
                Duration orderDelivery =
                    orderInfo.dispatchTime.difference(orderInfo.dateTime);
                orderDispatchTime += orderDelivery.inDays;
              } else if (orderInfo.orderStatus == OrderStatus.delivered) {
                delivered += 1;
              }
            }
            double average = orderDispatchTime / dispatched;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FittedBox(
                      //  fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            //  margin: const EdgeInsets.all(15),
                            color: Colors.blue,
                            child: const Text(
                              'AVERAGE RECEIVE TO DISPATCH TIME',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            //   margin: const EdgeInsets.all(15),
                            color: Colors.green,
                            child: Text(
                              '$average DAYS',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.orange,
                      child: const Text(
                        'ORDERS SUMMERY',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shadowColor: Colors.green,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.numbers_outlined,
                                        color: Colors.green),
                                    title: Text(
                                        '${snapshot.data?.docs.length} RECEIVED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    tileColor: Colors.green,
                                    leading: const Icon(
                                        Icons.check_circle_outlined,
                                        color: Colors.white),
                                    title: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('$delivered DELIVERED',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(
                                        Icons.forward_5_outlined,
                                        color: Colors.green),
                                    title: Text('$pending PENDING',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.done_all_outlined,
                                        color: Colors.green),
                                    title: Text('$confirmed CONFIRMED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(
                                        Icons.next_week_outlined,
                                        color: Colors.green),
                                    title: Text('$forwarded FORWARDED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.credit_score,
                                        color: Colors.green),
                                    title: Text('$approved APPROVED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.add_task,
                                        color: Colors.green),
                                    title: Text('$processing PROCESSING',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(
                                        Icons.local_shipping_outlined,
                                        color: Colors.green),
                                    title: Text('$dispatched DISPATCHED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(
                                        Icons.cancel_presentation,
                                        color: Colors.green),
                                    title: Text('$rejected REJECTED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    leading: const Icon(Icons.cancel_outlined,
                                        color: Colors.green),
                                    title: Text('$canceled CANCELLED',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.blue,
                      height: 400,
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          child: PieChart(
                            PieChartData(
                                centerSpaceRadius: 10,
                                borderData: FlBorderData(show: false),
                                sections: [
                                  PieChartSectionData(
                                    value: pending.toDouble(),
                                    color: Colors.orange,
                                    radius: 60,
                                    title: '$pending pending',
                                    titlePositionPercentageOffset: 1.5,
                                  ),
                                  PieChartSectionData(
                                      value: confirmed.toDouble(),
                                      color: Colors.yellowAccent,
                                      title: '$confirmed confirmed',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 70),
                                  PieChartSectionData(
                                      value: approved.toDouble(),
                                      color: Colors.purple,
                                      title: '$approved approved',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 80),
                                  PieChartSectionData(
                                      value: forwarded.toDouble(),
                                      color: Colors.pink,
                                      title: '$forwarded forwarded',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 90),
                                  PieChartSectionData(
                                      value: processing.toDouble(),
                                      color: Colors.greenAccent,
                                      title: '$processing processing',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 100),
                                  PieChartSectionData(
                                      value: dispatched.toDouble(),
                                      color: Colors.green,
                                      title: '$dispatched dispatched',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 110),
                                  PieChartSectionData(
                                      value: delivered.toDouble(),
                                      color: Colors.blue,
                                      title: '$delivered delivered',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 120),
                                  PieChartSectionData(
                                      value: canceled.toDouble(),
                                      color: Colors.grey,
                                      title: '$canceled canceled',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 40),
                                  PieChartSectionData(
                                      value: rejected.toDouble(),
                                      color: Colors.black,
                                      title: '$rejected rejected',
                                      titlePositionPercentageOffset: 1.5,
                                      radius: 50),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.black,
                      child: const Text(
                        'PRODUCTS SUMMERY',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.green,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'PRODUCT NUMBER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'PRODUCT NAME',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'PRODUCT QUANTITY',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'PRODUCT PRICE',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'PRODUCT TOTAL',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('productsList')
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const CircularProgressIndicator(
                              color: Colors.green,
                            );
                          }

                          if (snapshot.hasData) {
                            for (int i = 0;
                                i < snapshot.data!.docs.length;
                                i++) {
                              final json = snapshot.data?.docs[i].data();
                              final product = ProductsList.fromJson(json!);
                              totalQuantity += product.itemSales;
                              totalSales +=
                                  product.itemSales * product.itemPrice;
                            }

                            return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final json =
                                      snapshot.data?.docs[index].data();
                                  final productsList =
                                      ProductsList.fromJson(json!);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    productsList.itemNumber)),
                                            Expanded(
                                                child: Text(
                                                    productsList.itemName)),
                                            Expanded(
                                                child: Text(
                                              productsList.itemSales.toString(),
                                              textAlign: TextAlign.right,
                                            )),
                                            Expanded(
                                                child: Text(
                                              numberFormat
                                                  .format(
                                                      productsList.itemPrice)
                                                  .toString(),
                                              textAlign: TextAlign.right,
                                            )),
                                            Expanded(
                                                child: Text(
                                              numberFormat
                                                  .format((productsList
                                                          .itemPrice *
                                                      productsList.itemSales))
                                                  .toString(),
                                              textAlign: TextAlign.right,
                                            )),
                                          ],
                                        ),
                                        snapshot.data?.docs.length == index + 1
                                            ? Container(
                                                color: Colors.blue,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        // horizontal: 10,
                                                        vertical: 20),
                                                child: Row(
                                                  children: [
                                                    const Expanded(
                                                        child: SizedBox()),
                                                    const Expanded(
                                                      child: Text(
                                                        'TOTAL BAGS SOLD',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Text(
                                                      totalQuantity.toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    const Expanded(
                                                      child: Text(
                                                        'TOTAL SALES',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        numberFormat
                                                            .format(totalSales)
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return const CircularProgressIndicator(
                              color: Colors.green,
                            );
                          }
                        }),
                  ],
                ),
              ),
            );
          }
        });
  }
}
