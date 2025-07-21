import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'icon_manage.dart';

class IconsView extends StatelessWidget {
  const IconsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            IconManage.iconStrings.length,
            (index) => GestureDetector(
              onTap: () {
                IconManage.setIcon(index);
                Navigator.pop(context);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.string(
                  IconManage.iconStrings[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
