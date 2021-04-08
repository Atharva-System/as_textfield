import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputType { normal, password, number, email }
enum InputAction { next, done }

class ASTextField extends StatelessWidget {
  //TEXT FIELD HINT
  final String txtHint;

  //TEXT FIELD ICON PATH
  final String txtIconPath;

  //TEXT FIELD COLOR
  Color txtColor;
  Color disableTxtColor;
  Color txtHintColor;
  Color txtErrorColor;

  //INIT TEXT FIELD
  final txtFieldName;

  //INPUT TYPE FOR TEXT FIELD - NUMBER, PASSWORD, EMAIL, TEXT
  InputType keyboardType;

  //FUNCTION TO VALIDATE TEXTFIELD
  FormFieldValidator<String> txtValidator;

  //ADD FORMATING TO
  List<TextInputFormatter> txtInputFormatter;

  //FONT FAMILY
  String txtFontFamily;
  String txtHintFontFamily;
  String txtErrorFontFamily;

  //FONT WEIGHT - normal OR bold
  FontWeight txtFontWeight;
  FontWeight txtHintFontWeight;
  FontWeight txtErrorFontWeight;

  //FONT STYLE - normal OR italic
  FontStyle txtFontStyle;
  FontStyle txtHintFontStyle;
  FontStyle txtErrorFontStyle;

  //TEXT FONT SIZE
  double txtFontSize;
  double txtHintFontSize;
  double txtErrorFontSize;

  //TEXT KEYBOARD ACTION
  InputAction keyboardAction;

  //FOR FOCUS TO TEXT FIELD
  FocusNode currentFocus = FocusNode();
  FocusNode nextFocus = FocusNode();

  //DEFAULT VALUES
  final double defaultFontSize = 18;
  final double defaultErrorFontSize = 13;

  final FontStyle defaultFontStyle = FontStyle.normal;
  final FontWeight defaultFontWeight = FontWeight.normal;
  final String defaultFontFamily = 'Roboto';
  Color defaultTxtColor = Colors.black;
  Color defaultHintColor = Color(0xff777777);
  Color defaultErrorColor = Colors.red;
  Color defaultDisableTxtColor = Colors.grey;

  bool isFormEnable;
  bool defaultIsFormEnable = true;

  //CONSTRUCTOR
  ASTextField(this.txtHint, this.txtFieldName,
      {this.txtValidator,
        this.keyboardType,
        this.txtIconPath,
        this.txtInputFormatter,
        this.txtFontFamily,
        this.txtFontWeight,
        this.txtFontStyle,
        this.txtFontSize,
        this.txtColor,
        this.disableTxtColor,
        this.txtHintFontFamily,
        this.txtHintFontWeight,
        this.txtHintFontStyle,
        this.txtHintFontSize,
        this.txtHintColor,
        this.txtErrorFontFamily,
        this.txtErrorFontWeight,
        this.txtErrorFontStyle,
        this.txtErrorFontSize,
        this.txtErrorColor,
        this.keyboardAction,
        this.currentFocus,
        this.nextFocus,
        this.isFormEnable});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          txtIconPath != null
              ? Container(
            child: Align(
              //RIGHT SIDE BUTTON FOR CLICK AND NAVIGATE TO NEXT SCREEN
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(
                  txtIconPath,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          )
              : Container(
            height: 0,
            width: 0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Align(
              //RIGHT SIDE BUTTON FOR CLICK AND NAVIGATE TO NEXT SCREEN
              alignment: Alignment.topRight,
              child: TextFormField(
                //enabled: true = CAN EDIT, enabled: false = READ ONLY / CAN NOT EDIT
                enabled: isFormEnable ?? defaultIsFormEnable,
                style: TextStyle(
                  fontFamily: txtFontFamily ?? defaultFontFamily,
                  fontWeight: txtFontWeight ?? defaultFontWeight,
                  fontStyle: txtFontStyle ?? defaultFontStyle,
                  fontSize: txtFontSize ?? defaultFontSize,
                  color: setTextColor(),
                ),
                focusNode: currentFocus,
                onEditingComplete: () =>
                    _fieldFocusChange(context, currentFocus, nextFocus),
                textInputAction: getAction(keyboardAction),
                controller: txtFieldName,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                //SET KEYBOARD TYPE FOR - NUMBER, TEXT, EMAIL, ETC.
                keyboardType: getKeyboardType(keyboardType),
                //TEXT FIELD TYPE PASSWORD or NOT, obscureText = true MEANS PASSWORD TYPE
                obscureText: (getKeyboardType(keyboardType) ==
                    TextInputType.visiblePassword)
                    ? true
                    : false,
                validator: txtValidator ?? null,
                inputFormatters: txtInputFormatter,
                decoration: InputDecoration(
                  contentPadding: getTextLeftPadding(),
                  hintText: txtHint,
                  hintStyle: TextStyle(
                    fontFamily: txtHintFontFamily ?? defaultFontFamily,
                    fontWeight: txtHintFontWeight ?? defaultFontWeight,
                    fontStyle: txtHintFontStyle ?? defaultFontStyle,
                    fontSize: txtHintFontSize ?? defaultFontSize,
                    color: txtHintColor ?? defaultHintColor,
                  ),
                  errorStyle: TextStyle(
                    fontFamily: txtErrorFontFamily ?? defaultFontFamily,
                    fontWeight: txtErrorFontWeight ?? defaultFontWeight,
                    fontStyle: txtErrorFontStyle ?? defaultFontStyle,
                    fontSize: txtErrorFontSize ?? defaultErrorFontSize,
                    color: txtErrorColor ?? defaultErrorColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //FUNCTION RETURNS TEXT FILED TO GET ALL PARAMETERS OF TEXT FILED
  TextEditingController getFieldValue() {
    return txtFieldName;
  }

  //THIS SET KEYBOARD TYPE
  getKeyboardType(InputType type) {
    if (type == InputType.password) {
      return TextInputType.visiblePassword;
    } else if (type == InputType.number) {
      return TextInputType.number;
    } else if (type == InputType.email) {
      return TextInputType.emailAddress;
    }
    return TextInputType.text;
  }

  //THIS SET KEYBOARD ACTION
  getAction(InputAction action) {
    if (action == InputAction.done) {
      return TextInputAction.done;
    }
    return TextInputAction.next;
  }

  //THIS SET FOCUS
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    if (nextFocus == null || currentFocus == null) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      //CLEAR FOCUS
      FocusScope.of(context).unfocus();
    } else {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  //IF ICON PATH NOT AVAILABLE - TEXT CONTENT LEFT IS NOT SPACING, ELSE LEFT SPACING
  getTextLeftPadding() {
    if (txtIconPath == null)
      return const EdgeInsets.only(left: 0.0, bottom: 16);
    return const EdgeInsets.only(left: 25.0, bottom: 16);
  }

  //SET TEXT COLOR FOR ENABLE/DISABLE TEXTFIELD
  setTextColor() {
    if (isFormEnable == null || isFormEnable == true) {
      return txtColor ?? defaultTxtColor;
    } else
      return disableTxtColor ?? defaultDisableTxtColor;
  }
}
