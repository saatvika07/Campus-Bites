import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/widgets/custom_scaffold.dart';
import 'package:login_signup/widgets/search_widget.dart';

class FastFoodPage extends StatelessWidget {
  const FastFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: ListView(
        children: const [
          SearchWidget()
        ],
      )

    );
  }
}
