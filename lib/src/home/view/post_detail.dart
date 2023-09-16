import 'package:avacado_task/common/common.dart';
import 'package:avacado_task/src/home/home.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    super.key,
    required this.dataModel,
    required this.channelName,
    required this.timeAgo,
    required this.channelColor,
    required this.channelPath,
  });

  final PostModel dataModel;
  final String channelName;
  final Color channelColor;
  final String channelPath;
  final String timeAgo;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;
  final videoUrl = 'https://www.youtube.com/watch?v=HPJKxAhLw5I';

  late AnimationController _animation;

  late final Animation<Offset> _offsetAnimation;

  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );

    _animation.forward();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: 'Post',
        showBackButton: true,
        actions: [
          CustomTransitionWidget(
            animation: _animation,
            offsetAnimation: _offsetAnimation,
            opacityAnimation: _opacityAnimation,
            child: Row(
              children: [
                SvgViewer.fromAsset(path: AssetList.heartLogo, size: 24),
                10.0.spaceX,
                SvgViewer.fromAsset(path: AssetList.shareLogo, size: 24),
                15.0.spaceX,
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.dataModel.id,
              child: SizedBox(
                height: context.deviceHeight / 3,
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                      colors: const ProgressBarColors(
                        playedColor: AppColors.green,
                        handleColor: AppColors.green,
                      ),
                    ),
                    FullScreenButton(),
                  ],
                ),
              ),
            ),
            10.0.spaceY,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      UrlUtils().goToUrl(videoUrl);
                    },
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: SizedBox(
                      height: 30,
                      width: context.deviceWidth * .25,
                      child: ChannelButton(
                        color: widget.channelColor,
                        channel: widget.channelName,
                        assetPath: widget.channelPath,
                      ),
                    ),
                  ),
                  Text(
                    widget.timeAgo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            15.0.spaceY,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dataModel.title.capitalize(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16.0,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  20.0.spaceY,
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '9,999 views ',
                      style: const TextStyle(
                        fontSize: 13.0,
                        letterSpacing: .5,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text:
                              '${DateTime.parse('2023-08-22').toString().toEnglishDate()} ',
                        ),
                        TextSpan(
                          text:
                              widget.dataModel.title.capitalize().insertHash(),
                          style: const TextStyle(
                              // decoration: TextDecoration.underline,
                              ),
                        )
                      ],
                    ),
                  ),
                  20.0.spaceY,
                  Text(
                    widget.dataModel.body.capitalize(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      letterSpacing: .5,
                      wordSpacing: .4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
