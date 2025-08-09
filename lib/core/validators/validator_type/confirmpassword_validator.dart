import 'package:new_task/core/validators/validator_widgets/app_validator.dart';
import 'package:new_task/presentation/features/widgets/app_strings.dart';

class ConfirmPasswordAppValidator extends AppValidator {
  ConfirmPasswordAppValidator({
    super.initValue,
    required String password,
    required String confirmPassword,
  }) {
    _comparedWithPassword = password;
    setValue(confirmPassword);
  }

  String _comparedWithPassword = "";

  set comparedWithPassword(String password) {
    _comparedWithPassword = password;
    setValue(value);
  }

  @override
  List<String> check() {
    List<String> reasons = [];

    if (value != _comparedWithPassword) {
      reasons.add(AppStrings.passwordDontMatch);
    }

    return reasons;
  }
}
