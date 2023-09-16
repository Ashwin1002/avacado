import 'package:flutter/material.dart';

Future pushToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => widget,
    ),
  );
}

Future pushAndReplaceToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (_) => widget,
    ),
  );
}

Future popAllAndPush(BuildContext context, Widget widget) async {
  await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => widget),
    ModalRoute.withName('/'),
  );
}

Future pushAnimatedToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return Align(
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  );
}
