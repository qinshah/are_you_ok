import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/nav.dart';
import 'package:flutter/material.dart';

import '../do_something/do_something_page.dart';
import '../record/record_page.dart';
import '../me/me_page.dart';
import '../icon/icon_select_dialog.dart';
import '../icon/svg_icon.dart';
import '../sound/sound.dart';
import '../sound/sound_select_dialog.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  final _radius = 50.0;
  final _rows = 2;
  final _spacing = 20.0;
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

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
    var player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.onPlayerComplete.listen((_) {
      player.release();
      player.dispose();
    });
    player.play(_source);
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("你还好吗"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _changeIcon,
            icon: SvgPicture.string(_iconSvg, width: 24),
          ),
          IconButton(
            onPressed: _changeSound,
            icon: SvgPicture.string(
                width: 24,
                '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-music-icon lucide-music"><path d="M9 18V5l12-2v13"/><circle cx="6" cy="18" r="3"/><circle cx="18" cy="16" r="3"/></svg>'),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.settings_suggest_outlined),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(_spacing / 2),
                width: _rows * (_radius * 2 + _spacing),
                child: Wrap(
                  spacing: _spacing,
                  runSpacing: _spacing,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    _circleButton(
                      '记录一下',
                      Colors.blue,
                      () => context.push(RecordPage()),
                    ),
                    _circleButton(
                      '做点什么',
                      Colors.green,
                      () => context.push(DoSomethingPage()),
                    ),
                    _circleButton(
                      '我',
                      Colors.teal,
                      () => context.push(MePage()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTapCancel: () => _controller.forward(),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Transform.scale(
                    scale: 0.8 + (_controller.value * 0.2),
                    child: SvgPicture.string(_iconSvg, width: 166),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(String name, Color color, VoidCallback? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        backgroundColor: color,
        maximumSize: Size.fromRadius(_radius),
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(name),
      ),
    );
  }
}
