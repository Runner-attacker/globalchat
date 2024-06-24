import 'package:flutter/material.dart';
import 'package:globalchat/controller/sigin_screen_controller.dart';

class SignScreen extends StatefulWidget {
  final VoidCallback show;
  const SignScreen(this.show, {super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();
  TextEditingController country_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController cpassword_controller = TextEditingController();

  FocusNode email_focus = FocusNode();
  FocusNode country_focus = FocusNode();
  FocusNode name_focus = FocusNode();
  FocusNode password_focus = FocusNode();
  FocusNode cpassword_focus = FocusNode();

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

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Required Feild";
    } else if (value != password_controller.text) {
      return "Password do not match";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signin Screen"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1,
                ),
                Image.asset(
                  "assets/images/chatlogo.png",
                  height: 120,
                ),
                SizedBox(
                  height: 40.0,
                ),
                textedfeild(context, email_controller, email_focus, name_focus,
                    "Email"),
                SizedBox(
                  height: 10.0,
                ),
                textedfeild(context, name_controller, name_focus, country_focus,
                    "Name"),
                SizedBox(
                  height: 10.0,
                ),
                textedfeild(context, country_controller, country_focus,
                    password_focus, "Country"),
                SizedBox(
                  height: 10.0,
                ),
                textedfeild(context, password_controller, password_focus,
                    cpassword_focus, "Password"),
                SizedBox(
                  height: 10.0,
                ),
                textedfeild(context, cpassword_controller, cpassword_focus,
                    null, " Confirm Password", confirmPasswordValidator),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        SignupController.createAccount(
                            context: context,
                            email: email_controller.text,
                            password: password_controller.text,
                            name: name_controller.text,
                            country: country_controller.text);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Center(
                        child: Text(
                          "Sigin",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
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
                      Text("Already have an Account? "),
                      InkWell(
                        onTap: widget.show,
                        child: Text(
                          " Login",
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
      ),
    );
  }

  Widget textedfeild(BuildContext context, TextEditingController textcontroller,
      FocusNode _currentFocus, FocusNode? _nextFocus, String type,
      [String? Function(String?)? customvalidator]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textcontroller, //textcontroller
        focusNode: _currentFocus, //currentFocus
        validator: customvalidator ?? formValidator,
        onFieldSubmitted: (_) {
          if ((customvalidator ?? formValidator)(textcontroller.text) == null) {
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
