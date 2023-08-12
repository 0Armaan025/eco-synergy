import 'package:eco_synergy/constants/utils.dart';
import 'package:eco_synergy/features/auth/models/user.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AuthRepository {
  void signUp(BuildContext context, UserModel model) async {
    // sign up here

    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: model.email, password: model.pass)
          .then((value) {
        userUid = firebaseAuth.currentUser?.uid ?? '';

        firestore
            .collection('users')
            .doc(firebaseAuth.currentUser?.uid ?? '')
            .set(model.toMap())
            .then((value) {
          // moveScreen(context, )
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void login(BuildContext context, String email, String pass) {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {});
  }
}
