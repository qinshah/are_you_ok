import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../icon/svg_icon.dart';
import '../icon/icon_select_dialog.dart';
import '../sound/sound.dart';
import '../sound/sound_select_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var _source = AssetSource(Sound().current.substring('assets/'.length));
  var _iconSvg = SvgIcon().current;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onTapDown(TapDownDetails details) {
    _controller.reverse();
    var player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.onPlayerComplete.listen((_) {
      player.release();
      player.dispose();
    });
    player.play(_source);
  }

  _onTapUp(TapUpDetails details) {
    _controller.forward();
  }

  void _changeIcon() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => IconSelectDialog(),
      barrierDismissible: true,
    );
    setState(() {
      _iconSvg = SvgIcon().current;
    });
  }

  void _changeSound() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => SoundSelectDialog(),
      barrierDismissible: true,
    );
    setState(() {
      _source = AssetSource(Sound().current.substring('assets/'.length));
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
            icon: SvgPicture.string(
              _iconSvg,
              width: 30,
            ),
          ),
          IconButton(
            onPressed: _changeSound,
            icon: SvgPicture.string(
                width: 32,
                '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-music-icon lucide-music"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg>'),
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: () => _controller.forward(),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Transform.scale(
              scale: 0.8 + (_controller.value * 0.2),
              child: SvgPicture.string(_iconSvg, width: 200),
            ),
          ),
        ),
      ),
    );
  }
}
