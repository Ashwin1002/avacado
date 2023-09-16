import 'package:avacado_task/common/constants/assets.dart';
import 'package:avacado_task/common/constants/colors.dart';
import 'package:avacado_task/common/utils/extensions/mediaquery_extension.dart';
import 'package:avacado_task/common/utils/extensions/space_extension.dart';
import 'package:avacado_task/common/utils/extensions/string_extension.dart';
import 'package:avacado_task/common/utils/post_utils.dart';
import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:avacado_task/src/home/widgets/channel_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isYoutube(int index) => index % 3 == 0 || index % 4 == 0;

bool isTopNews(int index) => index % 2 == 0 || index % 5 == 0;

bool isABCNews(int index) => index % 6 == 0;

class GridListItemWidget extends StatelessWidget {
  const GridListItemWidget({
    super.key,
    required this.indexItem,
    required this.index,
    this.onItemPressed,
  });

  final PostModel indexItem;
  final int index;
  final VoidCallback? onItemPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.green.withAlpha(50),
      borderRadius: BorderRadius.circular(8.0),
      onTap: onItemPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: AppColors.lightGrey,
            width: .8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              indexItem.title.capitalize(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
            8.0.spaceY,
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ChannelButton(
                    assetPath: PostUtils.getLogo(index),
                    color: PostUtils.getColor(index),
                    channel: PostUtils.getChannelName(index),
                  ),
                ),
                10.0.spaceX,
                // const Spacer(),
                Flexible(
                  flex: 3,
                  child: Text(
                    PostUtils.getTimeStamp(index),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                )
              ],
            ),
            10.0.spaceY,
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: indexItem.id,
                  child: Container(
                    height: context.deviceHeight * .16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: AssetImage(AssetList.thumbnail),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.play_fill,
                    size: 20.0,
                    color: AppColors.darkBlue,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
