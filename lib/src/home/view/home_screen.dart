import 'package:avacado_task/common/constants/assets.dart';
import 'package:avacado_task/common/constants/colors.dart';
import 'package:avacado_task/common/constants/constant_list.dart';
import 'package:avacado_task/common/utils/extensions/space_extension.dart';
import 'package:avacado_task/common/utils/navigator_utils.dart';
import 'package:avacado_task/common/utils/post_utils.dart';
import 'package:avacado_task/common/widgets/custom_appbar.dart';
import 'package:avacado_task/common/widgets/custom_transition_widget.dart';
import 'package:avacado_task/common/widgets/my_error_widget.dart';
import 'package:avacado_task/common/widgets/svg_viewer.dart';
import 'package:avacado_task/src/home/bloc/bloc.dart';
import 'package:avacado_task/src/home/view/post_detail.dart';
import 'package:avacado_task/src/home/widgets/home_tab_bar.dart';
import 'package:avacado_task/src/home/widgets/grid_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animation;

  late final Animation<Offset> _offsetAnimation;

  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _tabController = TabController(
      length: ConstantList.demoTabList.length,
      vsync: this,
    );

    _scrollController.addListener(_onScroll);

    _animation.forward();
  }

  @override
  void dispose() {
    _animation.dispose();
    _tabController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _initializeAnimation() {
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animation,
      curve: Curves.decelerate,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animation,
      curve: Curves.decelerate,
    ));
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(FetchPostListEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Videos',
        actions: [
          CustomTransitionWidget(
            animation: _animation,
            offsetAnimation: _offsetAnimation,
            opacityAnimation: _opacityAnimation,
            child: Row(
              children: [
                SvgViewer.fromAsset(path: AssetList.searchLogo),
                10.0.spaceX,
                SvgViewer.fromAsset(path: AssetList.shareLogo, size: 24),
                15.0.spaceX
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state.status) {
            (HomeStatus.loading) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            (HomeStatus.error) => MyErrorWidget(
                message: state.message,
                onTryAgainPressed: () =>
                    context.read<HomeBloc>()..add(FetchPostListEvent()),
              ),
            (HomeStatus.success) => state.posts.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: 15.0.spaceY,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 50,
                          maxHeight: 50,
                          child: HomeTabBarWidget(
                            tabController: _tabController,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: 15.0.spaceY,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      sliver: SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: .72,
                        ),
                        itemCount: state.hasReachedMax
                            ? state.posts.length
                            : state.posts.length + 1,
                        itemBuilder: (_, index) {
                          return index >= state.posts.length
                              ? const CupertinoActivityIndicator()
                              : GridListItemWidget(
                                  indexItem: state.posts[index],
                                  index: index,
                                  onItemPressed: () => pushAnimatedToPage(
                                    context,
                                    PostDetailScreen(
                                      dataModel: state.posts[index],
                                      channelName:
                                          PostUtils.getChannelName(index),
                                      timeAgo:
                                          PostUtils.getTimeStamp(index),
                                      channelColor:
                                          PostUtils.getColor(index),
                                      channelPath: PostUtils.getLogo(index),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: 25.0.spaceY,
                    ),
                  ],
                ),
          };
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Card(
        elevation: 5,
        color: AppColors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
