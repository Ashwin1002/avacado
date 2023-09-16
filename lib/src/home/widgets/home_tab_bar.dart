import 'package:avacado_task/common/constants/colors.dart';
import 'package:avacado_task/common/constants/constant_list.dart';
import 'package:flutter/material.dart';

class HomeTabBarWidget extends StatelessWidget {
  const HomeTabBarWidget({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: const EdgeInsets.only(
        bottom: 6.0,
      ),
      isScrollable: true,
      indicatorColor: AppColors.green,
      indicatorWeight: 3.0,
      splashFactory: NoSplash.splashFactory,
      overlayColor: const MaterialStatePropertyAll(
        Colors.transparent,
      ),
      tabs: List.generate(
        ConstantList.demoTabList.length,
        (index) => Tab(
          child: Text(
            ConstantList.demoTabList[index],
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
