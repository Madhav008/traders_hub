import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../database.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();


  Future updateProfile(String name, String phoneNumber, String imgUrl) async {
    FirebaseUser user = await auth.currentUser();

    await DatabaseServices(uid: user.uid)
        .updateUserData(imgUrl, user.email, name, phoneNumber, );
  }

  showErrDialog(BuildContext context, String err) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Error"),
        content: Text(err),
        actions: <Widget>[
          OutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  // ignore: missing_return
  Future<bool> googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await gooleSignIn.signIn();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // ignore: unused_local_variable
      AuthResult result = await auth.signInWithCredential(credential);

      FirebaseUser user = await auth.currentUser();
      
      await DatabaseServices(uid: user.uid).updateUserData(
          user.photoUrl, user.email, user.displayName, user.phoneNumber,);

      return Future.value(true);
    }
  }

// instead of returning true or false
// returning user to directly access UserID
  Future<FirebaseUser> signin(
      String email, String password, BuildContext context) async {
    try {
      AuthResult result =
          await auth.signInWithEmailAndPassword(email: email, password: email);
      FirebaseUser user = result.user;
      // return Future.value(true);

      return Future.value(user);
    } catch (e) {
      // simply passing error code as a message
      print(e.code);
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_WRONG_PASSWORD':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_NOT_FOUND':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_USER_DISABLED':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          showErrDialog(context, e.code);
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          showErrDialog(context, e.code);
          break;
      }
      // since we are not actually continuing after displaying errors
      // the false value will not be returned
      // hence we don't have to check the valur returned in from the signin function
      // whenever we call it anywhere
      return Future.value(null);
    }
  }

// change to Future<FirebaseUser> for returning a user
  Future<FirebaseUser> signUp(String email, String password, String name,
      String phone, BuildContext context) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: email);
      FirebaseUser user = result.user;

      await DatabaseServices(uid: user.uid)
          .updateUserData(user.photoUrl, user.email, name, phone,);
      return Future.value(user);
      // return Future.value(true);
    } catch (error) {
      switch (error.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          showErrDialog(context, "Email Already Exists");
          break;
        case 'ERROR_INVALID_EMAIL':
          showErrDialog(context, "Invalid Email Address");
          break;
        case 'ERROR_WEAK_PASSWORD':
          showErrDialog(context, "Please Choose a stronger password");
          break;
      }
      return Future.value(null);
    }
  }

  Future<bool> signOutUser() async {
    FirebaseUser user = await auth.currentUser();
    if (user.providerData[1].providerId == 'google.com') {
      await FirebaseAuth.instance.signOut();
    }
    await auth.signOut();
    return Future.value(true);
  }
}
