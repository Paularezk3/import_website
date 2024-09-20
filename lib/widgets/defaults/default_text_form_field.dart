import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final bool? obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final InputDecoration? decoration;
  final double? height;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final Color? color;

  const DefaultTextFormField(
      {super.key,
      this.controller,
      this.labelText,
      this.hintText,
      this.initialValue,
      this.obscureText = false,
      this.enabled = true,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.maxLines = 1,
      this.minLines,
      this.maxLength,
      this.textCapitalization = TextCapitalization.none,
      this.decoration,
      this.height,
      this.validator,
      this.onChanged,
      this.onTap,
      this.focusNode,
      this.color});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = decoration ??
        InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle:
              TextStyle(color: color ?? AppColors.blackAndWhiteColor(context)),
          labelStyle:
              TextStyle(color: color ?? AppColors.blackAndWhiteColor(context)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                  color: color ?? AppColors.blackAndWhiteColor(context))),
        );

    return SizedBox(
      height: height, // Apply custom height if provided
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        obscureText: obscureText ?? false,
        enabled: enabled,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        textCapitalization: textCapitalization,
        decoration: inputDecoration,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
      ),
    );
  }
}
