import '../validator_widgets/app_validator.dart';

class UsernameAppValidator extends AppValidator {
  @override
  List<String> check() {
    List<String> errors = [];
    
    if (value.isEmpty) {
      errors.add('Username is required');
    } else if (value.length < 3) {
      errors.add('Username must be at least 3 characters');
    } else if (value.length > 20) {
      errors.add('Username must not exceed 20 characters');
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      errors.add('Username can only contain letters, numbers, and underscores');
    }
    
    return errors;
  }
}
