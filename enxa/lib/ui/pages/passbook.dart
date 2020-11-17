import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/ui/components/pie_chart.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/charging.dart';
import 'package:enxa/ui/pages/charginghistory.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_money.dart';

class Passbook extends StatefulWidget {
  @override
  _PassbookState createState() => _PassbookState();
}

class _PassbookState extends State<Passbook> {
  List<bool> btns=[true,false,false];

  List<DocumentSnapshot> added_to_wallet;
  List<DocumentSnapshot> paid_with_upi;

  _settrue(i){
    btns[0]=false;
    btns[1]=false;
    btns[2]=false;
    setState(() {
      btns[i]=true;
    });
  }

  @override
  void initState() {
    _load();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Transactions",
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            alignment: Alignment.topCenter,
            color: customColor.dark_back,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CText("Transactions", 22,color: customColor.white),
                  CPieChart(dataMap: {"Paid with wallet":10,"Added to wallet":30,"Paid with UPI":40},colors: [Colors.lightBlue.withOpacity(0.6),Colors.amber,customColor.orange],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ButtonBar(

                        children: [

                          GestureDetector(

                            child: Image.asset("assets/chargingH.png",width: 100.0,
                              height: 36.0,fit: BoxFit.fill,),
                            onTap: () {
                              showDialog(context: context,
                                  builder: (context){
                                    return ChargingH();
                                  }
                              );
                            },

                          ),
                          GestureDetector(

                            child: Image.asset("assets/Addmoney.png",width: 100.0,
                              height: 36.0,fit: BoxFit.fill,),
                            onTap: () {
                              showDialog(context: context,
                                  builder: (context){
                                    return AddMoney();
                                  }
                              );
                            },

                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ButtonBar(

                        children: [
                          RaisedButton(onPressed: (){_settrue(0);},child: Text("Paid with wallet",style: GoogleFonts.muli(color:btns[0]?customColor.white:customColor.grey,fontSize: btns[0]?15:10),),color: btns[0]?customColor.grey:customColor.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
                          RaisedButton(onPressed: (){_settrue(1);},child: Text("Added to wallet",style: GoogleFonts.muli(color: btns[1]?customColor.white:customColor.grey,fontSize: btns[1]?15:10),),color: btns[1]?customColor.grey:customColor.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
                          RaisedButton(onPressed: (){_settrue(2);},child: Text("Paid with UPI",style: GoogleFonts.muli(color: btns[2]?customColor.white:customColor.grey,fontSize: btns[2]?15:10),),color: btns[2]?customColor.grey:customColor.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),),
                        ],
                      )
                    ],
                  ),
                  Divider(height: 3,color: customColor.grey,),
                  SizedBox(height: 8,),
                  (){
                  if(btns[0]){
                    return _dummy();
                  }else if(btns[1]){
                    if(added_to_wallet==null){
                      return Center(child: SpinKitCircle(color: customColor.orange,));
                    }else if(added_to_wallet.isEmpty){
                      return Center(child:CText("No transaction yet!",15,color: customColor.grey));
                    }else{
                      return _getAdded(added_to_wallet);
                    }
                  } else if(btns[2]){
                    if(paid_with_upi==null){
                      return Center(child: SpinKitCircle(color: customColor.orange,));
                    }else if(paid_with_upi.isEmpty){
                      return Center(child:CText("No transaction yet!",15,color: customColor.grey));
                    }else{
                      return _getPaid(paid_with_upi);
                    }
                  }
                  }()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  _getPaid(List<DocumentSnapshot> _data){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _data.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: customColor.orange,
            radius: 10,
          ),
          title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Amount paid",style: GoogleFonts.muli(color: customColor.white),),
              Text("RS. ${_data[index]['amount']}",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
            ],
          ),
          trailing:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Date",style: GoogleFonts.muli(color: customColor.white),),
              Text(_getDate(_data[index]['datetime']),style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Transaction Id",style: GoogleFonts.muli(color: customColor.white),),
              Text("${_data[index]['txnid']}",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
              Divider(height: 2,color: customColor.grey,),
            ],
          ),
        );
      },
    );
  }


  _getAdded(List<DocumentSnapshot> _data){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: _data.length,
      itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: customColor.blue,
            radius: 10,
          ),
          title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Amount added",style: GoogleFonts.muli(color: customColor.white),),
              Text("RS. ${_data[index]['amount']}",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
            ],
          ),
          trailing:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Date",style: GoogleFonts.muli(color: customColor.white),),
              Text(_getDate(_data[index]['datetime']),style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
            ],
          ),subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Transaction Id",style: GoogleFonts.muli(color: customColor.white),),
            Text("${_data[index]['txnid']}",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
            Divider(height: 2,color: customColor.grey,),
          ],
        ),
        );
      },
    );
  }


  _dummy(){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: customColor.orange,
            radius: 10,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Amount paid",style: GoogleFonts.muli(color: customColor.white),),
                  Text("Rs. 200",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Date",style: GoogleFonts.muli(color: customColor.white),),
                  Text("12:02:2020",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Transaction Id",style: GoogleFonts.muli(color: customColor.white),),
                  Text("gefiuyuiy3487444",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),),
                ],
              )
            ],
          ),subtitle: Divider(height: 2,color: customColor.grey,),
        );
      },
    );
  }

  _load() async{
    FirebaseFirestore.instance.collection(Constant.ADDED_TO_WALLET).where("userid",isEqualTo: Home.user.id).get().then((value){
      setState(() {
        added_to_wallet=value.docs;
      });
    });
    FirebaseFirestore.instance.collection(Constant.PAID_TO_SOMEONE).where("userid",isEqualTo: Home.user.id).get().then((value){
      setState(() {
        paid_with_upi=value.docs;
      });
    });
  }

  _getDate(int timestamp){
    DateTime dateTime=DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dateTime.day}:${dateTime.month}:${dateTime.year}";
  }
}
