class Validator {
  static String? validateEmail(String email) {
    if (RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email))
      return null;
    else
      return "please enter a valid email";
  }

  static String? validatePhoneNumber(String number) {
    if (number.length < 8) return "please enter a valid phone number";
    if (int.tryParse(number) == null)
      return "please enter a valid phone number";
    return null;
  }
}
