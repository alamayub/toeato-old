import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: Center(
        child: Transform.scale(
          scale: .5,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}