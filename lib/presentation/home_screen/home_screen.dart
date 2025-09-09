import 'package:flutter/material.dart';
import '../../routes/app_routes.dart'; // 引入路由設定
import 'dart:ui'; // imageFilter 需要這個包

                                                         // HomeScreen 的狀態由 _HomeScreenState 管理
class HomeScreen extends StatefulWidget {                // StatefulWidget: 畫面可以根據使用者或資料互動而重新渲染。
  @override                                              // 用來保證你真的在覆寫一個存在的方法（不是打錯字或錯誤方法名稱）
  _HomeScreenState createState() => _HomeScreenState();  // HomeScreen 的狀態是由 _HomeScreenState 控制
}

// 導覽列一般按鈕
class _NavItem extends StatelessWidget {
  final String title;
  final String routeName; // 新增要導航的路由名稱
  final double screenWidth; // 新增螢幕寬度參數

  const _NavItem({
    required this.title,
    required this.routeName,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: 導航功能
        Navigator.pushNamed(context, routeName);
      },
      child: Text(
        title,
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

class _NavDropdown extends StatefulWidget {
  final String title;
  final double screenWidth;

  const _NavDropdown({
    required this.title,
    required this.screenWidth,
    Key? key,
  }) : super(key: key);

  @override
  State<_NavDropdown> createState() => _NavDropdownState();
}

class _NavDropdownState extends State<_NavDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isHovering = false; // 滑鼠是否在按鈕或選單內

  void toggleDropdown() {
    if (_overlayEntry == null) {
      _showDropdown();
    } else {
      _hideDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    final fontSizeSmall = widget.screenWidth / 60;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx -8,
        top: offset.dy + size.height+8,
        // 不設定 width，改用 IntrinsicWidth 包裝
        child: MouseRegion(
          onEnter: (_) => _onHoverChange(true),
          onExit: (_) => _onHoverChange(false),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFFAF7F3),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, // 靠左對齊
                children: [
                  _buildDropdownItem(context, 'Order', AppRoutes.orderScreen, fontSizeSmall),
                  _buildDropdownItem(context, 'Menu', AppRoutes.menuScreen, fontSizeSmall),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onHoverChange(bool hovering) {
    _isHovering = hovering;
    if (!hovering) {
      // 滑鼠離開選單區域，延遲檢查是否還在按鈕上
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!_isHovering) {
          // 確認滑鼠不在按鈕和選單上才收起
          _hideDropdown();
          setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeTitle = widget.screenWidth / 80;

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => _onHoverChange(true),
        onExit: (_) => _onHoverChange(false),
        child: InkWell(
          onTap: toggleDropdown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: const Color(0xFFD9A299),
                  fontFamily: 'Karla',
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/images/arrow_down.png',
                width: 10,
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(BuildContext context, String text, String routeName, double fontSize) {
    return InkWell(
      onTap: () {
        _hideDropdown();
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFFD9A299),
            fontFamily: 'Karla',
            fontWeight: FontWeight.w400,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}


class HoverButton extends StatefulWidget {
  final String text;
  final Color hoverBg;
  final Color normalBg;
  final Color hoverText;
  final Color normalText;
  final Color borderColor;
  final VoidCallback onPressed;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;

  const HoverButton({
    super.key,
    required this.text,
    required this.hoverBg,
    required this.normalBg,
    required this.hoverText,
    required this.normalText,
    required this.borderColor,
    required this.onPressed,
    required this.fontSize,
    required this.horizontalPadding,
    required this.verticalPadding,
  });
  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isHovering ? widget.hoverBg : widget.normalBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70),
          side: BorderSide(
            color: widget.borderColor,
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
      ),
      onHover: (value) => setState(() => isHovering = value),
      child: Text(
        widget.text,
        style: TextStyle(
          color: isHovering ? widget.hoverText : widget.normalText,
          fontFamily: 'Karla',
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen>{        // _ 代表「這個類別是私有的（private）」，只能在這個檔案中使用；State<HomeScreen> 表示這個狀態綁定在 HomeScreen 上
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  // double? lastWidth;
  bool showDesktop = true;
  bool isHovering = false; // 用來判斷是否滑鼠懸停在按鈕上
  // bool _hasPoppedOnResize = false;

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();

//   final currentWidth = MediaQuery.of(context).size.width;

//   if (!_hasPoppedOnResize &&
//     lastWidth != null && lastWidth! >= 700 && currentWidth < 700) {
//       _hasPoppedOnResize = true;
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted && Navigator.of(context).canPop()) {
//           Navigator.of(context).pop();
//           print("關閉彈出視窗成功!");
//         }
//       });
//     }

//     // 當寬度回到大於700時，重置旗標
//     if (currentWidth >= 700) {
//       _hasPoppedOnResize = false;
//     }

//     lastWidth = currentWidth;
//   }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    print('螢幕寬度為: $screenWidth');

    return LayoutBuilder(                 // 判斷目前裝置畫面大小 (響應式 ui)
      builder: (context, constraints) {   // constraints: 現在可用的空間
                                          // 根據螢幕寬度決定使用哪種 UI 佈局
        if (constraints.maxWidth > 700) {
          return _buildDesktopLayout();   // 電腦版：橫向導覽列
        } else {
          // Navigator.of(context).pop(); // 關閉彈窗
          // print("轉成行動視窗");
          return _buildMobileLayout();    // 手機/平板版：AppBar + Drawer
        }
      },
    );
  }

    // 桌機版 UI
  Widget _buildDesktopLayout() {
    return Scaffold(  // Scaffold: 提供基本的視覺結構——把畫面骨架先搭起來，其他內容再自己補上去 (appBar, body, drawer, bottomNavigationBar 等)
    backgroundColor: const Color(0xFFFAF7F3), // 與 Container 相同
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(screenWidth / 4),
            left: 30,
            child: Image.asset(
              'assets/images/ellipse_light.png',
              width: screenWidth * 0.6,
              // height: screenHeight * 0.6, // 因為這個，畫面上下縮放的時候，會出現白帶
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -(screenWidth / 5),
            right: -200,
            child: Image.asset(
              'assets/images/ellipse_dark.png',
              width: screenWidth * 0.6,
              // height: screenHeight * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding:EdgeInsets.symmetric(  // 邊緣內距.對稱(上下、左右)
                horizontal: screenWidth * 0.09,
                vertical: screenHeight * 0.04
              ),
              width: double.infinity, // 讓寬度自動填滿螢幕
              // height: screenHeight,
              // color: Color(0xFFFAF7F3), // 因為 Scaffold 已經有背景色了，所以這裡不需要再設定
              child: Column(
                children: [
                  Row(
                    // 自動分開靠邊
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 左側：選單項目
                      Text(
                        'Practice',
                        style: TextStyle(
                          color: Color(0xFFD9A299),
                          fontFamily: 'Karla',
                          fontSize: screenWidth / 80,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      // 右側：選單項目
                      Row(
                        children: [
                          _NavItem(title: 'About', routeName: AppRoutes.aboutScreen, screenWidth: screenWidth),
                          SizedBox(width: 30),
                          _NavItem(title: 'Buyer', routeName: AppRoutes.buyerScreen, screenWidth: screenWidth),
                          SizedBox(width: 30),
                          _NavDropdown(title: 'Seller', screenWidth: screenWidth),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40), // 上方間距
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 文字與圖片垂直置中
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 兩側對齊
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 文字靠左對齊
                        children: [
                          Text(
                            'An Easy-To-Use \nRWD Website\nFor Practicing',
                            style: TextStyle(
                              fontFamily: 'Karla',
                              fontSize: screenWidth / 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFD9A299),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'When zooming in or out,\nor resizing the screen in any direction,\nthe website functions smoothly without errors\nand responds to different screen sizes with adaptive layout designs.',
                            style: TextStyle(
                              fontFamily: 'Karla',
                              fontSize: screenWidth / 80,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFD9A299),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: [
                              HoverButton(
                                text: 'VIEW ON GITHUB',
                                hoverBg: const Color(0xFFB58B6B),
                                normalBg: Colors.transparent,
                                hoverText: Colors.white,
                                normalText: const Color(0xFFB58B6B),
                                borderColor: const Color(0xFFB58B6B),
                                onPressed: () {},
                                fontSize: screenWidth / 80,
                                horizontalPadding: screenWidth * 0.03,
                                verticalPadding: screenHeight * 0.03,
                              ),
                              const SizedBox(width: 20),
                              HoverButton(
                                text: 'VIEW ON YOUTUBE',
                                hoverBg: const Color(0xFFAFC4D9),
                                normalBg: Colors.transparent,
                                hoverText: Colors.white,
                                normalText: const Color(0xFFAFC4D9),
                                borderColor: const Color(0xFFAFC4D9),
                                onPressed: () {},
                                fontSize: screenWidth / 80,
                                horizontalPadding: screenWidth * 0.03,
                                verticalPadding: screenHeight * 0.03,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.3,
                          ),
                          child: Image.asset(
                            'assets/images/rwd.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40), // 下方間距
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // 手機/平板版 UI
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practice',
          style: TextStyle(
            fontFamily: 'Karla',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFFD9A299)
          ),
        ),
        backgroundColor: const Color(0xFFFAF7F3),
        iconTheme: const IconThemeData(color: Color(0xFFD9A299)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFD9A299)),
              child: Text(
                '選單',
                style: TextStyle(
                  color: Colors.white)
                ),
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.aboutScreen);
              },
            ),
            ListTile(
              title: const Text('Buyer'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.buyerScreen);
              },
            ),
            ExpansionTile(
              title: const Text('Seller'),
              children: [
                ListTile(
                  title: const Text('Order'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.orderScreen);
                  },
                ),
                ListTile(
                  title: const Text('Menu'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.menuScreen);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFAF7F3),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: screenWidth/50,
              left: -150,
              child: Image.asset(
                'assets/images/ellipse_light.png',
                width: screenWidth,
                // height: screenHeight * 0.6, // 因為這個，畫面上下縮放的時候，會出現白帶
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: -(screenWidth/8),
              right: -200,
              child: Image.asset(
                'assets/images/ellipse_dark.png',
                width: screenWidth,
                // height: screenHeight * 0.6,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // 兩側對齊
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //中間對齊
                      children: [
                        Text(
                          'An Easy-To-Use \nRWD Website\nFor Practicing',
                          style: TextStyle(
                            fontFamily: 'Karla',
                            fontSize: screenWidth / 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFD9A299),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //中間對齊
                      children: [
                        Text(
                          'When zooming in or out,\nor resizing the screen in any direction,\nthe website functions smoothly without errors\nand responds to different screen sizes with adaptive layout designs.',
                          style: TextStyle(
                            fontFamily: 'Karla',
                            fontSize: screenWidth / 40,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFD9A299),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // 文字靠左對齊
                          children: [
                            HoverButton(
                              text: ' VIEW ON GITHUB ',
                              hoverBg: const Color(0xFFB58B6B),
                              normalBg: Colors.transparent,
                              hoverText: Colors.white,
                              normalText: const Color(0xFFB58B6B),
                              borderColor: const Color(0xFFB58B6B),
                              onPressed: () {},
                              fontSize: screenWidth / 40,
                              horizontalPadding: screenWidth * 0.03,
                              verticalPadding: screenHeight * 0.03,
                            ),
                            SizedBox(height: 50),
                            HoverButton(
                              text: 'VIEW ON YOUTUBE',
                              hoverBg: const Color(0xFFAFC4D9),
                              normalBg: Colors.transparent,
                              hoverText: Colors.white,
                              normalText: const Color(0xFFAFC4D9),
                              borderColor: const Color(0xFFAFC4D9),
                              onPressed: () {},
                              fontSize: screenWidth / 40,
                              horizontalPadding: screenWidth * 0.03,
                              verticalPadding: screenHeight * 0.03,
                            ),
                          ],
                        ),
                        SizedBox(width: 50),
                        Flexible(
                        // fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenWidth * 0.45,
                          ),
                          child: Image.asset(
                            'assets/images/rwd.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}