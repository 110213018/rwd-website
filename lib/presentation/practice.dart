import 'dart:ffi';

import 'package:flutter/material.dart';
import '../routes/app_routes.dart'; // 引入路由設定

class Practice extends StatefulWidget{
  @override
  _PracticeState createState() => _PracticeState();
}

class _NavItem extends StatelessWidget {
  final String title;
  final String routeName;
  final double screenWidth;

  const _NavItem({
    required this.title,
    required this.routeName,
    required this.screenWidth,
  });

 @override
 Widget build(BuildContext context){
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Text(
        'title',
        style: TextStyle(
          color: Color(0xFFD9A299),
          fontFamily: 'Karla',
          fontSize: screenWidth / 80.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
 }
}

class _PracticeState extends State<Practice>{
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context){
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints){
        if (constraints.maxWidth >700){
          return _BuildDesktopLayout();
        }else{
          return _BuildMobileLayout();
        }
      }
    );
  }

  Widget _BuildDesktopLayout(){
    return Scaffold(
      body:Stack(
        children:[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.09,
              vertical: screenHeight * 0.04,
            ),
            width: screenWidth,
            height: screenHeight,
            color: Color(0xFFFAF7F3),
            child: Stack(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "Practice",
                      style: TextStyle(
                        color: Color(0xFFD9A299) ,
                        fontFamily: 'Karla',
                        fontSize: screenWidth / 80,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        _NavItem(title: 'About', routeName: AppRoutes.aboutScreen, screenWidth: screenWidth),
                        SizedBox(width: 30),
                        _NavItem(title: 'Buyer', routeName: AppRoutes.buyerScreen, screenWidth: screenWidth),
                        SizedBox(width: 30),
                        // _NavDropDowwn(title: 'Seller', screenWidth: screenWidth),
                        SizedBox(width: 30),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _BuildMobileLayout(){
    return Scaffold(
      appBar: AppBar(
        
      ),
    );
  }
}