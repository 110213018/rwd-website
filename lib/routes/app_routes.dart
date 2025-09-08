import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/about_screen/about_screen.dart';
import '../presentation/buyer_screen/buyer_screen.dart';
import '../presentation/order_screen/order_screen.dart';
import '../presentation/menu_screen/menu_screen.dart';

class AppRoutes {
  // 定義路由(網址)名稱
  static const String homeScreen = '/home_screen';
  static const String aboutScreen = '/about_screen';
  static const String buyerScreen = '/buyer_screen';
  static const String orderScreen = '/order_screen';
  static const String menuScreen = '/menu_screen';

  // 路由(網址)對應的畫面
  static final Map<String, WidgetBuilder> routes = {
    homeScreen: (context) =>  HomeScreen(), // '/home_screen': (context) =>  HomeScreen()
    aboutScreen: (context) =>  AboutScreen(),
    buyerScreen: (context) =>  BuyerScreen(),
    orderScreen: (context) =>  OrderScreen(),
    menuScreen: (context) =>  MenuScreen(),
  };
}