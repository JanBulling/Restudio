import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/config/failure.dart';
import 'package:restudio_app/data/models/location.dart';
import 'package:restudio_app/data/services/location_service.dart';

class LocationLoaded extends SuccessState {
  final Location location;

  LocationLoaded({required this.location}) : super(location);
}

class LocationCubit extends Cubit<BlocState> {
  final LocationService _service;

  LocationCubit(this._service) : super(InitialState());

  void searchZipCode(String zip) {
    emit(LoadingState());

    _service.getLocation(zip).then((location) => emit(LocationLoaded(location: location))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }

  void safeLocaly(Location location) {
    _service.safeLocaly(location);
  }

  Location getFromLocal() {
    return _service.getFromLocal();
  }
}
