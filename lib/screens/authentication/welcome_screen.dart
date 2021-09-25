import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_cubit.dart';
import '../../config/theme.dart';
import '../../components/buttons/custom_elevated_button.dart';
import '../../components/buttons/custom_outlined_button.dart';
import '../../components/loading_buttons/loading_text_button.dart';
import 'components/privacy_policy.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // hide the keyboard
    FocusScope.of(context).unfocus();
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Container(
                width: 200,
                height: 80,
                decoration: BoxDecoration(color: theme.primaryColor),
                child: Center(
                    child: Text(
                  "LOGO",
                  style: theme.textTheme.headline3!.copyWith(color: Colors.white),
                )),
              ),
              SizedBox(height: 40),
              Text(
                "Essen gehen\nleicht gemacht!",
                style: theme.textTheme.headline1,
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: () {},
                child: Text("ACCOUNT ERSTELLEN"),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                onPressed: () {},
                child: Text("ANMELDEN"),
              ),
              SizedBox(height: 20),
              LoadingTextButton<AuthCubit>(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signInAnonymously();
                },
                onSuccess: (state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Logged in anonymously", style: TextStyle(color: Colors.white)),
                      backgroundColor: theme.errorColor,
                    ),
                  );
                },
                onError: (state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message, style: TextStyle(color: Colors.white)),
                      backgroundColor: theme.errorColor,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Weiter ohne Anmeldung"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              Spacer(),
              PrivacyPolicy(),
            ],
          ),
        ),
      ),
    );
  }
}
