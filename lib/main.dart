import 'package:flutter/material.dart';
import 'dart:math';

/// Flutter code sample for [TabBar].

void main() => runApp(const TabBarApp());

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lainez Tab Bar'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.accessible_forward_sharp),
            ),
            Tab(
              icon: Icon(Icons.airline_seat_flat),
            ),
            Tab(
              icon: Icon(Icons.assist_walker_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ImageScreen(),
          ImageScreen(),
          ImageScreen(),
        ],
      ),
    );
  }
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var randomWidth = 0;
  var randomHeight = 0;
  late String imageUrl;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setRandomSizes(MediaQuery.of(context).size.width);
  }

  void setRandomSizes(double screenWidth) {
    const freeSpace = 100;
    final size = screenWidth - freeSpace;
    randomWidth = size.floor() - freeSpace ~/ 2 + Random().nextInt(freeSpace);
    randomHeight = size.floor() - freeSpace ~/ 2 + Random().nextInt(freeSpace);

    setState(() {
      imageUrl = 'https://picsum.photos/$randomWidth/$randomHeight';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        setRandomSizes(MediaQuery.of(context).size.width);
      },
      child: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
