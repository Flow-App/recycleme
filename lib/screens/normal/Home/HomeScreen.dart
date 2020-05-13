import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/screens/normal/Home/account_tab.dart';
import 'package:recycleme/screens/normal/Home/collect_tab.dart';
import 'package:recycleme/screens/normal/Home/deal_tab.dart';
import 'package:recycleme/screens/normal/Home/deals_tabs/deals_tab%20.dart';
import 'package:recycleme/screens/normal/Home/news_tab.dart';
import 'package:recycleme/screens/normal/Home/rantings_tab.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity user;

  HomeScreen(this.user);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  UserEntity currentUser;
  Widget collectTab;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    collectTab = CollectTab();
    currentUser = widget.user;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            AccountTab(currentUser),
            RatingsTab(currentUser),
            collectTab,
            DealsMainTab(),
            NewsTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xFFFaFaFa),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(FontAwesomeIcons.userAlt),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF6ac370),
              inactiveColor: Color(0xFF767676)),
          BottomNavyBarItem(
              title: Text('Rating'),
              icon: Icon(FontAwesomeIcons.chartBar),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF6ac370),
              inactiveColor: Color(0xFF767676)),
          BottomNavyBarItem(
              title: Text('Collect'),
              icon: Icon(FontAwesomeIcons.sync),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF6ac370),
              inactiveColor: Color(0xFF767676)),
          BottomNavyBarItem(
              title: Text('Deals'),
              icon: Icon(FontAwesomeIcons.check),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF6ac370),
              inactiveColor: Color(0xFF767676)),
          BottomNavyBarItem(
              title: Text('News'),
              icon: Icon(FontAwesomeIcons.newspaper),
              textAlign: TextAlign.center,
              activeColor: Color(0xFF6ac370),
              inactiveColor: Color(0xFF767676)),
        ],
      ),
    );
  }
}
