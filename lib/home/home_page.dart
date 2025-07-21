import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _source = AssetSource('audio/1.mp3');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('木鱼'),
        centerTitle: false,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.menu))],
      ),
      body: Center(
        child: GestureDetector(
          child: Image.asset('assets/img/1.webp'),
          onTap: () => AudioPlayer().play(_source, mode: PlayerMode.lowLatency),
        ),
      ),
    );
  }
}
