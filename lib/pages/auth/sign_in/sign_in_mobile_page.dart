import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maximagri/widgets/show_dialog_message.dart';

class SignInMobilePage extends StatefulWidget {
  const SignInMobilePage({Key? key}) : super(key: key);

  @override
  State<SignInMobilePage> createState() => _SignInMobilePageState();
}

class _SignInMobilePageState extends State<SignInMobilePage> {
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage(
                    'lib/assets/images/maxim_logo_cropped.png',
                  ),
                  width: 150,
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
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
