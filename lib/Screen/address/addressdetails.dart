import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/Config/config.dart';
import '/Config/menumodel.dart';
import '/Screen/address/addaddress.dart';
import '/Screen/address/editaddress.dart';
import '/Screen/ordering/checkout.dart';
import '/Widgets/color.dart';

class UpdateAddress extends StatefulWidget {
  @override
  _UpdateAddressState createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  @override
  Stream<QuerySnapshot> a = FirebaseFirestore.instance
      .collection("Users")
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .collection('address')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
          .collection('address')
          .snapshots(),
      builder: (context, dataSnapshot) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Container(
                decoration: new BoxDecoration(color: carrotOrange),
              ),
              title: Text(
                "Your Address",
                style: TextStyle(color: valhalla),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dataSnapshot.hasData)
                      for (var i = 0; i < dataSnapshot.data!.docs.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: screenwidth,
                            child: Card(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0, right: 10.0),
                                        child: Text(
                                          dataSnapshot.data!.docs[i]['title'],
                                          style: TextStyle(
                                              color: tyrianPurple,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0, right: 10.0),
                                        child: Text(
                                          dataSnapshot.data!.docs[i]
                                                  ['flatnumber'] +
                                              ' , ' +
                                              dataSnapshot.data!.docs[i]
                                                  ['area'] +
                                              ' , ' +
                                              dataSnapshot.data!.docs[i]
                                                  ['city'] +
                                              ' , ' +
                                              dataSnapshot.data!.docs[i]
                                                  ['state'],
                                          style: TextStyle(
                                            color: valhalla,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0, right: 10.0),
                                        child: Text(
                                          " 📞 " +
                                              dataSnapshot.data!.docs[i]
                                                  ['phone no'],
                                          style: TextStyle(
                                            color: valhalla,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: screenwidth / 3,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                      color: tyrianPurple,
                                                      width: 1.0)),
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditAddress(
                                                                model: dataSnapshot
                                                                        .data!
                                                                        .docs[i]
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>,
                                                              )),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        fontSize: 15.0),
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: screenwidth / 3,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                      color: red, width: 1.0)),
                                              child: TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (c) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "Are you sure you want to delete"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "Users")
                                                                      .doc(EcommerceApp
                                                                          .sharedPreferences
                                                                          .getString(EcommerceApp
                                                                              .userUID))
                                                                      .collection(
                                                                          "address")
                                                                      .doc(dataSnapshot
                                                                          .data!
                                                                          .docs[
                                                                              i]
                                                                          .id)
                                                                      .delete();
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    content: Text(
                                                                        "Address Deleted"),
                                                                  ));
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                      "Yes"),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                      "No"),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        fontSize: 15.0),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: tyrianPurple,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextButton(
                          onPressed: () {
                            Route route =
                                MaterialPageRoute(builder: (_) => AddAddress());
                            Navigator.pushReplacement(context, route);
                          },
                          child: Center(
                            child: Text(
                              "Add Address",
                              style: TextStyle(
                                  color: white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
