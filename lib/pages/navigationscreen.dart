import 'package:flutter/material.dart';
import 'home_page.dart';

class NavigationsScreen extends StatefulWidget {
  const NavigationsScreen ({super.key});

  @override
  State<NavigationsScreen > createState() => _NavigationsScreenState();
}
int _currentIndex = 0;
class _NavigationsScreenState extends State<NavigationsScreen> {
  late PageController pageController;
  @override
  void initState(){
    super.initState();
    pageController = PageController();

  }@override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  onPageChanged(int page){
    setState(() {
      _currentIndex=page;
    });
  }
  navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,

                currentIndex: _currentIndex,
                onTap: navigationTapped,
                items: const[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: '',
                  ),
                ]

            )

        ),
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          children: [
            HomePage()

          ],
        )
    );
  }
}