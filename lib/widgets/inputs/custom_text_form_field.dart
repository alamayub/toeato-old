import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hint;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool textCapitalize;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.iconData,
    required this.hint,
    this.validator,
    required this.textInputType,
    this.obscure = false,
    this.textCapitalize = false,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscure == true ? visible : false,
      keyboardType: widget.textInputType,
      textCapitalization: widget.textCapitalize == true
          ? TextCapitalization.words
          : TextCapitalization.none,
      decoration: InputDecoration(
        counterText: '',
        suffixIcon: widget.obscure == true
            ? GestureDetector(
                onTap: () {
                  setState(() => visible = !visible);
                },
                child: Icon(
                  !visible ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : const SizedBox(),
        prefixIcon: Icon(
          widget.iconData,
          size: 20,
        ),
        hintText: widget.hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        border: outlineInputBorder(Theme.of(context).colorScheme.background),
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
