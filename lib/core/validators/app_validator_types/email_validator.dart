import 'package:new_app/common/app_strings.dart';
import 'package:new_app/core/validators/app_reg_exp.dart';
import 'package:new_app/core/validators/app_validator.dart';

class EmailAppValidator extends AppValidator {
  EmailAppValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [];

    if (value.isEmpty) {
      reasons.add(AppStrings.emailIsValid);
    }
    if (!AppRegExp.email.hasMatch(value)) {
      reasons.add(AppStrings.emailNotValid);
    }
    return reasons;
  }
}