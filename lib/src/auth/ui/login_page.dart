import 'package:desafio_target/src/auth/stores/login_store.dart';
import 'package:desafio_target/src/shared/extensions/theme.dart';
import 'package:desafio_target/src/home/ui/home_page.dart';
import 'package:desafio_target/src/shared/components/input_field/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "login_page";

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore loginStore;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late ReactionDisposer reactionDisposer;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() => loginStore.setEmail(_emailController.text));
    _passwordController.addListener(() => loginStore.setPassword(_passwordController.text));
  }                                                                                                                                                               

  @override
  void dispose() {
    reactionDisposer();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);
    reactionDisposer = reaction((_) => loginStore.isLoggedIn, (bool loggedIn) {
      if (loggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fieldLabelStyle = TextStyle(color: Colors.white);
    final fieldErrorStyle = TextStyle(color: context.colorScheme.onErrorContainer);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: primaryGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Observer(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              CustomTextField(
                label: const Text("Usuário"),
                  labelTextStyle: fieldLabelStyle,
                  errorTextStyle: fieldErrorStyle,
                enabled: !loginStore.loading,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _emailController,
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: const Text("Senha"),
                  labelTextStyle: fieldLabelStyle,
                  errorTextStyle: fieldErrorStyle,
                enabled: !loginStore.loading,
                obscureText: !loginStore.showPassword,
                keyboardType: TextInputType.visiblePassword,
                autocorrect: false,
                controller: _passwordController,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: loginStore.toggleShowPassword,
                  icon: Icon(loginStore.showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: loginStore.login,
                child: loginStore.loading
                    ? CircularProgressIndicator(color: context.colorScheme.surface)
                    : const Text('Login'),
              ),
              const Spacer(),
              TextButton(
                  onPressed: () async {
                    final uri = Uri.parse("https://www.google.com");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {}
                  },
                    child: Text("Política de Privacidade", style: fieldLabelStyle))
            ],
          );
        }),
      ),
    );
  }
}
