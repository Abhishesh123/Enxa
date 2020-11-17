import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxa/ui/components/pie_chart.dart';
import 'package:enxa/ui/components/reusable_components.dart';
import 'package:enxa/ui/pages/charginghistory.dart';
import 'package:enxa/ui/pages/home.dart';
import 'package:enxa/values/constant.dart';
import 'package:enxa/values/customColor.dart';
import 'package:enxa/values/gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_money.dart';

class ChargingH extends StatefulWidget {

  @override
  _ChargingHState createState() => _ChargingHState();
}

class _ChargingHState extends State<ChargingH> {
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
      tag: "Charging Activity",
      child: Material(
        color: Colors.white,
        child: Scaffold(
          body: Container(

            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            alignment: Alignment.topCenter,
            color: customColor.dark_back,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CText("Charging Activity", 22,color: customColor.white),

                  CText("MAR", 18,color: customColor.white,contentPadding: const EdgeInsets.all(20.0)),
                  CPieChart(dataMap: {"24 Public":10,"0 Home":0,},colors: [Colors.deepOrangeAccent[400].withOpacity(0.6),Colors.lightBlue],),


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

          Expanded(
          child:Column(

                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Text("Session Started 5:05 pm",style: GoogleFonts.muli(color: customColor.white),overflow: TextOverflow.ellipsis,),
                  Text("Duration :15 mins",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),overflow: TextOverflow.ellipsis,),
                ],
              ),
          ),
        Expanded(
        child:
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Date : October 18,2020",style: GoogleFonts.muli(color: customColor.white),overflow: TextOverflow.ellipsis,),
                  Text("Energy Added :6KWh(CCS)",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),overflow: TextOverflow.ellipsis,),
                ],
              ),
        ),

        Expanded(
        child:Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Cost :Rs 4",style: GoogleFonts.muli(color: customColor.white),overflow: TextOverflow.ellipsis,),
                  Text("Distance Added :13kms",style: GoogleFonts.muli(color: customColor.darkgrey,fontSize: 13),overflow: TextOverflow.ellipsis,),
                ],
              )
        ),
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
