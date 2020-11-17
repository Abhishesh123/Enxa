import 'package:enxa/logic/phone_auth.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';


showOtpBottomSheet(PhoneAuth phoneAuth,BuildContext context){
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      context: context, builder: (context){
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CText(
           "Enter the otp sent to "+phoneAuth.phone,
            17,
            color: customColor.black
          ),
          SizedBox(
            height: 25,
          ),
          OTPTextField(
            length: 6,
            width: Gen.Screenwidth(context),
            fieldWidth: Gen.Screenwidth(context)/7,
            style: TextStyle(
                fontSize: 17
            ),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              phoneAuth.signInWithPhoneNumber(pin);
            },
          ),
        ],
      ),
    );
  });
}
