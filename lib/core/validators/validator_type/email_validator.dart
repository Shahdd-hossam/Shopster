import 'package:new_task/core/validators/validator_widgets/app_reg_ex.dart';
import 'package:new_task/core/validators/validator_widgets/app_validator.dart';
import 'package:new_task/presentation/features/widgets/app_strings.dart';

class EmailAppValidator extends AppValidator {
  EmailAppValidator({super.initValue});
  @override
  List<String> check() {
    List<String> reasons = [
    ];

    if (value.isEmpty) {
      reasons.add(AppStrings.emailIsValid);
    }
    if (!AppRegExp.email.hasMatch(value)) {
      reasons.add(AppStrings.emailNotValid);
    }
    return reasons;
  }
}