import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restudio_app/bloc/location_cubit.dart';
import 'package:restudio_app/bloc/new_restaurants_cubit.dart';
import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/components/buttons/custom_elevated_button.dart';
import 'package:restudio_app/config/router.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/data/models/location.dart';
import 'package:restudio_app/screens/home/components/explore_header_page_view.dart';
import 'package:restudio_app/screens/home/sarch_delegate.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    print("BUILD EXPLORE SCREEN");
    ThemeData theme = Theme.of(context);

    final Location location = BlocProvider.of<LocationCubit>(context).getFromLocal();

    return Scaffold(
      appBar: AppBar(
        title: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, ROUTE_CHANGE_LOCATION).whenComplete(() => setState(() {}));
          },
          icon: Icon(Icons.gps_fixed, color: Colors.white),
          label: Text(location.city, style: theme.textTheme.bodyText1!.copyWith(color: Colors.white)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MainSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(PADDING),
              child: InkWell(
                onTap: () {
                  showSearch(context: context, delegate: MainSearchDelegate());
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: COLOR_GREY_DARKER),
                      SizedBox(width: 10),
                      Text("Suche Restaurant", style: theme.textTheme.bodyText1),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: PADDING / 2),
              child: Text("Entdecken", style: theme.textTheme.headline4),
            ),
            SizedBox(height: 5),
            ExploreHeaderPageView(),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Kategorien", style: theme.textTheme.headline4),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Mehr", style: theme.textTheme.headline5!.copyWith(color: theme.primaryColor)),
                  ),
                ),
              ],
            ),
            NewRestaurantsTest(),
            SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<NewRestaurantsCubit>(context).searchRestaurant();
              },
              child: Text("Add Restaurant"),
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              onPressed: () {
                BlocProvider.of<NewRestaurantsCubit>(context).getNewRestaurants();
              },
              child: Text("Get Restaurants"),
            ),
          ],
        ),
      ),
    );
  }
}

class NewRestaurantsTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRestaurantsCubit, BlocState>(builder: (context, state) {
      if (state is LoadingState) {
        return CircularProgressIndicator();
      } else if (state is RestaurantsLoaded) {
        final restaurants = state.restaurants;
        String names = "";

        restaurants.forEach((element) {
          names += element.name + ", ";
        });

        return Text("SUCCESS: $names");
      } else {
        return Text("INITIAL OR ERROR");
      }
    });
  }
}
