import 'package:flutter/material.dart';

class AuthText extends StatelessWidget {
  final String text1;
  final Function() function;
  final String text2;

  const AuthText({
    Key? key,
    required this.text1,
    required this.function,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$text1 '),
        GestureDetector(
          onTap: function,
          child: Text(
            text2,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
          ),
        )
      ],
    );
  }
}
