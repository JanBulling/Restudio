import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/components/buttons/custom_elevated_button.dart';

class LoadingElevatedButton<B extends BlocBase<BlocState>> extends StatelessWidget {
  final Function(SuccessState) onSuccess;
  final Function(ErrorState) onError;
  final Function() onPressed;
  final Widget child;
  final Color? color;

  LoadingElevatedButton({
    required this.onPressed,
    required this.onSuccess,
    required this.onError,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, BlocState>(
      listener: (context, state) {
        if (state is SuccessState) {
          onSuccess(state);
        }
        if (state is ErrorState) {
          onError(state);
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return CustomElevatedButton(
            onPressed: () {},
            child: CircularProgressIndicator(color: Colors.white),
          );
        } else {
          return CustomElevatedButton(
            onPressed: onPressed,
            child: child,
            color: color,
          );
        }
      },
    );
  }
}
