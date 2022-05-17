import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobEras/core/localization/localization.dart';
import 'package:mobEras/ui/views/home/home_view.dart';
import 'package:mobEras/ui/views/main/main_viewmodel.dart';
import 'package:mobEras/ui/views/settings/settings_view.dart';
import 'package:mobEras/ui/widgets/animation/fade_in.dart';
import 'package:mobEras/ui/widgets/lazy_index_stack.dart';
import 'package:stacked/stacked.dart';

/// Main view container that handles rendering pages according to which bottom
/// navigation bar item is tapped
///   - can be replaced with a [TabView]
class MainView extends StatelessWidget {
  final _views = <Widget>[
    FadeIn(child: HomeView()),
    FadeIn(child: SettingsView()),
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => Scaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: model.index,
          itemCount: _views.length,
          itemBuilder: (_, index) => _views[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text(local.homeViewTitle),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(local.settingsViewTitle),
            ),
          ],
          onTap: model.changeTab,
        ),
      ),
    );
  }
}
