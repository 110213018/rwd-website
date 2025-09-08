import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import ???;

// class HomeScreen extends StatelessWidget {
class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin{
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('About Screen'),
      ),
      body: Center(
        child: Text('Welcome to the About Screen!'),
      ),
    );
  }
}