import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_deliverya_pp/screens/cart/cart_history.dart';
import 'package:food_deliverya_pp/screens/home/main_food__page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../account/account_page.dart';
import '../auth/sign_in_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  late PersistentTabController _controller;
/*  List pages = [
    MainFoodPage(),
    Container(child: Center(child: Text("Next Page"),),),
    CartHistory(),
    Container(child: Center(child: Text("Next Next Next Page"),),),
  ];
    void onTapNav(int index){
      setState(() {
        _selectedIndex=index;
      });
    }*/
  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
       Container(child: Center(child: Text("History Page")),),
      const CartHistory(),
      const AccountPage(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("History"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
    @override
  void initState() {
    // TODO: implement initState
     _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }}

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(icon: Icon( Icons.home_outlined),label: "Home "),
          BottomNavigationBarItem(icon: Icon( Icons.archive),label: "History "),
          BottomNavigationBarItem(icon: Icon( Icons.shopping_cart),label: "Cart "),
          BottomNavigationBarItem(icon: Icon( Icons.person),label: "Profile ")

        ],
      ),
    );
  }
}*/
