import 'package:desafio_target/src/shared/extensions/theme.dart';
import 'package:desafio_target/src/shared/gradients/primary_gradient.dart';
import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final VoidCallback logoutButtonPressed;
  const PageTitle({super.key, required this.logoutButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Suas informações",
            style: context.textTheme.titleLarge!.merge(onPrimaryGradientTextStyle),
          ),
          IconButton(
            onPressed: logoutButtonPressed,
            tooltip: "Sair",
            icon: const Icon(Icons.logout),
            color: onPrimaryGradientTextStyle.color,
          )
        ],
      ),
    );
  }
}
