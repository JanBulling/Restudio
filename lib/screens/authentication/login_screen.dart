import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restudio_app/bloc/auth_cubit.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/config/validators.dart';
import 'package:restudio_app/components/loading_buttons/loading_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("BUILD LOGIN SCREEN");
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Anmelden"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Willkommen zurück!", style: theme.textTheme.headline2),
            SizedBox(height: 5),
            Text("Bitte anmelden um fortzufahren", style: theme.textTheme.headline3),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: inputDecoration(label: "Passwort", icon: Icons.lock),
                    validator: (text) {
                      if (!isValidPassword(text)) return "Passwort muss mindestens 6 Zeichen lang sein";
                    },
                  ),
                  SizedBox(height: 20),
                  LoadingElevatedButton<AuthCubit>(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        BlocProvider.of<AuthCubit>(context).loginUser(email, password);
                      }
                    },
                    onSuccess: (state) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Logged in", style: TextStyle(color: Colors.white)),
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
                    child: Text("ANMELDEN"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
