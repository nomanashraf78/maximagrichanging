import 'package:flutter/material.dart';
import 'package:maximagri/models/order_model/single_order_model.dart';
import 'package:intl/intl.dart';

class SingleOrderDisplayCard extends StatefulWidget {
  final SingleOrder orderInfo;
  final Function() onTap;
  const SingleOrderDisplayCard(
      {Key? key, required this.orderInfo, required this.onTap})
      : super(key: key);

  @override
  State<SingleOrderDisplayCard> createState() => _SingleOrderDisplayCardState();
}

class _SingleOrderDisplayCardState extends State<SingleOrderDisplayCard> {
  final numberFormat = NumberFormat('#,##,##,##,###');
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
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
                            widget.orderInfo.dateTime.toString().toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        tileColor: widget.orderInfo.orderStatus.name ==
                                    'canceled' ||
                                widget.orderInfo.orderStatus.name == 'rejected'
                            ? Colors.black
                            : widget.orderInfo.orderStatus.name == 'pending' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'confirmed' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'forwarded' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'approved'
                                ? Colors.orange
                                : widget.orderInfo.orderStatus.name ==
                                            'processing' ||
                                        widget.orderInfo.orderStatus.name ==
                                            'dispatched'
                                    ? Colors.green
                                    : Colors.blue,
                        leading: widget.orderInfo.orderStatus.name ==
                                    'canceled' ||
                                widget.orderInfo.orderStatus.name == 'rejected'
                            ? const Icon(Icons.cancel_outlined,
                                color: Colors.white)
                            : widget.orderInfo.orderStatus.name == 'pending' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'confirmed' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'forwarded' ||
                                    widget.orderInfo.orderStatus.name ==
                                        'approved'
                                ? const Icon(Icons.add_shopping_cart_outlined,
                                    color: Colors.white)
                                : widget.orderInfo.orderStatus.name ==
                                            'processing' ||
                                        widget.orderInfo.orderStatus.name ==
                                            'dispatched'
                                    ? const Icon(Icons.fire_truck_outlined,
                                        color: Colors.white)
                                    : const Icon(Icons.check_circle_outlined,
                                        color: Colors.white),
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                              widget.orderInfo.orderStatus.name.toUpperCase(),
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
                          Icons.person_2_outlined,
                          color: Colors.green,
                        ),
                        title: Text(widget.orderInfo.dealerName.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Icon(
                          Icons.contact_phone_outlined,
                          color: Colors.green,
                        ),
                        title: Text(widget.orderInfo.dealerNumber.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
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
                            Icons.shopping_cart_checkout_outlined,
                            color: Colors.green),
                        title: Text(
                            'QUANTITY: ${widget.orderInfo.orderQuantity}'
                                .toString()
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading: const Icon(Icons.price_change_rounded,
                            color: Colors.green),
                        title: Text(
                            'TOTAL: ${numberFormat.format(widget.orderInfo.orderTotal).toString().toUpperCase()}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: const Icon(Icons.payments_outlined,
                            color: Colors.green),
                        title: Text(
                            'BANK: ${numberFormat.format(widget.orderInfo.bankAmount).toString().toUpperCase()}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        leading:
                            const Icon(Icons.credit_score, color: Colors.green),
                        title: Text(
                            'CREDIT: ${numberFormat.format(widget.orderInfo.creditPayment).toString()}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: const Icon(Icons.location_city_outlined,
                            color: Colors.green),
                        title: Text(
                            '${widget.orderInfo.tehsil}, ${widget.orderInfo.district}, ${widget.orderInfo.province}, Pakistan',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.navigate_next,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
