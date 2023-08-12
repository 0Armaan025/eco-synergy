import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/auth_repository.dart';

class AuthController {
  // do something and call all the functions from the repository

  final AuthRepository _repository = AuthRepository();

  void signUp(BuildContext context, UserModel model) {
    _repository.signUp(context, model);
  }

  void logIn(BuildContext context, String email, String pass) {
    _repository.login(context, email, pass);
  }
}
