import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import ???;

// class HomeScreen extends StatelessWidget {
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin{
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Menu Screen!'),
      ),
    );
  }
}