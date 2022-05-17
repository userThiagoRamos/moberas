import 'package:flutter/material.dart';
import 'package:moberas_dashboard/features/login/models/user_profile.dart';
import 'package:stacked/stacked.dart';

class PacientInfoBoxWidget extends ViewModelWidget<UserProfile> {
  @override
  Widget build(BuildContext context, UserProfile pacient) => pacient != null
      ? Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  pacient.displayName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        )
      : Center(
          child: CircularProgressIndicator(),
        );
}
