class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return '🚩 Please enter a valid email address.';
    else
      return null;
  }

  static String? validateDropDefaultData(value) {
    if (value == null)
      return 'Please select an item.';
    else
      return null;
  }

  static String? validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return '🚩 Password must be at least 6 characters.';
    else
      return null;
  }

  static String? validateName(String value) {
    // Pattern pattern = r'^.{2,}$';
    // RegExp regex = new RegExp(pattern);
    if (value.length < 3)
      return '🚩 Username is too short.';
    else
      return null;
  }

  static String? validateText(String value) {
    // Pattern pattern = r'^.{2,}$';
    // RegExp regex = new RegExp(pattern);
    if (value.length < 1)
      return '🚩 Text is too short.';
    else
      return null;
  }



  static String? validatePhoneNumber(String value) {
    // Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    // RegExp regex = new RegExp(pattern);

    // if (!regex.hasMatch(value))
    //   return 'Please enter a number.';
    // else
    //   return null;
    if (value.length != 11)
      return '🚩 Phone number is not valid.';
    else
      return null;
  }

}
