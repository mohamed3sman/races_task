import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesk/features/races_view/races_view.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List _pages = [];
  int _selectedPageIndex = 2;

  @override
  void initState() {
    _pages = [
      Container(),
      Container(),
      const RacesView(),
      Container(),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        //   height: kBottomNavigationBarHeight * 1.4,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),

        //  clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: _selectPage,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 80,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.grey,
          currentIndex: _selectedPageIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/train_icon.svg'),
              label: 'Train',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/Chart Line.svg'),
              label: 'Line',
            ),
          ],
        ),
      ),
      body: _pages[_selectedPageIndex],
    );
  }
}
