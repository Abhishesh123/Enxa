import 'package:enxa/Start/Login.dart';
import 'package:enxa/values/gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:enxa/values/customColor.dart';

class NavDrawer extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(color: customColor.dark_back,
            child: (ListView(
              padding: EdgeInsets.zero,

              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 100),
                  color: customColor.dark_back,
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color:customColor.dark_back,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: customColor.white,),
                    accountName: Text('Satya Shukla'),
                    accountEmail: Text('satyabratshshukla@gmail.com'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.input,color: Colors.white,),
                  title: Text('Welcome',style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    )),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(Icons.verified_user,color: Colors.white,),

                  title: Text('Profile',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.settings,color: Colors.white,),
                  title: Text('Settings',style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                  onTap: () => {Navigator.of(context).pop()},
                ),

                ListTile(
                    leading: Icon(Icons.exit_to_app,color: Colors.white,),
                    title: Text('Logout',style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    )),
                  onTap: ()async{
                    await Gen.setUser("0");
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return Login();
                    }));
                  },
                ),
              ],
            )),
          ),
    );

  }

}
