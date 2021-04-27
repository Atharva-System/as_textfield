# as_textfield

A new Flutter application that shows usage of astextfield .

## Getting Started

## Example
```
//Initialize TextEditingController
var userName = TextEditingController();

//Define validator
String validateName(String value) {
     if (value.length == 0) {
       return enterUserName;
     }
     return null;
}

//Input formatter for name text field
List<TextInputFormatter> nameInputFormatter = [
  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
   LengthLimitingTextInputFormatter(30)
];

//CLASS OBJECT - FULL NAME
   final userNameField = ASTextField(
       "User name",                             //Required hint name
       userName,                                //Required TextEditingController
       txtValidator: validateName,              //Optional validator
       keyboardType: InputType.normal,          //Optional Keyboard type
       currentFocus: focusUserName,             //Optional current focus
       nextFocus: focusEmail,                   //Optional next focus
       txtInputFormatter: nameInputFormatter,   //Optional Input formatter
       keyboardAction: InputAction.done,        //Optional Keyboard action next/done
       txtColor: Colors.black,                  //Optional text color
       disableTxtColor: Colors.grey,            //Optional disable text color
       txtFontFamily: "Roboto",                 //Optional text font family
       txtFontSize: 20,                         //Optional text font size
       txtErrorFontStyle: FontStyle.normal,     //Optional text font style
       txtErrorFontWeight: FontWeight.normal,   //Optional text font weight
       txtErrorColor:  Colors.red,              //Optional text error color
       txtHintColor: Colors.grey,               //Optional text hint color
       isFormEnable: false);                    //Optional value for form field enable or not
```
