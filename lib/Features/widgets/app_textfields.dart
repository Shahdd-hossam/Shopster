import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_app/core/validators/validators_widgets/app_validator.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.onChange,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.keyboardType,
    this.isReadOnly,
    this.obscureText,
    this.width,
    this.height,
    this.validator,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final Function(String)? onChange;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool? isReadOnly;
  final bool? obscureText;
  final double? width;
  final double? height;
  final AppValidator? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height ?? 50,
          width: width ?? double.infinity,
          child: TextFormField(
            controller: controller,
            onChanged: onChange,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              hintStyle: theme.inputDecorationTheme.hintStyle,
            ),
            style: style ?? TextStyle(fontSize: 14, color: theme.textTheme.bodyLarge!.color),
            keyboardType: keyboardType ?? TextInputType.text,
            readOnly: isReadOnly ?? false,
            obscureText: obscureText ?? false,
          ),
        ),
        if (validator != null) getValidationHints(),
      ],
    );
  }

  Widget getValidationHints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...validator!.reasons.map(
          (e) => Column(
            children: [
              const SizedBox(height: 5),
              Text(e, style: const TextStyle(color: Colors.red, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
