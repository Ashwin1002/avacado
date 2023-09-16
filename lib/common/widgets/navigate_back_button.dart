import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateBackButton extends StatelessWidget {
  const NavigateBackButton({
    super.key,
    this.onBackPressed,
    this.color,
    this.size,
  });

  final VoidCallback? onBackPressed;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBackPressed ?? () => Navigator.pop(context),
      highlightColor: Colors.transparent,
      child: Icon(
        CupertinoIcons.back,
        color: color ?? Colors.white,
        size: size ?? 24,
      ),
    );
  }
}
