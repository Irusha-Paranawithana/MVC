import 'package:flutter/material.dart';
import 'package:assone/controller/start_controller.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final StartScreenController _controller = StartScreenController();

  Widget loginButton(BuildContext context) {
    return _controller.loginButton(context);
  }

  Widget signupButton(BuildContext context) {
    return _controller.signupButton(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40.0),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Food Kade',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Lets eat food ',
              style: TextStyle(
                fontFamily: "SinhalaFont",
                fontSize: 25.0,
                color: Color.fromARGB(255, 118, 118, 118),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                const SizedBox(height: 20.0),
                loginButton(context),
                const SizedBox(height: 20.0),
                signupButton(context),
                const SizedBox(height: 50.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
