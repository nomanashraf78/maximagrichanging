import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maximagri/models/user_profile_model/user_profile_model.dart';
import 'package:maximagri/utilities/user_authentication.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';
import 'package:email_validator/email_validator.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateDealerBySalesOfficer extends StatefulWidget {
  const CreateDealerBySalesOfficer({Key? key}) : super(key: key);

  @override
  State<CreateDealerBySalesOfficer> createState() =>
      _CreateDealerBySalesOfficerState();
}

class _CreateDealerBySalesOfficerState
    extends State<CreateDealerBySalesOfficer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'CREATE NEW DEALER ACCOUNT',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'DEALER NAME',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'DEALER EMAIL',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: cnicController,
            decoration: const InputDecoration(
              labelText: 'DEALER CNIC',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(13),
              MaskTextInputFormatter(mask: '#####-#######-#'),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'DEALER PHONE NO',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'ENTER PASSWORD',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            controller: confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'CONFIRM PASSWORD',
              fillColor: Colors.green,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                if (nameController.text == '') {
                  showMessageDialog(
                      message: 'Please enter dealer name!', context: context);
                } else if (!EmailValidator.validate(emailController.text)) {
                  showMessageDialog(
                      message:
                          'Invalid email! Please enter a valid email address!',
                      context: context);
                } else if (cnicController.text == '') {
                  showMessageDialog(
                      message: 'Please enter dealer cnic number!',
                      context: context);
                } else if (phoneController.text == '') {
                  showMessageDialog(
                      message: 'Please enter dealer mobile number!',
                      context: context);
                } else if (cnicController.text.length != 15) {
                  showMessageDialog(
                      message:
                          'Dealer CNIC is incomplete. Please enter 13 digits dealer cnic number!',
                      context: context);
                } else if (phoneController.text.length != 11) {
                  showMessageDialog(
                      message:
                          'Dealer phone number is incorrect. Please enter 11 digits dealer mobile number starting with +923!',
                      context: context);
                } else if (passwordController.text == '' ||
                    confirmPasswordController.text == '') {
                  showMessageDialog(
                      message:
                          'Password or Confirm Password is empty! Please try again with strong password.',
                      context: context);
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  showMessageDialog(
                      message:
                          'Password & Confirm Password do not match! Please try again.',
                      context: context);
                } else if (passwordController.text.length < 7 ||
                    confirmPasswordController.text.length < 7) {
                  showMessageDialog(
                      message:
                          'Password or Confirm Password length is less than 7 letters! Please try again with strong password.',
                      context: context);
                } else {
                  createNewDealerAccount();
                }
              },
              child: const Text('CREATE DEALER'))
        ],
      ),
    );
  }

  void createNewDealerAccount() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userProfile')
          .where('userUID', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      final json = snapshot.docs.first.data();

      UserProfile currentUser = UserProfile.fromJson(json);

      //  createFirebaseAuthUser();

      try {
        FirebaseAuth.instance.signOut();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        confirmDealerCreationAndRedirect();
      } catch (e) {
        // showMessageDialog(message: e.toString(), context: context);
      }

      // UserProfile newDealer = UserProfile(
      //     userUID: FirebaseAuth.instance.currentUser!.uid,
      //     userName: nameController.text,
      //     userCNIC: cnicController.text,
      //     userType: UserType.dealer,
      //     userMobile: phoneController.text,
      //     userStatus: false,
      //     userAddress: currentUser.userAddress,
      //     franchiseeUID: currentUser.franchiseeUID,
      //     operationsUID: currentUser.operationsUID,
      //     zonalManagerUID: currentUser.zonalManagerUID,
      //     salesManagerUID: currentUser.salesManagerUID,
      //     salesOfficerUID: currentUser.userUID);

    //  uploadDealerProfileToFirebase(newDealer);
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  void uploadDealerProfileToFirebase(UserProfile userProfile) async {
    await FirebaseFirestore.instance
        .collection('userProfile')
        .add(userProfile.toJson());
  }

  void createFirebaseAuthUser() async {
    try {
      FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      confirmDealerCreationAndRedirect();
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  confirmDealerCreationAndRedirect() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'CONGRATULATIONS!\n',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const Text(
            'New dealer is created under your account. Please proceed to check new dealer account!',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const Text('\n'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserAuthentication())),
                  child: const Text('CANCEL')),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserAuthentication())),
                child: const Text('OKAY'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
