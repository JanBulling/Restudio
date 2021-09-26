import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restudio_app/bloc/auth_cubit.dart';
import 'package:restudio_app/components/loading_buttons/loading_elevated_button.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/config/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("BUILD FORGOT PASSWORD SCREEN");
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: COLOR_BLACK),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Passwort vergessen?", style: theme.textTheme.headline2),
            SizedBox(height: 5),
            Text(
              "Wir senden Ihnen eine E-Mail zum zurücksetzen Ihres Passwortes",
              style: theme.textTheme.headline6,
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(label: "E-Mail Adresse", icon: Icons.email),
                    validator: (text) {
                      if (!isValidEmail(text)) return "Keine gültige E-Mail Adresse";
                    },
                  ),
                  SizedBox(height: 20),
                  LoadingElevatedButton<AuthCubit>(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;

                        BlocProvider.of<AuthCubit>(context).resetPassword(email: email);
                      }
                    },
                    onSuccess: (state) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Email zum zurücksetzen des Passwortes an ${state.data.toString()} gesendet",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: theme.accentColor,
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
                    child: Text("PASSWORT ZURÜCKSETZEN"),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              "Die Email enthält einen Link für die Zurücksetzung des Passwortes. " +
                  "Durch den Link werden Sie auf die Webseite von Restudio weitergeleitet, wo sie ein neues " +
                  "Passwort eingeben können",
              style: theme.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
