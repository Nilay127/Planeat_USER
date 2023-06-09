import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:new_tiffin_user/Authentication/login.dart';
import '/Authentication/authentication.dart';
import '/Config/config.dart';
import '/Screen/home.dart';

import '/Screen/ordering/completed.dart';
import '/Screen/ordering/neworder.dart';
import '/Screen/ordering/preparing.dart';
import '/Screen/profile.dart';
import '/Widgets/color.dart';
import '/Widgets/loadingWidget.dart';

import '/Widgets/mydrawer.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text("My Orders",
              style: TextStyle(
                color: valhalla,
              )),
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Container(
            decoration: new BoxDecoration(color: carrotOrange),
          ),
        ),
        drawer: MyDrawer(),
        body: Container(
          child: ContainedTabBarView(
            tabs: [
              Tab(
                icon: Icon(Icons.menu_open),
                text: "New Order",
              ),
              Tab(
                icon: Icon(Icons.restaurant),
                text: "Preparing",
              ),
              Tab(
                icon: Icon(Icons.local_restaurant),
                text: "Complete / Cancel",
              ),
            ],
            tabBarProperties: TabBarProperties(
              height: 70.0,
              background: Container(
                decoration: BoxDecoration(color: carrotOrange),
              ),
              indicatorColor: valhalla,
              indicatorWeight: 6.0,
              labelColor: valhalla,
              unselectedLabelColor: solitude,
            ),
             views: [NewOrder(), Preparing(), Completed()],
            
            onChange: (index) => print(index),
          ),
        )
        // StreamBuilder<QuerySnapshot>(
        //   stream: Firestore.instance.collection("Orders").snapshots(),
        //   builder: (context, dataSnapshot) {
        //     if (!dataSnapshot.hasData) {
        //       return Container(
        //         child: Center(
        //           child: circularProgress(),
        //         ),
        //       );
        //     } else {
        //       return SingleChildScrollView(
        //         child: Container(
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                   "Present Orders",
        //                   style: TextStyle(
        //                       color: valhalla,
        //                       fontSize: 20.0,
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Column(
        //                 children: [
        //                   for (var i = 0;
        //                       i < dataSnapshot.data.documents.length;
        //                       i++)
        //                     dataSnapshot.data.documents[i].data['c_id'] ==
        //                             EcommerceApp.sharedPreferences
        //                                 .getString(EcommerceApp.userUID)
        //                         ? Card(
        //                             child: InkWell(
        //                               child: Column(
        //                                 children: [
        //                                   Row(
        //                                     children: [
        //                                       Padding(
        //                                         padding:
        //                                             const EdgeInsets.all(8.0),
        //                                         child: Image.network(
        //                                           dataSnapshot.data.documents[i]
        //                                               .data['kitchen_image'],
        //                                           height: 50.0,
        //                                           width: 50.0,
        //                                           fit: BoxFit.cover,
        //                                         ),
        //                                       ),
        //                                       Column(
        //                                         crossAxisAlignment:
        //                                             CrossAxisAlignment.start,
        //                                         children: [
        //                                           Text(
        //                                             dataSnapshot.data.documents[i]
        //                                                 .data['sp_name'],
        //                                             style: TextStyle(
        //                                                 color: tyrianPurple,
        //                                                 fontSize: 20.0,
        //                                                 fontWeight:
        //                                                     FontWeight.bold),
        //                                           ),
        //                                           Text(dataSnapshot
        //                                               .data
        //                                               .documents[i]
        //                                               .data['sp_address']),
        //                                           Text(
        //                                             '\$' +
        //                                                 dataSnapshot
        //                                                         .data
        //                                                         .documents[i]
        //                                                         .data[
        //                                                     'order_totalprice'],
        //                                             style: TextStyle(
        //                                                 fontWeight:
        //                                                     FontWeight.bold,
        //                                                 fontSize: 17.0),
        //                                           )
        //                                         ],
        //                                       ),
        //                                       SizedBox(
        //                                         width: screenwidth / 10,
        //                                       ),
        //                                       dataSnapshot.data.documents[i]
        //                                                   .data['order_status'] ==
        //                                               "1"
        //                                           ? Padding(
        //                                               padding:
        //                                                   const EdgeInsets.only(
        //                                                       left: 0.0),
        //                                               child: Column(
        //                                                 crossAxisAlignment:
        //                                                     CrossAxisAlignment
        //                                                         .start,
        //                                                 children: [
        //                                                   Text("Order Status"),
        //                                                   Text("New")
        //                                                 ],
        //                                               ),
        //                                             )
        //                                           : dataSnapshot.data.documents[i]
        //                                                           .data[
        //                                                       'order_status'] ==
        //                                                   "2"
        //                                               ? Padding(
        //                                                   padding:
        //                                                       const EdgeInsets
        //                                                               .only(
        //                                                           left: 0.0),
        //                                                   child: Column(
        //                                                     crossAxisAlignment:
        //                                                         CrossAxisAlignment
        //                                                             .start,
        //                                                     children: [
        //                                                       Text(
        //                                                           "Order Status"),
        //                                                       Text("Accepted and Preparing")
        //                                                     ],
        //                                                   ),
        //                                                 )
        //                                               : dataSnapshot
        //                                                               .data
        //                                                               .documents[i]
        //                                                               .data[
        //                                                           'order_status'] ==
        //                                                       "3"
        //                                                   ? Padding(
        //                                                       padding:
        //                                                           const EdgeInsets
        //                                                                   .only(
        //                                                               left: 0.0),
        //                                                       child: Column(
        //                                                         crossAxisAlignment:
        //                                                             CrossAxisAlignment
        //                                                                 .start,
        //                                                         children: [
        //                                                           Text(
        //                                                               "Order Status"),
        //                                                           Text("Rejected")
        //                                                         ],
        //                                                       ),
        //                                                     )
        //                                                   : dataSnapshot
        //                                                                   .data
        //                                                                   .documents[
        //                                                                       i]
        //                                                                   .data[
        //                                                               'order_status'] ==
        //                                                           "4"
        //                                                       ? Padding(
        //                                                           padding:
        //                                                               const EdgeInsets
        //                                                                       .only(
        //                                                                   left:
        //                                                                       0.0),
        //                                                           child: Column(
        //                                                             crossAxisAlignment:
        //                                                                 CrossAxisAlignment
        //                                                                     .start,
        //                                                             children: [
        //                                                               Text(
        //                                                                   "Order Status"),
        //                                                               Text(
        //                                                                   "Out For Delivery")
        //                                                             ],
        //                                                           ),
        //                                                         )
        //                                                       : dataSnapshot
        //                                                                   .data
        //                                                                   .documents[
        //                                                                       i]
        //                                                                   .data['order_status'] ==
        //                                                               "5"
        //                                                           ? Padding(
        //                                                               padding: const EdgeInsets
        //                                                                       .only(
        //                                                                   left:
        //                                                                       0.0),
        //                                                               child:
        //                                                                   Column(
        //                                                                 crossAxisAlignment:
        //                                                                     CrossAxisAlignment
        //                                                                         .start,
        //                                                                 children: [
        //                                                                   Text(
        //                                                                       "Order Status"),
        //                                                                   Text(
        //                                                                       "Delivered")
        //                                                                 ],
        //                                                               ),
        //                                                             )
        //                                                           : Padding(
        //                                                               padding: const EdgeInsets
        //                                                                       .only(
        //                                                                   left:
        //                                                                       0.0),
        //                                                               child:
        //                                                                   Column(
        //                                                                 crossAxisAlignment:
        //                                                                     CrossAxisAlignment
        //                                                                         .start,
        //                                                                 children: [
        //                                                                   Text(
        //                                                                       "Order Status"),
        //                                                                   Text(
        //                                                                       "Delivered")
        //                                                                 ],
        //                                                               ),
        //                                                             )
        //                                     ],
        //                                   ),
        //                                   Column(
        //                                       crossAxisAlignment:
        //                                           CrossAxisAlignment.start,
        //                                       children: [
        //                                         Text(
        //                                             "----------------------------------------------------------------------------"),
        //                                         Text(dataSnapshot
        //                                             .data
        //                                             .documents[i]
        //                                             .data['order_itemtitle']),
        //                                         Text(dataSnapshot.data
        //                                                     .documents[i].data[
        //                                                 'order_itemdescription'] +
        //                                             ' * ' +
        //                                             dataSnapshot.data.documents[i]
        //                                                 .data['quantity']
        //                                                 .toString())
        //                                       ]),
        //                                 ],
        //                               ),
        //                             ),
        //                           )
        //                         : Text("")
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     }
        //   },
        // ),
        );
  }
}
