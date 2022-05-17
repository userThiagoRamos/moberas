import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobEras/core/globals.dart';
import 'package:mobEras/core/models/survey.dart';
import 'package:mobEras/core/models/user_profile.dart';
import 'package:mobEras/core/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

String getRandomId() {
  final Firestore _db = Firestore.instance;
  return _db.collection('').document().documentID;
}

class Document<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = _db.document(path);
  }

  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data, v.documentID) as T);
  }

  Stream<T> streamData() {
    try {
      return ref
          .snapshots()
          .map((v) => Global.models[T](v.data, v.documentID) as T);
    } catch (e) {
      Logger.e(e.questionMessage);
      return Stream<T>.empty();
    }
  }

  Future<void> upsert(Map data) {
    return ref.setData(Map<String, dynamic>.from(data), merge: true);
  }
}

class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();
    return snapshots.documents
        .map((doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) => list.documents
        .map((doc) => Global.models[T](doc.data, doc.documentID) as T)
        .toList());
  }
}

class UserSurveyStatus<T extends Survey> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String surveyStatusPath = 'users/##/private_profile/##/survey/##';

  Stream<Survey> streamData() =>
      _auth.onAuthStateChanged.switchMap((user) => user != null
          ? Document<T>(path: surveyStatusPath.replaceAll('##', user.uid))
              .streamData()
          : Stream<Survey>.value(null));

  Future<Survey> getDocument() async {
    var user = await _auth.currentUser();
    if (user != null) {
      return Document<T>(path: surveyStatusPath.replaceAll('##', user.uid))
          .getData();
    } else {
      return null;
    }
  }

  Future<DocumentReference> getDocumentRef() async {
    var user = await _auth.currentUser();
    if (user != null) {
      return Document<T>(path: surveyStatusPath.replaceAll('##', user.uid)).ref;
    } else {
      return null;
    }
  }
}

// Disponibiliza as colecoes de perfil do usuario logado.
class UserProfileData {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection = 'users';

  Future<UserProfile> getDocument() async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      return Document<UserProfile>(path: '$collection/${user.uid}').getData();
    } else {
      return null;
    }
  }

  Stream<UserProfile> streamDocument() {
    return _auth.onAuthStateChanged.switchMap((user) => user != null
        ? Document<UserProfile>(path: '$collection/${user.uid}').streamData()
        : Stream.empty());
  }

  Future<void> upsert(Map data) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Document<UserProfile> ref = Document(path: '$collection/${user.uid}');
      return ref.upsert(data);
    }
  }

  Future<void> upsertPrivateProfile(Map data) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Document<UserProfile> ref =
          Document(path: '$collection/${user.uid}/private_profile/${user.uid}');
      return ref.upsert(data);
    }
  }

  Future<void> registerUserQuestion(String msg) async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Document<UserProfile> ref = Document(
          path:
              '$collection/${user.uid}/private_profile/${user.uid}/questions/${DateTime.now().toIso8601String()}');
      return ref.upsert({'question': msg});
    }
  }
}
