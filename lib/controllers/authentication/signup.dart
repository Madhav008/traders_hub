import 'package:flutter/material.dart';
import 'package:trades_club/database_screen/traders_screen.dart';

import '../../widgets/custom_textfield.dart';
import 'authentications.dart';
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final phoneController = TextEditingController();

  final nameController = TextEditingController();

  String message = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            CustomTextField(
              controller: nameController,
              icon: Icons.perm_identity,
              hint: 'Enter your name',
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: phoneController,
              hint: 'Enter your number',
              icon: Icons.phone,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: emailController,
              hint: 'Enter your email',
              icon: Icons.mail,
            ),
            SizedBox(
              height: height * .02,
            ),
            CustomTextField(
              controller: passwordController,
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Builder(
                builder: (context) => FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    handleSignup();
                  },
                  color: Colors.black38,
                  child: Text(
                    'SignUp',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              message,
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(
              height: height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Do have an account ? ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleSignup() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService().signUp(emailController.text, passwordController.text, nameController.text,phoneController.text,context)
          .then((value) {
        if (value != null) {
          
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TradersScrenn(id: value.uid,),
              ));
        }
      });
    }
  }
}
