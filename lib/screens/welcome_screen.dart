import 'package:flutter/material.dart';
import 'package:login_signup/screens/signin_screen.dart';
import 'package:login_signup/screens/signup_screen.dart';
import 'package:login_signup/widgets/custom_scaffold.dart';
import 'package:login_signup/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 40.0,
                ),
                child: Center(
  child: RichText(
    textAlign: TextAlign.center,
    text: const TextSpan(
      children: [
        TextSpan(
          text: 'Welcome Back!\n',
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 21, 21, 21), // Correct property
          ),
        ),
        TextSpan(
          text: '\nEnter your personal details',
          style: TextStyle(
            fontSize: 20.0,
            height: 1.5, // Adjusted to reasonable line height
            color: Color.fromARGB(255, 21, 21, 21), // Correct property
          ),
        ),
      ],
    ),
  ),
),
              )),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Color.fromARGB(255, 242, 241, 241),
                      textColor: Color.fromARGB(255, 233, 178, 95),
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: SignUpScreen(),
                      color: Color.fromARGB(255, 227, 173, 92),
                      textColor: Color.fromARGB(255, 244, 242, 239),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}