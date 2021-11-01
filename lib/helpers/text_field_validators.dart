class Validator {
  static bool isValidEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email))
      return true;
    else
      return false;
  }

  static bool isValidPhoneNumber(String number) {
    if (number.length < 7) return false;
    if (int.tryParse(number) == null) return false;
    return true;
  }
}
