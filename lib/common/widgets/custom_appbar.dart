import 'package:avacado_task/common/widgets/navigate_back_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.label,
    this.showBackButton = false,
    this.actions,
  });

  final String label;
  final bool showBackButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(label),
      leadingWidth: 56.0,
      leading:
          showBackButton ? const NavigateBackButton() : const SizedBox.shrink(),
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}
