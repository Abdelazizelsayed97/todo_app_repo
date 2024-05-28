class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }  static bool isPhoneValid(String phone) {
    return RegExp(r'^(\+201|01|00201)[0-2,5]{1}[0-9]{8}')
        .hasMatch(phone);
  }

}