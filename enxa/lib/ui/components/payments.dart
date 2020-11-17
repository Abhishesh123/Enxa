import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:upi_india/upi_india.dart';

import '../../loaderdialog.dart';
import 'reusable_components.dart';

class Payments extends StatefulWidget {
  String amount;
  Payments(this.amount);
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  UpiResponse _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;
  String upiid="7210404907@upi";


  String notif="";
  IconData notificon=Icons.payment;
  Color notifcolor=customColor.orange;

  @override
  void initState() {
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(String app) async {

    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: upiid,
      receiverName: 'Mujeen khan',
      transactionRefId: 'OrderFromenxa',
      transactionNote: 'Ordering from enxa',
      amount: double.parse(widget.amount),
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Center(
        child: Wrap(
          children: apps.map<Widget>((UpiApp app) {
            return GestureDetector(
              onTap: (){
                _handleTransaction(app.app);
              },
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.memory(
                      app.icon,
                      height: 60,
                      width: 60,
                    ),
                    Text(app.name,style: GoogleFonts.muli(color: customColor.grey),),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }

  _headings(text){
    return Container(
        margin: EdgeInsets.all(14),
        alignment: Alignment.topLeft,
        child: Text(text,style: GoogleFonts.muli(color:customColor.white,fontSize: 16),));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor.black,
      appBar: AppBar(
        backgroundColor: customColor.darkgrey,
        title: Text('Payment'),
      ),
      body: upiid.isEmpty?
          Center(child: SpinKitCircle(color: customColor.orange,))
          :Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _showvalue(notif, notificon,notifcolor ),
          _headings("Pay Rs. ${double.parse(widget.amount)} with"),
          displayUpiApps(),
          
        ],
      ),
    );
  }


  void _chekresult(UpiResponse _upiResponse){
      if (_upiResponse.error != null) {
        String text = '';
        switch (_upiResponse.error) {
          case UpiError.APP_NOT_INSTALLED:
            text = "Requested app not installed on device";
            break;
          case UpiError.INVALID_PARAMETERS:
            text = "Requested app cannot handle the transaction";
            break;
          case UpiError.NULL_RESPONSE:
            text = "requested app didn't returned any response";
            break;
          case UpiError.USER_CANCELLED:
            text = "You cancelled the transaction";
            break;
        }
        setState(() {
          notif=text;
          notifcolor=Colors.redAccent;
          notificon=Icons.error;
        });
        return;
      }
      String txnId = _upiResponse.transactionId;
      String resCode = _upiResponse.responseCode;
      String txnRef = _upiResponse.transactionRefId;
      String status = _upiResponse.status;
      String approvalRef = _upiResponse.approvalRefNo;
      Map<String ,dynamic> transdata=Map();
      transdata['txnid']=txnId;
      transdata['rescode']=resCode;
      transdata['txnref']=txnRef;
      transdata['status']=status;
      transdata['approvalref']=approvalRef;
      transdata['amount']=widget.amount;
      switch (status) {
        case UpiPaymentStatus.SUCCESS:
          {
            Navigator.pop(context,transdata);
          }
          break;
        case UpiPaymentStatus.SUBMITTED:
          {
            setState(() {
              notif="Transaction went in pending state, We will refund you if we recieve payment."
                  "\nIf you do not recieve refund by 24 hours. Contact us";
              notifcolor=customColor.orange;
              notificon=FontAwesomeIcons.download;
            });
          }
          break;
        case UpiPaymentStatus.FAILURE:
          {
            setState(() {
              notif="Transaction Failed";
              notifcolor=Colors.redAccent;
              notificon=Icons.error;
            });
          }
          break;
        default:
          print('Received an Unknown transaction status');
      }
  }


  _showvalue(text,icon,color){
    if(text.isEmpty) return Container(alignment: Alignment.center,);
    return Container(
      alignment: Alignment.center,
      decoration:BoxDecoration(
          color: customColor.white,
      ),
      child: ListTile(
        leading: Icon(icon,color: color,),
        title: Text(text,style: GoogleFonts.muli(color: notifcolor,fontSize: 13),),
      ),
    );
  }

  _handleTransaction(app) async{
    if(upiid.isEmpty){
      Toast.show("Please try a bit later", context);
      return;
    }
    _transaction = await initiateTransaction(app);
    _chekresult(_transaction);
    setState(() {});
  }


}