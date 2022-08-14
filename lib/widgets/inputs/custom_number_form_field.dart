import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helper/extension/validator.dart';

class CustomNumberFormField extends StatelessWidget {
  final TextEditingController controller;

  const CustomNumberFormField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (val) => val?.isValidPhone(val),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: const Icon(
          Icons.phone,
          size: 20,
        ),
        hintText: '98XXXXXXXX',
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        border: outlineInputBorder(
          Theme.of(context).colorScheme.background,
        ),
        enabledBorder: outlineInputBorder(Colors.grey.withOpacity(.05)),
        focusedBorder:
            outlineInputBorder(Theme.of(context).colorScheme.primary),
        focusedErrorBorder: outlineInputBorder(Colors.red),
        disabledBorder: outlineInputBorder(Colors.grey),
        errorBorder: outlineInputBorder(Colors.red.shade500),
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
