import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();
  void changeFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String? formValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Required Feild";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
              ),
              Image.asset(
                "assets/images/chatlogo.png",
                height: 120,
              ),
              SizedBox(
                height: 10.0,
              ),
              textedfeild(
                  context, emailcontroller, emailfocus, passwordfocus, "Email"),
              SizedBox(
                height: 10.0,
              ),
              textedfeild(
                  context, passwordcontroller, passwordfocus, null, "Password"),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an Account? "),
                    InkWell(
                      onTap: widget.show,
                      child: Text(
                        " Signin",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textedfeild(BuildContext context, TextEditingController textcontroller,
      FocusNode _currentFocus, FocusNode? _nextFocus, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textcontroller, //textcontroller
        focusNode: _currentFocus, //currentFocus
        validator: formValidator,
        onFieldSubmitted: (_) {
          if (formValidator(textcontroller.text) == null) {
            if (_nextFocus != null) {
              changeFocus(context, _currentFocus, _nextFocus);
            } else {
              _currentFocus.unfocus();
            }
          }
        },
        decoration: InputDecoration(
            labelText: type,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
