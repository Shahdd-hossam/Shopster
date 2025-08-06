import 'package:flutter/services.dart';
import 'package:new_app/core/validators/validators_widgets/app_reg_exp.dart';

abstract class AppInputFormatters {
  static List<TextInputFormatter> numbers = [
    FilteringTextInputFormatter.allow(AppRegExp.numbers),
  ];
}