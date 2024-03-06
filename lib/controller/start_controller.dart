import 'package:flutter/material.dart';
import 'package:assone/view/LoginScreen.dart';
import 'package:assone/view/register.dart';

class StartScreenController {
  Widget loginButton(BuildContext context) {
    return Stack(
      children: [
        Material(
          elevation: 5,
          color: Color.fromARGB(255, 142, 204, 255),
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width * 0.6,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginView()));
            },
            child: const Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget signupButton(BuildContext context) {
    return Stack(
      children: [
        Material(
          elevation: 5,
          color: Color.fromARGB(255, 142, 204, 255),
          borderRadius: BorderRadius.circular(30),
          child: MaterialButton(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width * 0.6,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()));
            },
            child: const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
