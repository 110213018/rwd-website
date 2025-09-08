import 'package:flutter/material.dart';
import 'routes/app_routes.dart'; // 引入路由設定

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'online_ording_system',
      // 隱藏除錯模式的標籤
      debugShowCheckedModeBanner: false,
      // 預設首頁網址 (要去哪 /home_screen)
      initialRoute: AppRoutes.homeScreen,
      // 指定路由表 (怎麼走到那 '/home_screen': (context) =>  HomeScreen())
      routes: AppRoutes.routes,
    );
  }
}

/*
	1. 引入 ui 包跟路由設定檔案。
	2. 使用 MaterialApp 包裝應用程式，並設定標題、初始路由、路由表等。
	-----
	
	initialRoute: AppRoutes.homeScreen,
  routes: AppRoutes.routes,
  
  ↓ ↓ 跟以下一樣 ↓ ↓

  initialRoute: '/home_screen',   // 告訴 app：啟動時去 "/home"
  routes: {
    '/home_screen': (context) => HomeScreen(),    // 告訴 app："/home" 是這個畫面
    '/abbout_screen': (context) => AboutScreen(),
    ...
  },
	
 */