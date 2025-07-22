import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'svg_icon.dart';

class IconSelectDialog extends StatelessWidget {
  const IconSelectDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('图标'),
      content: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          SvgIcon.iconSvgs.length,
          (index) {
            var iconSvg = SvgIcon.iconSvgs[index];
            return GestureDetector(
              onTap: () {
                SvgIcon().current = iconSvg;
                Navigator.pop(context);
              },
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconSvg == SvgIcon().current
                      ? Colors.green[200]
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.string(iconSvg),
              ),
            );
          },
        ),
      ),
    );
  }
}
