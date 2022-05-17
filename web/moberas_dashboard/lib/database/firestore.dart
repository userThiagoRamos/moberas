import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:moberas_dashboard/features/pacient/models/theme_cfg.dart';
import 'package:rxdart/rxdart.dart';

import 'globals.dart';

final _log = Logger('firestoreDB');

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
      _log.severe(e);
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
  Query ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();
    return snapshots.documents
        .map((doc) => Global.models[T](doc.data,doc.documentID) as T)
        .toList();
  }

  Future<List<T>> getPositionData() async {
    var snapshots = await ref.orderBy('date').getDocuments();
    return snapshots.documents
        .map((doc) => Global.models[T](doc.data,doc.documentID) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) => list.documents
        .map((doc) => Global.models[T](doc.data, doc.documentID) as T)
        .toList());
  }
}

class UserThemeData {
  Future<void> updateTheme(ThemeCfg themeCfg, String uid) async {
    return Document<UserProfile>(
            path: '/users/$uid/private_profile/$uid/preferences/theme')
        .upsert(themeCfg.toJson());
  }

  Future<ThemeCfg> fetchTheme(String uid) async {
    return Document<ThemeCfg>(
            path: '/users/$uid/private_profile/$uid/preferences/theme')
        .getData();
  }
}

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
}
