import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_cubit.dart';
import '../../components/loading_buttons/loading_elevated_button.dart';
import '../../config/theme.dart';
import '../../config/validators.dart';
import '../../config/router.dart';
import './components/privacy_policy.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("BUILD SIGNUP SCREEN");
    ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Account erstellen"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Herzlich willkommen", style: theme.textTheme.headline2),
            SizedBox(height: 5),
            Text(
              "Erstellen Sie einen Account!",
              style: theme.textTheme.headline3!.copyWith(color: Colors.grey.shade500),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: inputDecoration(label: "Vorname & Nachname", icon: Icons.email),
                    validator: (text) {
                      if (!isValidName(text)) return "Bitte geben Sie Ihren Namen an";
                    },
                  ),
                  SizedBox(height: 10),
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
                        final name = _nameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        BlocProvider.of<AuthCubit>(context).signUpUser(email: email, password: password, name: name);
                      }
                    },
                    onSuccess: (state) {
                      Navigator.pushNamedAndRemoveUntil(context, ROUTE_CHOOSE_LOCATION, (route) => false);
                    },
                    onError: (state) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message, style: TextStyle(color: Colors.white)),
                          backgroundColor: theme.errorColor,
                        ),
                      );
                    },
                    child: Text("ACCOUNT ERSTELLEN"),
                  ),
                ],
              ),
            ),
            Spacer(),
            PrivacyPolicy(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
