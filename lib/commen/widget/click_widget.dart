import 'package:flutter/material.dart';

class ClickWidget extends StatelessWidget {

  final Widget child;
  final Function onClick;


  ClickWidget({@required this.child, this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onTap: onClick,
    );
  }
}
