import 'package:cloudmusic/commen/net/http_request.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        child: Text('登录'),
        onPressed: () {
          login();
        },
      ),
    );
  }
}

void login() {
  httpRequest
      .get(path: "/login/cellphone?phone=17684721017&password=qweasdzxc")
      .then((value) {
    print(value);
    Fluttertoast.showToast(msg: "登录成功");
  });
}
