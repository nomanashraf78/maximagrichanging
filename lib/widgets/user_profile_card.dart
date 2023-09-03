import 'package:flutter/material.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfile userProfile;
  final Function() onTap;
  const UserProfileCard(
      {Key? key, required this.userProfile, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                        Icons.person_2_outlined,
                        color: Colors.green,
                      ),
                      title: Text(userProfile.userName.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.move_down, color: Colors.green),
                      title: Text(userProfile.userType.toString(),
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
                      title: Text(userProfile.userCNIC.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: Text(userProfile.userMobile.toUpperCase(),
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
                          '${userProfile.tehsil}, ${userProfile.district}, ${userProfile.province}, Pakistan',
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
