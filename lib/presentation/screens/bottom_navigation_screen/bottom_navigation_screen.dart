import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:food_foresight/presentation/screens/scan_screen/scan_screen.dart';
import '../home_screen/home_screen.dart';
import '../search_screen/search_screen.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedScreen = 0;

  final List<Widget> _screens = [
    PageStorage(bucket: PageStorageBucket(), child: const HomeScreen()),
    PageStorage(bucket: PageStorageBucket(), child: const SearchScreen()),
    PageStorage(bucket: PageStorageBucket(), child: const ScanScreen()),
    PageStorage(bucket: PageStorageBucket(), child: const ProfileScreen()),
  ];

  final List<Map> item = [
    {"icon": Icons.home_outlined, 'label': 'Home'},
    {"icon": Icons.search_outlined, 'label': 'Search'},
    {"icon": Icons.scanner_outlined, 'label': 'Scan'},
    {"icon": Icons.person_2_outlined, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: _screens[_selectedScreen],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 24,
                      offset: Offset(0, 1))
                ]),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: screenWidth * .245,
                    child: GestureDetector(
                      onTap: () {
                        print("trigger");
                        setState(() {
                          _selectedScreen = i;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: i == _selectedScreen
                                  ? theme.primaryColor
                                  : null,
                              borderRadius: BorderRadius.circular(100)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item[i]['icon'],
                                color: i == _selectedScreen
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                              Text(
                                item[i]['label'],
                                style: TextStyle(
                                  color: i == _selectedScreen
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}




// Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(.1),
//                 blurRadius: 24,
//                 offset: Offset(0, -2), // Shadow position
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(100),
//             child: BottomNavigationBar(
//               backgroundColor: Colors.white,
//               // behaviour: SnakeBarBehaviour.floating,
//               // snakeShape: SnakeShape.circle,
//               // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//               // padding: const EdgeInsets.all(10),
//               // height: 60,

//               ///configuration for SnakeNavigationBar.color
//               // snakeViewColor: theme.primaryColor,

//               // selectedItemColor: Colors.white,
//               // unselectedItemColor: Colors.blueGrey,

//               ///configuration for SnakeNavigationBar.gradient
//               //snakeViewGradient: selectedGradient,
//               //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
//               //unselectedItemGradient: unselectedGradient,

//               showUnselectedLabels: false,
//               showSelectedLabels: false,
//               iconSize: 32,
//               selectedItemColor: Colors.grey,
//               unselectedItemColor: Colors.grey,

//               currentIndex: _selectedScreen,
//               onTap: (index) => setState(() => _selectedScreen = index),
//               items: [
//                 BottomNavigationBarItem(
//                     backgroundColor:
//                         _selectedScreen == 0 ? Colors.amber : Colors.white,
//                     icon: Icon(Icons.home),
//                     label: "Home"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.search), label: "Search"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.barcode_reader), label: "Scan"),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person), label: "Profile")
//               ],
//             ),
//           ),
//         ),
//       ),