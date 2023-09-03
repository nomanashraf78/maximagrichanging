import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';
import 'package:intl/intl.dart';

class DisplayOrderDetails extends StatefulWidget {
  final SingleOrder orderDetails;
  const DisplayOrderDetails({Key? key, required this.orderDetails})
      : super(key: key);

  @override
  State<DisplayOrderDetails> createState() => _DisplayOrderDetailsState();
}

class _DisplayOrderDetailsState extends State<DisplayOrderDetails> {
  final numberFormat = NumberFormat('#,##,##,##,###');
  bool isImageDownloaded = false;
  String? imageUrlFromFirebase;

  @override
  void initState() {
    // TODO: implement initState
    getBankReceiptFromFirebase();
    super.initState();
  }

  void getBankReceiptFromFirebase() async {
    final receiptName = widget.orderDetails.bankReceipt;
    try {
      imageUrlFromFirebase = await FirebaseStorage.instance
          .ref('bank_receipts')
          .child(receiptName)
          .getDownloadURL();
      isImageDownloaded = true;
      setState(() {});
    } catch (e) {
      showMessageDialog(
          message:
              'Payment receipt missing! Please verify payment transaction before taking any further action!',
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage(
                          'lib/assets/images/maxim_logo_cropped.png'),
                      height: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'MAXIM AGRI (PRIVATE) LIMITED',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        '7-B, Gulberg 5, Lahore, Pakistan\n+92 323 4007000'),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'BILL TO:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.orderDetails.dealerName.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '${widget.orderDetails.tehsil}, ${widget.orderDetails.district}, ${widget.orderDetails.province}, Pakistan\n${widget.orderDetails.dealerNumber}'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        MediaQuery.of(context).size.width <= 480
                            ? 'SALES\nORDER'
                            : 'SALES ORDER',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 33,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                        'DATE: ${widget.orderDetails.dateTime.day}-${widget.orderDetails.dateTime.month}-${widget.orderDetails.dateTime.year}'),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'ORDER STATUS',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text(widget.orderDetails.orderStatus.name
                        .toString()
                        .toUpperCase()),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'ORDER SUMMERY',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'ORDER TOTAL: ${numberFormat.format(widget.orderDetails.orderTotal)}'),
                    Text('ORDER QUANTITY:${widget.orderDetails.orderQuantity}'),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'DISPATCH INFO',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text('VEHICLE: ${widget.orderDetails.vehicleNo}'),
                    Text('CONTACT: ${widget.orderDetails.driverContact}'),
                    widget.orderDetails.driverContact == 'PENDING'
                        ? const Text('DISPATCH TIME: PENDING')
                        : Text(
                            'DISPATCH TIME: ${widget.orderDetails.dispatchTime.day}-${widget.orderDetails.dispatchTime.month}-${widget.orderDetails.dispatchTime.year}'),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          ListView.builder(
              itemCount: widget.orderDetails.orderStops.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int stopNumber = index + 1;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'STOP # $stopNumber  ',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                const Text(
                                  'STOP ADDRESS: ',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                                Text(
                                  widget.orderDetails.orderStops[index].stopName
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                const Text(
                                  ' CONTACT: ',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                                Text(
                                  widget.orderDetails.orderStops[index]
                                      .stopContact,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.green,
                      //margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'PRODUCT NAME',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  'QUANTITY',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'RATE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'AMOUNT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        itemCount: widget
                            .orderDetails.orderStops[index].itemList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        widget.orderDetails.orderStops[index]
                                            .itemList[i].productName,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(widget
                                            .orderDetails
                                            .orderStops[index]
                                            .itemList[i]
                                            .productQuantity
                                            .toString()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(numberFormat
                                            .format(widget
                                                .orderDetails
                                                .orderStops[index]
                                                .itemList[i]
                                                .productPrice)
                                            .toString()),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(numberFormat
                                            .format(widget
                                                .orderDetails
                                                .orderStops[index]
                                                .itemList[i]
                                                .productTotal)
                                            .toString()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    Container(
                      height: 1,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'STOP QUANTITY:',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(widget
                                  .orderDetails.orderStops[index].stopQuantity
                                  .toString()),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'STOP TOTAL:',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(numberFormat
                                  .format(widget
                                      .orderDetails.orderStops[index].stopTotal)
                                  .toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.orderDetails.orderStops.length == index + 1
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              height: 2,
                              color: Colors.green,
                            ),
                          ),
                  ],
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'ORDER SUMMERY',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      'ORDER QUANTITY:',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        widget.orderDetails.orderQuantity.toString(),
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 4,
                      child: Text(
                        'ORDER TOTAL:',
                        textAlign: TextAlign.end,
                      )),
                  Expanded(
                    flex: 1,
                    child: Text(
                      numberFormat
                          .format(widget.orderDetails.orderTotal)
                          .toString(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'PAYMENT DETAILS',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      'BANK PAYMENT:',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        numberFormat
                            .format(widget.orderDetails.bankAmount)
                            .toString(),
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                      flex: 4,
                      child: Text(
                        'CREDIT AMOUNT:',
                        textAlign: TextAlign.end,
                      )),
                  Expanded(
                    flex: 1,
                    child: Text(
                      numberFormat
                          .format(widget.orderDetails.creditPayment)
                          .toString(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text('RENT ADJUSTMENT:', textAlign: TextAlign.end),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            numberFormat
                                .format(widget.orderDetails.rentAdjustment)
                                .toString(),
                            textAlign: TextAlign.end)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'PAYMENT RECEIPT',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Row(
                children: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: isImageDownloaded == false
                        ? const Image(
                            image: AssetImage(
                                'lib/assets/images/receipt-placeholder.png'),
                          )
                        : GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: Column(
                                    children: [
                                      const Text(
                                        'PAYMENT RECEIPT',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                            imageUrlFromFirebase!),
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child:
                                            Text(widget.orderDetails.bankName),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(imageUrlFromFirebase!),
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
