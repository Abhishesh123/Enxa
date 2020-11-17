import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/loaderdialog.dart';
import 'package:enxa/ui/components/payments.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/passbook.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'home.dart';

class AddMoney extends StatefulWidget {
  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController _controller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "add_money",
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: customColor.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: customColor.white,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CText("Add Money to Enxa Balance", 25,fontWeight: FontWeight.bold,color: customColor.black),
                CText("Available balance Rs. ${['balance']}", 15,fontWeight: FontWeight.w300,color: Colors.grey),
                SizedBox(height: 10,),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Enter amount"
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        bottomSheet: BottomSheet(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          onClosing: (){},
          builder: (context){
            return Container(
              height: 100,
              alignment: Alignment.center,
            child:Container(
              color: customColor.white,
              width: Gen.Screenwidth(context)*.8,
              child: CRaisedButton(text: "Add",color: customColor.blue,radius: 20,onclick: ()async{
                int money=int.parse(_controller.text.replaceAll(" ", "").replaceAll("-", "").replaceAll(",", ""));
                if(_controller.text.isNotEmpty){
                  Map<String,dynamic> response = await  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Payments(_controller.text.replaceAll(" ", "").replaceAll("-", "").replaceAll(",", ""));
                  }));
                  if(response!=null){
                  LoaderDialog(context, false,text: "Adding money..");
                  FirebaseFirestore.instance.collection('user').doc(Home.user.id).update({
                    "balance":FieldValue.increment(money)
                  }).then((value)async{
                    response['userid']=Home.user.id;
                    response['datetime']=DateTime.now().millisecondsSinceEpoch;
                   await  FirebaseFirestore.instance.collection(Constant.ADDED_TO_WALLET).add(response);
                   await Gen().UpdateUser();
                   Toast.show("success", context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                  }
                }
              }),
            ),
            );
          },
        ),
        ),

      ),
    );
  }
}
