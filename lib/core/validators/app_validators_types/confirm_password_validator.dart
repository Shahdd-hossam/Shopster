import 'package:new_app/Features/widgets/app_strings.dart';
import 'package:new_app/core/validators/validators_widgets/app_validator.dart';

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


