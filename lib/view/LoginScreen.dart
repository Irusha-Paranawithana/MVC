import 'package:flutter/material.dart';
import 'package:assone/controller/auth_controller.dart';
import 'package:assone/view/register.dart';
import 'package:assone/view/resetPassword.dart';
import 'package:assone/view/home.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInWithEmailPassword() async {
    final AuthController authController = AuthController();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final success = await authController.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome to Cafe Miron!"),
            backgroundColor: Colors.black,
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login Failed. Please check your credentials."),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final passwordField = Stack(
      children: [
        TextFormField(
          autofocus: false,
          controller: passwordController,
          obscureText: !_isPasswordVisible, // Toggle password visibility
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password Is Required");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password (Min. 6 Characters)");
            }
            return null;
          },
          onSaved: (value) {
            passwordController.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            labelText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off, // Toggle password visibility
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
              });
            },
          ),
        ),
      ],
    );

    final loginButton = Stack(
      children: [
        Material(
            elevation: 5,
            color: Colors.green, // Replace with your desired color
            borderRadius: BorderRadius.circular(30),
            child: IgnorePointer(
              ignoring: _isLoading,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width * 0.5,
                onPressed: () {
                  signInWithEmailPassword();
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
            )),
      ],
    );

    Widget forgetPassword(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 35,
        alignment: Alignment.bottomRight,
        child: TextButton(
          child: const Text(
            "Forget Password ?",
            style: TextStyle(color: Colors.green), // Replace with your color
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResetPassScreen()));
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/images/cafe_logo.png",
                          width: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      emailField,
                      const SizedBox(
                        height: 20,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 2,
                      ),
                      forgetPassword(context),
                      const SizedBox(
                        height: 40,
                      ),
                      loginButton,
                      const SizedBox(
                        height: 150,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green, // Replace with your color
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
