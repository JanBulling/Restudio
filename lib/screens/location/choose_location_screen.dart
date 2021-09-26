import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restudio_app/bloc/location_cubit.dart';
import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/components/buttons/custom_elevated_button.dart';
import 'package:restudio_app/config/router.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/config/validators.dart';

class ChooseLocationScreen extends StatefulWidget {
  @override
  _ChooseLocationScreenState createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Standort wählen", style: theme.textTheme.headline2),
              SizedBox(height: 5),
              Text(
                "Bitte Postleitzahl eingeben",
                style: theme.textTheme.headline3!.copyWith(color: COLOR_GREY),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _zipController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Postleitzahl",
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderSide: BorderSide.none),
                              labelStyle: TextStyle(color: COLOR_GREY_DARKER),
                              prefixIcon: Icon(Icons.location_on, color: COLOR_GREY_DARKER),
                            ),
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (_) => searchZip(),
                            validator: (text) {
                              if (!isValidZipCode(text)) return "Keine gültige Postleitzahl";
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            onPressed: () => searchZip(),
                            icon: Icon(Icons.search, color: COLOR_GREY_DARKER),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              BlocConsumer<LocationCubit, BlocState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message, style: TextStyle(color: Colors.white)),
                        backgroundColor: theme.errorColor,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LocationLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ausgewählter Standort:", style: theme.textTheme.headline4),
                        SizedBox(height: 5),
                        Text("${state.location.zip} ${state.location.city}"),
                        Text("${state.location.district} ${state.location.state}"),
                        SizedBox(height: 30),
                        CustomElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LocationCubit>(context).safeLocaly(state.location);

                            Navigator.pushReplacementNamed(context, ROUTE_HOME);
                          },
                          child: Text("DIESEN STANDORT WÄHLEN"),
                        ),
                      ],
                    );
                  } else if (state is LoadingState) {
                    return CustomElevatedButton(
                      onPressed: () {},
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return CustomElevatedButton(
                      onPressed: () {},
                      child: Text("STANDORT WÄHLEN"),
                      color: COLOR_GREY,
                    );
                  }
                },
              ),
              Spacer(),
              Text(
                "Restdio benötigt Ihren ungefähren Standort, um Restaurants in Ihrer Umgebung anzuzeigen.",
                style: theme.textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchZip() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final zip = _zipController.text;

      BlocProvider.of<LocationCubit>(context).searchZipCode(zip);
    }
  }

  @override
  void dispose() {
    _zipController.dispose();
    super.dispose();
  }
}
