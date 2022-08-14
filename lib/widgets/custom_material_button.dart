import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const CustomMaterialButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 42,
      minWidth: double.infinity,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline4!
            .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
