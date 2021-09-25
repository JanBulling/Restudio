bool isValidEmail(String? email) {
  if (email == null || email.isEmpty) return false;

  final expression = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return expression.hasMatch(email);
}

bool isValidPassword(String? password) {
  if (password == null || password.isEmpty) return false;

  return password.trim().length >= 6;
}

bool isValidZipCode(String? zip) {
  if (zip == null || zip.length != 5) return false;
  try {
    int.parse(zip);
    return true;
  } catch (e) {
    return false;
  }
}
