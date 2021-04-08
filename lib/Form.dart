import 'package:flutter/material.dart';
import 'astextfield.dart';

class UserForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserFormState();
}

class UserFormState extends State<UserForm> {
  //TEXT INPUT FIELDS
  var email = TextEditingController();
  var pwd = TextEditingController();

  //FOCUS NODE
  final FocusNode focusEmail = new FocusNode();
  final FocusNode focusPassword = new FocusNode();

  String validateEmailRegExp(String value) {
    if (value.length == 0) {
      return "enter email";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //CLASS OBJECT - EMAIL
    final emailField = ASTextField("Email", email, txtIconPath: 'assets/images/ic_email.png', txtValidator: validateEmailRegExp,
         currentFocus: focusEmail,
         nextFocus: focusPassword,
         keyboardType: InputType.email);

    final password = ASTextField("Password",
        pwd, txtValidator: validateEmailRegExp,
        currentFocus: focusPassword,
        keyboardType: InputType.password,
        keyboardAction: InputAction.done);

//    //VALIDATE USER INPUT FUNCTION
    Future<void> _validateInputs(BuildContext context) async {
//      final form = _forgotPasswordFormKey.currentState;
    //  if (form.validate()) {
        // Text forms has validated.
        // Every of the data in the form are valid at this point
      //  form.save();
        String email = emailField.getFieldValue().text;
     // }
    }

    //NEXT SCREEN BUTTON
    nextScreenButton(BuildContext context) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 5, 0),
        child: Align(
          //RIGHT SIDE BUTTON FOR CLICK AND NAVIGATE TO NEXT SCREEN
          alignment: Alignment.centerRight,
          child: FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
//              hideKeyboard(context);
              _validateInputs(context);
            },
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Form",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        titleSpacing: 0.0,

        //APP BAR SHADOW
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          //BOTTOM VIEW WITH COLOR
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: 60,
            child: Container(
              color:Colors.orange,
            ),
          ),

          //SUBMIT BUTTON
          Positioned(
            bottom: 35.0,
            left: 0.0,
            right: 35.0,
            child: nextScreenButton(context),
          ),

          //TOP VIEW
          Positioned(
            top: 0.0,
            //MARGIN FROM BOTTOM VIEW
            bottom: 80.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                child: ListView(
                  children: <Widget>[

                    //EMAIL - COMMON FIELD
                    emailField,

                    password,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
