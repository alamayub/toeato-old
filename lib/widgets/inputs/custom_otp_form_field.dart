import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOTPFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const CustomOTPFormField({
    Key? key,
    required this.controller,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: TextFormField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          hintText: 'X',
          border: outlineInputBorder(Theme.of(context).colorScheme.background),
          enabledBorder: outlineInputBorder(Colors.grey.withOpacity(.05)),
          focusedBorder:
              outlineInputBorder(Theme.of(context).colorScheme.primary),
          focusedErrorBorder: outlineInputBorder(Colors.red),
          disabledBorder: outlineInputBorder(Colors.grey),
          errorBorder: outlineInputBorder(Colors.red.shade500),
        ),
      ),
    );
  }
}

outlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color.withOpacity(.5), width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(6)),
  );
}
