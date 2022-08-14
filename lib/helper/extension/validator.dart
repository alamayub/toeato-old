extension Validators on String {
  String? isValidEmail(val) {
    if (val.isEmpty) {
      return 'Enter your email.';
    } else {
      final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (!emailRegExp.hasMatch(val)) return 'Enter valid email.';
      return null;
    }
  }

  String? isValidName(val) {
    if (val.isEmpty) {
      return 'Enter your full name.';
    } else {
      final pnameRegExp =
          RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
      if (!pnameRegExp.hasMatch(val)) return 'Enter valid name.';
      return null;
    }
  }

  String? isValidPassword(val) {
    if (val.isEmpty) {
      return 'Enter your password.';
    } else {
      if (val.length < 6) return 'Enter password at least 6 characters.';
      return null;
    }
  }

  String? isValidPhone(val) {
    if (val.isEmpty) {
      return 'Enter mobile number.';
    } else {
      final phoneRegExp = RegExp(r"^9?[0-9]{10}$"); // ^\+?0[0-9]{10}$
      if (!phoneRegExp.hasMatch(val)) return 'Enter 10 digit mobile number';
      return null;
    }
  }

  String? isValidOTP(val) {
    if (val.isEmpty) {
      return 'Enter mobile number.';
    } else {
      final phoneRegExp = RegExp(r"^[0-9]{6}$"); // ^\+?0[0-9]{10}$
      if (!phoneRegExp.hasMatch(val)) return 'Enter 6 digit mobile number';
      return null;
    }
  }
}
