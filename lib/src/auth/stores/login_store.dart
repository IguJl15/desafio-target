import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  bool loading = false;

  @action
  Future<void> login() async {
    loading = true;
    print("Logging in");

    await Future.delayed(const Duration(seconds: 2));
    print("Logged!");

    loading = false;
    isLoggedIn = true;
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool showPassword = false;

  @observable
  bool isLoggedIn = false;

  @computed
  bool get isFormValid => email.length > 6 && password.length > 6;

  @computed
  String? get emailError {
    if (email.length < 2) {
      return "O email deve conter pelo menos 2 caracteres";
    } else if (email.length > 20) {
      return "O email deve conter até 20 caracteres";
    } else if (!email.isValidEmail()) {
      return "O email está inválido. Verifique o formato";
    } else {
      return null;
    }
  }

  @computed
  String? get passwordError {
    if (password.length < 2) {
      return "A senha deve conter pelo menos 2 caracteres";
    } else if (password.length > 20) {
      return "A senha deve conter até 20 caracteres";
    } else if (!password.isValidPassword()) {
      return "A senha está inválida";
    } else {
      return null;
    }
  }

  @action
  void setEmail(String value) => email = value.trim();

  @action
  void setPassword(String value) => password = value;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @action
  void logout() {
    isLoggedIn = false;
    loading = false;
    email = '';
    password = '';
  }
}

// This extension could be on the shared folder, but as it specifies a "domain" rule, we are putting it here
extension _Validation on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+(\.[a-zA-Z]{1,})+$");
    return emailRegExp.hasMatch(this);
  }

  bool isValidPassword() {
    final passwordRegExp = RegExp(r'^\w*$');
    return passwordRegExp.hasMatch(this);
  }
}
