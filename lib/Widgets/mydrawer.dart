import 'package:flutter/material.dart';
import '/Config/config.dart';

import '/Screen/contactus.dart';
import '/Screen/home.dart';

import '/Screen/myorders.dart';
import '/Screen/profile.dart';
import '/Widgets/color.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Image.network(
            "https://i.ibb.co/0tHHKNg/Plan.png",
            fit: BoxFit.cover,
          )),
          ListTile(
            leading: Icon(
              Icons.home,
              color: valhalla,
            ),
            title: Text("Home"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: valhalla,
            ),
            title: Text("Profile"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profie()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.food_bank,
              color: valhalla,
            ),
            title: Text("My Orders"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyOrder()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: valhalla,
            ),
            title: Text("Contact Us"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: valhalla,
            ),
            title: Text("Logout"),
            onTap: () async {
              await EcommerceApp.sharedPreferences.remove(EcommerceApp.userUID);
              await EcommerceApp.sharedPreferences
                  .remove(EcommerceApp.userEmail);
              await EcommerceApp.sharedPreferences
                  .remove(EcommerceApp.userpassword);
              await EcommerceApp.sharedPreferences
                  .remove(EcommerceApp.userName);
              await EcommerceApp.sharedPreferences
                  .remove(EcommerceApp.userAvatarUrl);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/auth', (Route<dynamic> route) => false);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Logout successfully"),
              ));
            },
          ),
        ],
      ),
    );
  }
}
