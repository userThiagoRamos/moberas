import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/services/auth/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:stacked_services/stacked_services.dart';

class ValidationSurveyViewModel extends BaseViewModel {
  Future foo = Future.delayed(const Duration(seconds: 3));
  ValidationSurveyViewModel();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _snackService = locator<SnackbarService>();
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _authService = locator<AuthenticationService>();
  GlobalKey<FormBuilderState> get fbKey => _fbKey;
  final List<String> options = [
    'Concordo totalmente',
    'Concordo',
    'Não concordo nem discordo (indiferente)',
    'Discordo',
    'Discordo totalmente'
  ];

  Future<void> insert() async {
    _fbKey.currentState.saveAndValidate();
    final FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    Map<String, dynamic> formValue = _fbKey.currentState.value;
    formValue.putIfAbsent('date', () => DateTime.now());
    await _firestore
        .collection(
            'users/${firebaseUser.uid}/private_profile/${firebaseUser.uid}/user_experience_survey')
        .add(formValue);
    Timer(Duration(seconds: 4), () {
      _authService.signOut();
    });

    _snackService.showSnackbar(
        message: 'Obrigado por responder o questionário');
  }
}
