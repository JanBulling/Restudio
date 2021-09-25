import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/components/buttons/custom_text_button.dart';

class LoadingTextButton<B extends BlocBase<BlocState>> extends StatelessWidget {
  final Function(SuccessState) onSuccess;
  final Function(ErrorState) onError;
  final Function() onPressed;
  final Widget child;
  final Color? textColor;

  LoadingTextButton({
    required this.onPressed,
    required this.onSuccess,
    required this.onError,
    required this.child,
    this.textColor,
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
          return CustomTextButton(
            onPressed: () {},
            child: CircularProgressIndicator(
              color: black,
            ),
          );
        } else {
          return CustomTextButton(
            onPressed: onPressed,
            child: child,
            textColor: textColor,
          );
        }
      },
    );
  }
}
