import 'package:new_app/Features/widgets/app_strings.dart';
import 'package:new_app/core/validators/validators_widgets/app_reg_exp.dart';
import 'package:new_app/core/validators/validators_widgets/app_validator.dart';


class PasswordAppValidator extends AppValidator {
  PasswordAppValidator({super.initValue});

  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.length < 8) {
      reasons.add(AppStrings.passwordMin);
    }

    if (!AppRegExp.smallLetter.hasMatch(value)) {
      reasons.add(AppStrings.mustHaveSmall);
    }

    if (!AppRegExp.capitalLetter.hasMatch(value)) {
      reasons.add(AppStrings.mustHaveCapital);
    }

    if (!AppRegExp.specialCharacters.hasMatch(value)) {
      reasons.add(AppStrings.mustHaveSpecialCharacters);
    }

    if (!AppRegExp.numbers.hasMatch(value)) {
      reasons.add(AppStrings.mustHaveNumber);
    }

    if (AppRegExp.space.hasMatch(value)) {
      reasons.add(AppStrings.passwordHasNoSpaces);
    }

    return reasons;
  }
}