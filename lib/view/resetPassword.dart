import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:assone/controller/reset_controller.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({Key? key}) : super(key: key);

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  final ResetPassController _controller = ResetPassController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Your Email";
        } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return "Please Enter a valid Email";
        }
        return null;
      },
      onSaved: (value) {
        _emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final resetBtn = Material(
      elevation: 5,
      color: Color.fromARGB(255, 142, 204, 255),
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.5,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _controller.resetPassword(_emailController.text).then((value) {
              print("Password reset email sent.");
              Fluttertoast.showToast(msg: "Password reset email sent.");
              Navigator.of(context).pop();
            }).catchError((error) {
              print("Password reset failed: Enter valid Email");
              Fluttertoast.showToast(
                  msg: "Password reset failed: Enter valid Email");
            });
          }
        },
        child: const Text(
          "Reset Password",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Forget Password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 142, 204, 255),
      ),
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
                        height: 20,
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
                        height: 65,
                      ),
                      emailField,
                      const SizedBox(
                        height: 40,
                      ),
                      resetBtn,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
