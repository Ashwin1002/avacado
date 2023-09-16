import 'package:avacado_task/common/constants/colors.dart';
import 'package:avacado_task/common/utils/extensions/space_extension.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.message,
    this.onTryAgainPressed,
  });

  final String message;
  final VoidCallback? onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          10.0.spaceY,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
            ),
            onPressed: onTryAgainPressed,
            child: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
