import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';

class SignInDesktopPage extends StatefulWidget {
  const SignInDesktopPage({Key? key}) : super(key: key);

  @override
  State<SignInDesktopPage> createState() => _SignInDesktopPageState();
}

class _SignInDesktopPageState extends State<SignInDesktopPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userSignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } catch (e) {
      showMessageDialog(message: e.toString(), context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage(
                'lib/assets/images/maxim_logo.png',
              ),
              width: 400,
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'WELCOME BACK YOU\'VE BEEN MISSED!',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'EMAIL',
                            hintStyle: TextStyle(color: Colors.green)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'PASSWORD',
                            hintStyle: TextStyle(color: Colors.green)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        if (!EmailValidator.validate(emailController.text)) {
                          showMessageDialog(
                              message:
                                  'Invalid email. Please enter correct email address!',
                              context: context);
                        } else if (passwordController.text == '') {
                          showMessageDialog(
                              message: 'Please enter password for your account',
                              context: context);
                        } else if (passwordController.text.length < 6) {
                          showMessageDialog(
                              message:
                                  'Minimum password length is 6 letters. Please enter correct password.',
                              context: context);
                        } else {
                          userSignIn();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// const Center(
// child: Text('SignInDesktopPage'),
// ),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'operations@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN OPERATIONS')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'zonalmanager@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN ZONAL MANAGER')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'zonalmanager1@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN ZONAL MANAGER 1')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesmanager@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES MANAGER')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesmanager1@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES MANAGER 1')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesmanager2@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES MANAGER 2')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesmanager3@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES MANAGER 3')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer1@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 1')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer2@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 2')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer3@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 3')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer4@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 4')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer5@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 5')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer6@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 6')),
// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'salesofficer7@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN SALES OFFICER 7')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer1@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 1')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer2@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 2')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer3@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 3')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer4@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 4')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer5@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 5')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer6@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 6')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer7@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 7')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer8@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 8')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer9@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 9')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer10@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 10')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer11@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 11')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer12@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 12')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer13@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 13')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer14@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 14')),
// ElevatedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signInWithEmailAndPassword(
// email: 'dealer15@microcorporate.com',
// password: '8808044');
// },
// child: const Text('SIGN IN DEALER 15')),
// ],
// ),
