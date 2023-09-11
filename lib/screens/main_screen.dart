import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dating/screens/home_screen.dart';
import 'package:dating/screens/location_page.dart';
import 'package:dating/screens/messaging_page.dart';
import 'package:dating/screens/profile_page.dart';
import 'package:dating/utils/colors.dart';
import 'package:dating/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List _pages = [
    const HomePage(),
    const LocationPage(),
    const MessagingPage(),
    const ProfilePage(),
  ];

  List<IconData> iconList = [
    Icons.home,
    Icons.pin_drop,
    Icons.message,
    Icons.person,
  ];

  int _bottomNavIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGrey2,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: colorGrey,
        child: const Icon(Icons.star,color: Colors.black,),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: const [Icon(Icons.notifications_none,color: Colors.white,)],
        title:  Row(children: [
          const Icon(Icons.location_on,color: Colors.white,),
          const Text("목이길어슬픈기린님의 새로운 스팟",style: txtParagraph,overflow: TextOverflow.ellipsis,),
          const Expanded(child: SizedBox()),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white54),
              borderRadius: BorderRadius.circular(15)
            ),
            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 7),
            child: const Row(children: [
            Icon(Icons.star,color: colorPink,size: 15,),
            Text("232555",style: txtParagraph,),
          ],),),
        ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        backgroundColor: Colors.black,
        inactiveColor: Colors.white,
        activeColor: colorPink,
        iconSize: 30,
        rightCornerRadius: 15,
        leftCornerRadius: 15,

      ),
      // bottomNavigationBar: AnimatedBottomNavigationBar.builder(itemCount: 4, tabBuilder: tabBuilder, activeIndex: activeIndex, onTap: onTap,),
      body: _pages[_bottomNavIndex],
    );
  }
}
