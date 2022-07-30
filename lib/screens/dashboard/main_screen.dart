import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:kalorieda/models/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../../components/theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: ((context, value, child) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
          ),
          body: value.screen[value.currentTab],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DotNavigationBar(
              backgroundColor: createMaterialColor(const Color(0xff27A52F)),
              margin: const EdgeInsets.only(left: 10, right: 10),
              currentIndex: value.currentTab,
              selectedItemColor: Colors.white,
              dotIndicatorColor: Colors.black,
              unselectedItemColor: Colors.grey[300],
              onTap: (int idx) {
                value.currentTab = idx;
              },
              items: [
                /// Home
                DotNavigationBarItem(
                  icon: const Icon(Icons.home),
                  selectedColor: Colors.black,
                ),

                /// Search
                DotNavigationBarItem(
                  icon: const Icon(Icons.search),
                  selectedColor: Colors.black,
                ),

                /// Profile
                DotNavigationBarItem(
                  icon: const Icon(Icons.person),
                  selectedColor: Colors.black,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
