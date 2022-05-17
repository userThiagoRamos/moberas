import 'package:flutter/material.dart';
import 'package:mobEras/core/locator.dart';
import 'package:mobEras/core/routes/router.gr.dart';
import 'package:mobEras/ui/views/tcle/tcle_content.dart';
import 'package:stacked_services/stacked_services.dart';

class TcleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tcleText,
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50.0),
                        child: RaisedButton(
                          onPressed: () => locator<NavigationService>()
                              .clearStackAndShow(Routes.textIntroView),
                          elevation: 1,
                          child: Text('Aceito participar',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
