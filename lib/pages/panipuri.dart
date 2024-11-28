import 'package:flutter/material.dart';
import 'package:login_signup/widgets/app_bar_widget.dart';
import 'package:login_signup/widgets/custom_scaffold.dart';

class PaniPuriPage extends StatelessWidget {
  const PaniPuriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: ListView(
        children: const [
          AppBarWidget(),
        ],
      )

    );
  }
}
