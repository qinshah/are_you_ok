import 'package:flutter/material.dart';

import 'sound.dart';

class SoundSelectDialog extends StatelessWidget {
  const SoundSelectDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('木鱼音效'),
      content: SizedBox(
        width: double.maxFinite,
        height: 300, // 设置一个固定的高度
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Sound().paths.length,
          itemBuilder: (context, index) {
            var soundPath = Sound().paths[index];
            return ListTile(
              onTap: () {
                Sound().current = soundPath;
                Navigator.pop(context);
              },
              title: Text(soundPath.split('/').last),
              trailing: Icon(
                soundPath == Sound().current ? Icons.check : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
