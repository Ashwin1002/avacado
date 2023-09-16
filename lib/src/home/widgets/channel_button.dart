import 'package:avacado_task/common/utils/extensions/space_extension.dart';
import 'package:avacado_task/common/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';

class ChannelButton extends StatelessWidget {
  const ChannelButton({
    super.key,
    required this.color,
    required this.channel,
    required this.assetPath,
  });

  final Color color;
  final String assetPath;
  final String channel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          SvgViewer.fromAsset(
            path: assetPath,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          10.0.spaceX,
          Expanded(
            child: Text(
              channel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
