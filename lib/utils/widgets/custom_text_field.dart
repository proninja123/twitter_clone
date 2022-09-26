import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Color? borderColor;
  final String? labelText;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final Widget icon;
  final String? initialValue;
  final TextEditingController? controller;
  final VoidCallback? onTab;
  final Function(String)? onFilledSubmitted;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.hintText,
    this.borderColor,
    this.labelText,
    this.textInputAction,
    this.readOnly,
    this.textInputType,
    this.onChanged,
    required this.icon,
    this.initialValue,
    this.controller,
    this.onTab,
    this.onFilledSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: onFilledSubmitted,
        onTap: onTab,
        controller: controller,
        onChanged: onChanged ?? (value) {},
        keyboardType: textInputType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.none,
        decoration: InputDecoration(
          suffixIcon: icon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText ?? "",
          labelText: labelText ?? "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.7),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.5),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
