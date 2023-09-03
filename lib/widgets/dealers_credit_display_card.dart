import 'package:flutter/material.dart';
import 'package:maximagri/models/credit_model/dealer_credit_model.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:intl/intl.dart';

class DealerCreditProfileCard extends StatefulWidget {
  final UserProfile userProfile;
 // final DealersCredit dealersCredit;
  final Function() onTap;
  const DealerCreditProfileCard(
      {Key? key,
      required this.userProfile,
    //  required this.dealersCredit,
      required this.onTap})
      : super(key: key);

  @override
  State<DealerCreditProfileCard> createState() =>
      _DealerCreditProfileCardState();
}

class _DealerCreditProfileCardState extends State<DealerCreditProfileCard> {
  final numberFormat = NumberFormat('#,##,##,##,###');
  final cnicFormat = NumberFormat('#####-#######-#');
  @override
  Widget build(BuildContext context) {
    final String address =
        '${widget.userProfile.province}, ${widget.userProfile.district}, '
        '${widget.userProfile.tehsil}';
    return InkWell(
      onTap: widget.onTap,
      //  hoverColor: Colors.lightGreen,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shadowColor: Colors.green,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      leading: const Icon(
                        Icons.credit_score,
                        color: Colors.green,
                      ),
                      title: Text(
                          numberFormat
                              .format(widget.userProfile.creditLimit)
                              .toString()
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.payments_outlined,
                          color: Colors.green),
                      title: Text(
                          numberFormat
                              .format(widget.userProfile.availableCredit)
                              .toString()
                              .toUpperCase(),
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
                        Icons.person_2_outlined,
                        color: Colors.green,
                      ),
                      title: Text(widget.userProfile.userName.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.move_down, color: Colors.green),
                      title: Text(widget.userProfile.userType.toString(),
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
                      leading:
                          const Icon(Icons.credit_card, color: Colors.green),
                      title: Text(widget.userProfile.userCNIC.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: Text(widget.userProfile.userMobile.toUpperCase(),
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
                      leading:
                          const Icon(Icons.location_on, color: Colors.green),
                      title: Text(
                          '${widget.userProfile.tehsil}, ${widget.userProfile.district}, ${widget.userProfile.province}, Pakistan',
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
    );
  }
}
