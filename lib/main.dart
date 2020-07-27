
import 'package:cloudmusic/redux/appstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'home_page.dart';
import 'commen/utils/hex_color.dart';

void main() {
  Store store = Store<AppState>(appReducer,initialState: AppState(banners: []));
  runApp(MyApp(store: store,));
}

class MyApp extends StatelessWidget {
  final Store store;


  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: this.store,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: HexColor.fromHex("#FF1F14"),
        ),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }

}


