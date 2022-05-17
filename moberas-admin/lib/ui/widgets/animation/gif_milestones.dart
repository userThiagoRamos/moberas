import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GifMilestones extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Obrigado por responder ao MobEras!', style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 30, ),),
            Image(
              image: AssetImage('assets/gif/gifMilestones.gif'),
            ),
          ],
        )
    );
  }
}
