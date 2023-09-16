import 'package:avacado_task/common/constants/assets.dart';
import 'package:avacado_task/common/constants/colors.dart';
import 'package:avacado_task/common/utils/extensions/string_extension.dart';
import 'package:avacado_task/common/utils/time_utils.dart';
import 'package:flutter/widgets.dart';

bool isYoutube(int index) => index % 3 == 0 || index % 4 == 0;

bool isTopNews(int index) => index % 2 == 0 || index % 5 == 0;

bool isABCNews(int index) => index % 6 == 0;

class PostUtils {
  const PostUtils._();

  static String getChannelName(int index) {
    if (isYoutube(index)) {
      return 'Youtube';
    } else if (isTopNews(index)) {
      return 'Top News';
    } else if (isABCNews(index)) {
      return 'ABC News';
    } else {
      return 'Facebook';
    }
  }

  static Color getColor(int index) {
    if (isYoutube(index)) {
      return AppColors.red;
    } else if (isTopNews(index)) {
      return AppColors.purple;
    } else if (isABCNews(index)) {
      return AppColors.green;
    } else {
      return AppColors.blue;
    }
  }

  static String getLogo(int index) {
    if (isYoutube(index)) {
      return AssetList.youtubeLogo;
    } else if (isTopNews(index)) {
      return AssetList.topNewsLogo;
    } else if (isABCNews(index)) {
      return AssetList.abcNewsLogo;
    } else {
      return AssetList.facebookLogo;
    }
  }

  static String getTimeStamp(int index) {
    if (isYoutube(index)) {
      return TimeUtils().justNow.toTimeDurationFromNow();
    } else if (isTopNews(index)) {
      return TimeUtils().aDayAgo.toTimeDurationFromNow();
    } else if (isABCNews(index)) {
      return TimeUtils().fiveHoursAgo.toTimeDurationFromNow();
    } else {
      return TimeUtils().hourAgo.toTimeDurationFromNow();
    }
  }
}
