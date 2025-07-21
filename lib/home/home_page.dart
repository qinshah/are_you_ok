import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../icon/icon_manage.dart';
import '../icon/icons_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _source = AssetSource('audio/1.mp3');
  var _icon = IconManage.currentIcon();

  _play() {
    var player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.onPlayerComplete.listen((_) => player.dispose());
    player.play(_source);
  }

  void _changeIcon() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => IconsView(),
      barrierDismissible: true,
    );
    setState(() {
      _icon = IconManage.currentIcon();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('木鱼'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _changeIcon,
            icon: IconManage.currentIcon(size: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.string(
                '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-music-icon lucide-music"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg>'),
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTap: _play,
          child: _icon,
        ),
      ),
    );
  }
}
