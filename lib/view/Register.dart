import 'package:flutter/material.dart';
import 'package:assone/controller/register_controller.dart';
import 'package:assone/model/user_model.dart';
import 'package:assone/view/home.dart';
import 'package:assone/view/LoginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegistrationController _registrationController =
      RegistrationController();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController residentialAddressController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
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
                        SizedBox(
                          height: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return "User Name Is Required";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Enter Valid User Name (Min. 3 Characters)";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.account_circle),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "User Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Email";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Please Enter valid Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Email Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: residentialAddressController,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{3,}$');
                            if (value!.isEmpty) {
                              return "Residential Address Is Required";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Enter Valid Address (Min. 3 Characters)";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.pin_drop),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Residential Address",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (!RegExp(r'^\d{10}$').hasMatch(value!)) {
                              return "Enter a Valid 10-Digit Mobile Number";
                            }
                            if (value.isEmpty) {
                              return "Mobile Number Is Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Mobile Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password Is Required";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Enter Valid Password (Min. 6 Characters)";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          controller: confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          validator: (value) {
                            if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "Password Don't Match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Material(
                          elevation: 5,
                          color: Color.fromARGB(255, 142, 204, 255),
                          borderRadius: BorderRadius.circular(30),
                          child: MaterialButton(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            minWidth: MediaQuery.of(context).size.width / 2,
                            onPressed: () {
                              signUp();
                            },
                            child: const Text(
                              "SignUp",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginView(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 142, 204, 255),
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

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      UserModel userModel = UserModel();
      userModel.userName = userNameController.text;
      userModel.residentialAddress = residentialAddressController.text;
      userModel.phoneNumber = phoneNumberController.text;
      userModel.password = passwordController.text;

      await _registrationController.signUp(
          userModel, emailAddressController.text, passwordController.text);

      setState(() {
        _isLoading = false;
      });
    }
  }
}
