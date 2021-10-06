import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/config/failure.dart';
import 'package:restudio_app/data/models/restaurant.dart';
import 'package:restudio_app/data/services/restaurant_service.dart';

class RestaurantsLoaded extends SuccessState {
  final List<Restaurant> restaurants;

  RestaurantsLoaded(this.restaurants);
}

class NewRestaurantsCubit extends Cubit<BlocState> {
  final RestaurantService _service;

  NewRestaurantsCubit(this._service) : super(InitialState());

  void searchRestaurant() {
    emit(LoadingState());

    final q = "zum";

    _service.searchRestaurantByName(q).then((restaurants) => emit(RestaurantsLoaded(restaurants))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }

  void getNewRestaurants() {
    emit(LoadingState());

    _service.getNewRestaurants().then((restaurants) => emit(RestaurantsLoaded(restaurants))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }
}
