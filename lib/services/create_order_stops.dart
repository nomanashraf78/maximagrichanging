import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maximagri/models/credit_model/dealer_credit_model.dart';
import 'package:maximagri/models/order_controllers_model/item_list_controllers_model.dart';
import 'package:maximagri/models/order_controllers_model/order_controllers_model.dart';
import 'package:maximagri/models/order_controllers_model/stop_controllers_model.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:maximagri/models/products_model/products_list_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/utilities/user_redirection.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';
import 'package:maximagri/services/add_product_items.dart';
import 'package:file_picker/file_picker.dart';

class CreateOrderStops extends StatefulWidget {
  final UserProfile dealerProfile;
  final List<ProductsList> productsList;
  const CreateOrderStops(
      {Key? key, required this.dealerProfile, required this.productsList})
      : super(key: key);

  @override
  State<CreateOrderStops> createState() => _CreateOrderStopsState();
}

class _CreateOrderStopsState extends State<CreateOrderStops> {
  @override
  void initState() {
    // TODO: implement initState
    getDealersAvailableCredit();
    super.initState();
  }

  OrderControllers orderControllers = OrderControllers(
      bankPaymentController: TextEditingController(text: '0'),
      creditPaymentController: TextEditingController(text: '0'),
      rentAdjustmentController: TextEditingController(text: '0'),
      bankPaymentReceiptController: TextEditingController(),
      bankNameController: TextEditingController(),
      stopControllers: [
        StopControllers(
          stopContactController: TextEditingController(),
          stopNameController: TextEditingController(),
          itemListControllers: [
            ItemListControllers(
              productNameController: TextEditingController(),
              productQuantityController: TextEditingController(),
              productPriceController: TextEditingController(),
            ),
          ],
        )
      ], isApprovedByZSMController: TextEditingController());
  int stopItemCounter = 1;
  bool isBankReceiptSelected = false;
  bool isBankReceiptUploaded = false;
  String? imageUrlFromFirebase;
  String dropdownValue = '-SELECT BANK-';
  List<String> bankNamesList = [
    '-SELECT BANK-',
    'Habib Bank Limited\nPK24 HABB 0012 4279 4794 5203',
    'United Bank Limited\nPK33 UNIL 0109 0002 0151 4494',
    'MCB Bank Limited\nPK24 MUCB 0484 8209 4100 0264',
    'Bank Alfalah Limited (Current-RF)\nPK05 ALFH 0047 0010 0541 2385',
    'Bank Alfalah Limited (Current)\nPK59 ALFH 0364 0010 0512 4545',
    'Habib Metropolitan Bank\nPK70 MPBL 0225 0271 4022 0471',
    'Silk Bank Limited (Current-RF)\nPK26 SAUD 0000 1920 0058 3707'
  ];
 // DealersCredit? dealersCredit;
  UserProfile? dealerCredit;
  double availableCredit = 00.00;
  String? creditDocID;

  refresh() {
    setState(() {});
  }

  addMoreStop() =>
      setState(() => stopItemCounter < 4 ? stopItemCounter++ : stopItemCounter);
  removeStop() =>
      setState(() => stopItemCounter > 1 ? stopItemCounter-- : stopItemCounter);
  void uploadBankReceiptToFirebase() async {
    FilePickerResult? bankReceipt;
    try {
      bankReceipt = await FilePicker.platform.pickFiles();
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
    if (bankReceipt != null) {
      isBankReceiptSelected = true;
      setState(() {});
      if (defaultTargetPlatform == TargetPlatform.android) {
        final filePath = File(bankReceipt.files.single.path!);
        String fileName = bankReceipt.files.first.name;
        String receiptName = DateTime.now().toString();
        orderControllers.bankPaymentReceiptController.text =
            receiptName + fileName;
        try {
          await FirebaseStorage.instance
              .ref('bank_receipts')
              .child('$receiptName$fileName')
              .putFile(filePath);
          isBankReceiptUploaded = true;
          getBankReceiptFromFirebase();
          setState(() {});
        } catch (e) {
          isBankReceiptUploaded = false;
        }
      } else {
        Uint8List? fileBytes = bankReceipt.files.single.bytes;
        String fileName = bankReceipt.files.first.name;
        String receiptName = DateTime.now().toString();
        orderControllers.bankPaymentReceiptController.text =
            receiptName + fileName;
        try {
          await FirebaseStorage.instance
              .ref('bank_receipts')
              .child('$receiptName$fileName')
              .putData(fileBytes!);
          isBankReceiptUploaded = true;
          getBankReceiptFromFirebase();
          setState(() {});
        } catch (e) {
          isBankReceiptUploaded = false;
        }
      }
    }
  }

  void getBankReceiptFromFirebase() async {
    final receiptName = orderControllers.bankPaymentReceiptController.text;
    try {
      imageUrlFromFirebase = await FirebaseStorage.instance
          .ref('bank_receipts')
          .child(receiptName)
          .getDownloadURL();
      isBankReceiptUploaded = true;
      setState(() {});
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  void createOrderObject() {
    getDealersAvailableCredit();
    SingleOrder newOrder = SingleOrder.fromOrderControllers(
        orderControllers: orderControllers,
        dealerProfile: widget.dealerProfile);
    placeOrderToFirebase(newOrder);
  }

  void placeOrderToFirebase(SingleOrder newOrder) async {
    try {
      await FirebaseFirestore.instance
          .collection('ordersList')
          .add(newOrder.toJson())
          .then((value) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CONGRATULATIONS!\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              const Text(
                'Your order is placed for further processing!',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const Text('\n'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserRedirection())),
                      child: const Text('CANCEL')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserRedirection())),
                    child: const Text('OKAY'),
                  ),
                ],
              )
            ]),
          ),
        );
      });
      if (orderControllers.creditPaymentController.text != '' &&
          orderControllers.creditPaymentController.text != '0') {
        dealerCredit!.availableCredit = dealerCredit!.availableCredit -
            double.parse(orderControllers.creditPaymentController.text);
        await FirebaseFirestore.instance
            .collection('dealersCredit')
            .doc(creditDocID!)
            .update(dealerCredit!.toJson());
      }
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  void getDealersAvailableCredit() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('dealersCredit')
        .where('dealerUID', isEqualTo: widget.dealerProfile.userUID)
        .get();
    final json = snapshot.docs.single.data();
    creditDocID = snapshot.docs.single.id;
    dealerCredit = UserProfile.fromJson(json);
    availableCredit = dealerCredit!.availableCredit;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                          height: 10,
                        ),
                        const Text(
                          'BILL TO:',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.dealerProfile.userName.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            '${widget.dealerProfile.tehsil}, ${widget.dealerProfile.district},'
                                ' ${widget.dealerProfile.province}, Pakistan\n${widget.dealerProfile.userMobile}'),
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
                            '${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}'),
                        const Text(
                          'ORDER STATUS',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        const Text('DRAFT'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ORDER SUMMERY',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            'ORDER TOTAL: ${orderControllers.orderTotalController().text}'),
                        Text(
                            'ORDER QUANTITY :${orderControllers.orderQuantityController().text}'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'DISPATCH INFO',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        const Text('VEHICLE: PENDING'),
                        const Text('CONTACT: PENDING'),
                        const Text('DATE TIME: PENDING'),
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
                  itemCount: stopItemCounter,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final stopNumber = index + 1;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'STOP NO: $stopNumber  ',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: orderControllers
                                    .stopControllers[index].stopNameController,
                                decoration: const InputDecoration(
                                  labelText: 'STOP ADDRESS',
                                  fillColor: Colors.green,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: orderControllers
                                    .stopControllers[index]
                                    .stopContactController,
                                decoration: const InputDecoration(
                                  labelText: 'CONTACT NO',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(11),
                                ],
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
                                      textAlign: TextAlign.center,
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
                                  alignment: Alignment.center,
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
                        AddProductItems(
                            stopIndex: index,
                            notifyParent: refresh,
                            productsList: widget.productsList,
                            orderControllers: orderControllers),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'STOP TOTAL',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                enabled: false,
                                controller: orderControllers
                                    .stopControllers[index]
                                    .stopTotalController(),
                                decoration:
                                    const InputDecoration(hintText: '00.00'),
                                textAlign: TextAlign.end,
                                onChanged: (x) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'STOP QUANTITY',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                enabled: false,
                                controller: orderControllers
                                    .stopControllers[index]
                                    .stopQuantityController(),
                                decoration:
                                    const InputDecoration(hintText: '00.00'),
                                textAlign: TextAlign.end,
                                onChanged: (x) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: stopItemCounter == index + 1
                              ? const EdgeInsets.symmetric(vertical: 0)
                              : const EdgeInsets.symmetric(vertical: 10),
                          height: 2,
                          color: stopItemCounter == index + 1
                              ? Colors.black
                              : Colors.green,
                          // margin: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            stopItemCounter == index + 1 && stopItemCounter != 4
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (orderControllers
                                              .stopControllers[index]
                                              .stopNameController
                                              .text ==
                                          '') {
                                        showMessageDialog(
                                            message:
                                                'Please enter STOP $stopNumber name!',
                                            context: context);
                                      } else if (orderControllers
                                              .stopControllers[index]
                                              .stopContactController
                                              .text ==
                                          '') {
                                        showMessageDialog(
                                            message:
                                                'Please enter STOP $stopNumber contact no',
                                            context: context);
                                      } else if (double.parse(orderControllers
                                              .stopControllers[index]
                                              .stopTotalController()
                                              .text) ==
                                          0) {
                                        showMessageDialog(
                                            message:
                                                'Please add products to STOP $stopNumber first!',
                                            context: context);
                                      } else if (orderControllers
                                              .stopControllers[index]
                                              .stopContactController
                                              .text
                                              .length !=
                                          11) {
                                        showMessageDialog(
                                            message:
                                                'Please enter 11 digit STOP $stopNumber contact no',
                                            context: context);
                                      } else if (double.parse(orderControllers
                                              .stopControllers[index]
                                              .stopQuantityController()
                                              .text) <
                                          70) {
                                        showMessageDialog(
                                            message:
                                                'Minimum order quantity for each stop is 70! Please add more products or increase existing products quantities to make it greater than or equal to 70.',
                                            context: context);
                                      } else {
                                        orderControllers.stopControllers.add(
                                          StopControllers(
                                            stopContactController:
                                                TextEditingController(),
                                            stopNameController:
                                                TextEditingController(),
                                            itemListControllers: [
                                              ItemListControllers(
                                                productNameController:
                                                    TextEditingController(),
                                                productQuantityController:
                                                    TextEditingController(),
                                                productPriceController:
                                                    TextEditingController(),
                                              ),
                                            ],
                                          ),
                                        );
                                        addMoreStop();
                                      }
                                    },
                                    child: const Text('ADD STOP'),
                                  )
                                : const SizedBox(),
                            stopItemCounter == index + 1 && stopItemCounter != 1
                                ? OutlinedButton(
                                    onPressed: () {
                                      orderControllers.stopControllers
                                          .removeLast();
                                      removeStop();
                                    },
                                    child: const Text('REMOVE STOP'),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        stopItemCounter == index + 1
                            ? Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'ORDER SUMMERY',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'ORDER TOTAL',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          enabled: false,
                                          controller: orderControllers
                                              .orderTotalController(),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'ORDER QUANTITY',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          enabled: false,
                                          controller: orderControllers
                                              .orderQuantityController(),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.green,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'ENTER PAYMENT DETAILS',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            isBankReceiptSelected == false
                                                ? IconButton(
                                                    onPressed: () {
                                                      uploadBankReceiptToFirebase();
                                                      setState(() {
                                                        //  isBankReceiptUploaded = true;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isBankReceiptSelected =
                                                            false;
                                                        orderControllers
                                                            .bankPaymentReceiptController
                                                            .text = '';
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.highlight_remove,
                                                      color: Colors.red,
                                                    )),
                                            isBankReceiptSelected == false
                                                ? const Image(
                                                    image: AssetImage(
                                                        'lib/assets/images/receipt-placeholder.png'),
                                                  )
                                                : isBankReceiptUploaded ==
                                                            false ||
                                                        imageUrlFromFirebase ==
                                                            null
                                                    ? const CircularProgressIndicator()
                                                    : Image.network(
                                                        imageUrlFromFirebase!),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      DropdownButtonFormField(
                                                    isExpanded: true,
                                                    value: dropdownValue,
                                                    onChanged:
                                                        (String? newValue) {
                                                      orderControllers
                                                          .bankNameController
                                                          .text = newValue!;
                                                      if (newValue ==
                                                          '-SELECT BANK-') {
                                                        orderControllers
                                                            .bankNameController
                                                            .text = '';
                                                      }
                                                      setState(() {
                                                        //dropdownValue = newValue!;
                                                      });
                                                    },
                                                    items: bankNamesList.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'BANK PAYMENT',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    enabled: true,
                                                    controller: orderControllers
                                                        .bankPaymentController,
                                                    textAlign: TextAlign.end,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'AVAILABLE CREDIT:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    availableCredit.toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    'ORDER CREDIT',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    enabled: true,
                                                    controller: orderControllers
                                                        .creditPaymentController,
                                                    textAlign: TextAlign.end,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'RENT ADJUSTMENT',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    enabled: true,
                                                    controller: orderControllers
                                                        .rentAdjustmentController,
                                                    textAlign: TextAlign.end,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (orderControllers
                                                .stopControllers[index]
                                                .stopNameController
                                                .text ==
                                            '') {
                                          showMessageDialog(
                                              message:
                                                  'Please enter STOP $stopNumber name!',
                                              context: context);
                                        } else if (orderControllers
                                                .stopControllers[index]
                                                .stopContactController
                                                .text ==
                                            '') {
                                          showMessageDialog(
                                              message:
                                                  'Please enter STOP $stopNumber contact no',
                                              context: context);
                                        } else if (double.parse(orderControllers
                                                .stopControllers[index]
                                                .stopQuantityController()
                                                .text) ==
                                            0) {
                                          showMessageDialog(
                                              message:
                                                  'Please add products to STOP $stopNumber first!',
                                              context: context);
                                        } else if (orderControllers
                                                .stopControllers[index]
                                                .stopContactController
                                                .text
                                                .length !=
                                            11) {
                                          showMessageDialog(
                                              message:
                                                  'Please enter 11 digit STOP $stopNumber contact no',
                                              context: context);
                                        } else if (orderControllers
                                                .bankNameController.text ==
                                            '') {
                                          showMessageDialog(
                                              message:
                                                  'Please select bank account for payment!',
                                              context: context);
                                        } else if (isBankReceiptSelected ==
                                            false) {
                                          showMessageDialog(
                                              message:
                                                  'Please upload bank payment receipt!',
                                              context: context);
                                        } else if ((double.parse(
                                                    orderControllers.bankPaymentController.text) +
                                                double.parse(orderControllers.creditPaymentController.text) +
                                                double.parse(orderControllers.rentAdjustmentController.text)) <
                                            double.parse(orderControllers.orderTotalController().text)) {
                                          final payment = (double.parse(
                                                  orderControllers
                                                      .bankPaymentController
                                                      .text) +
                                              double.parse(orderControllers
                                                  .creditPaymentController
                                                  .text) +
                                              double.parse(orderControllers
                                                  .rentAdjustmentController
                                                  .text));
                                          final remaining = double.parse(
                                                  orderControllers
                                                      .orderTotalController()
                                                      .text) -
                                              payment;

                                          showMessageDialog(
                                              message:
                                                  'Payment amount you have entered is less than order total. Please provide details for the remaining amount of Rs $remaining.',
                                              context: context);
                                        } else if (double.parse(orderControllers.stopControllers[index].stopQuantityController().text) < 70) {
                                          showMessageDialog(
                                              message:
                                                  'Minimum order quantity for each stop is 70! Please add more products or increase products quantities to make it greater than or equal to 70.',
                                              context: context);
                                        } else if (orderControllers.creditPaymentController.text == '') {
                                          orderControllers
                                              .creditPaymentController
                                              .text = '0';
                                        } else if (availableCredit < double.parse(orderControllers.creditPaymentController.text)) {
                                          showMessageDialog(
                                              message:
                                                  'You don\'t have enough credit to place this order! Your available credit limit is Rs $availableCredit. Please enter an amount that is less than $availableCredit.',
                                              context: context);
                                          orderControllers
                                                  .creditPaymentController
                                                  .text =
                                              availableCredit.toString();
                                        } else {
                                          createOrderObject();
                                        }
                                      },
                                      child: const Text('PLACE ORDER'),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
