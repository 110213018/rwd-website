import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import ???;

// class HomeScreen extends StatelessWidget {
class BuyerScreen extends StatefulWidget {
  @override
  _BuyerScreenState createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> with TickerProviderStateMixin{
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Buyer Screen!'),
      ),
    );
  }
}