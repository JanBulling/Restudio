import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restudio_app/bloc/location_cubit.dart';
import 'package:restudio_app/bloc/new_restaurants_cubit.dart';
import 'package:restudio_app/data/services/location_service.dart';
import 'package:restudio_app/data/services/restaurant_service.dart';
import 'package:restudio_app/injection_container.dart';
import 'package:restudio_app/screens/home/explore_screen.dart';
import 'package:restudio_app/screens/home/favorites_screen.dart';
import 'package:restudio_app/screens/home/map_screen.dart';
import 'package:restudio_app/screens/home/sarch_delegate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    print("init state");
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0; //
  int _selectedPageIndex = 0;

  static List<Widget> _pages = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewRestaurantsCubit(inject.resolve<RestaurantService>())),
        BlocProvider(create: (context) => LocationCubit(inject.resolve<LocationService>())),
      ],
      child: ExploreScreen(),
    ),
    FavoritesScreen(),
    MapScreen(),
  ];

  void _changePage(int index) async {
    if (index == 1) {
      showSearch<String>(context: context, delegate: MainSearchDelegate());
    } else {
      setState(() {
        _selectedTab = index;
        _selectedPageIndex = index > 1 ? (index - 1) : index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedPageIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        //unselectedItemColor: Colors.grey[500],
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Entdecken"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Suche"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoriten"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Karte"),
        ],
        currentIndex: _selectedTab,
        onTap: (index) => _changePage(index),
      ),
    );
  }
}
