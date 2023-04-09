import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '/Authentication/authentication.dart';
import '/Config/config.dart';

import '/Screen/myorders.dart';
import '/Screen/providerdetail.dart';
import '/Widgets/loadingWidget.dart';
import '/Widgets/mydrawer.dart';
import '../Widgets/color.dart';
import '../Config/menumodel.dart';
import './profile.dart';

var width;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late QuerySnapshot querySnapshot;
  var a;
  // Future getDocs() async {
  //   querySnapshot =
  //       await Firestore.instance.collection("serviceprovider").getDocuments();

  //   // for (int i = 0; i < querySnapshot.documents.length; i++) {
  //   //   var a = querySnapshot.documents[i];
  //   //   var b = a.data;
  //   //   print(a.documentID);
  //   //   print(b['Address']);
  //   // }
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text("Home Screen",
              style: TextStyle(
                color: valhalla,
              )),
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Container(
            decoration: new BoxDecoration(color: carrotOrange),
          ),
        ),
        drawer: MyDrawer(),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("serviceprovider")
              .snapshots(),
          builder: (context, dataSnapshot) {
            if (!dataSnapshot.hasData) {
              return Container(
                child: Center(
                  child: circularProgress(),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                    child: Text(
                      "Top Tiffin Provider",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: valhalla),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dataSnapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    dataSnapshot.data!.docs[i]['available'] ==
                                            true
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: valhalla,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                elevation: 5.0,
                                                child: InkWell(
                                                  onTap: () {
                                                    var a = Menumodel.fromJson(
                                                        dataSnapshot
                                                                .data!.docs[i]
                                                                .data()
                                                            as Map<String,
                                                                dynamic>);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProviderDetail(
                                                                model: a,
                                                              )),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              dataSnapshot.data!
                                                                      .docs[i]['url'],
                                                              fit: BoxFit.cover,
                                                              width:
                                                                  screenwidth /
                                                                      4,
                                                              height:
                                                                  screenwidth /
                                                                      4,
                                                            ),
                                                          ),
                                                        ),
                                                        
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                dataSnapshot
                                                                        .data!
                                                                        .docs[i]
                                                                    [
                                                                    'Kitchen Name'],
                                                                style: TextStyle(
                                                                    color:
                                                                        tyrianPurple,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17.0),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  dataSnapshot
                                                                          .data!
                                                                          .docs[i]
                                                                      [
                                                                      'Address'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  "Available",
                                                                  style: TextStyle(
                                                                      color:
                                                                          green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15.0),
                                                                ),
                                                              ),
                                                              // dataSnapshot.data!.docs[
                                                              //                 i][
                                                              //             'Avg_rating'] !=
                                                              //         null
                                                              //     ? Padding(
                                                              //         padding: const EdgeInsets
                                                              //                 .only(
                                                              //             top:
                                                              //                 4.0),
                                                              //         child:
                                                              //             SmoothStarRating(
                                                              //           rating: dataSnapshot
                                                              //               .data!
                                                              //               .docs[i]['Avg_rating'],
                                                              //           color:
                                                              //               tyrianPurple,
                                                              //           isReadOnly:
                                                              //               true,
                                                              //           borderColor:
                                                              //               tyrianPurple,
                                                              //         ))
                                                              //     : Text(""),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: valhalla,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                elevation: 5.0,
                                                child: InkWell(
                                                  onTap: () {
                                                    var a = Menumodel.fromJson(
                                                        dataSnapshot
                                                                .data!.docs[i]
                                                                .data()
                                                            as Map<String,
                                                                dynamic>);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProviderDetail(
                                                                model: a,
                                                              )),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                ColorFiltered(
                                                              colorFilter: ColorFilter.mode(
                                                                  Colors.black
                                                                      .withOpacity(
                                                                          0.7),
                                                                  BlendMode
                                                                      .saturation),
                                                              child:
                                                                  Image.network(
                                                                dataSnapshot
                                                                        .data!
                                                                        .docs[i]
                                                                    ['url'],
                                                                fit: BoxFit
                                                                    .cover,
                                                                width:
                                                                    screenwidth /
                                                                        4,
                                                                height:
                                                                    screenwidth /
                                                                        4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                dataSnapshot
                                                                        .data!
                                                                        .docs[i]
                                                                    [
                                                                    'Kitchen Name'],
                                                                style: TextStyle(
                                                                    color:
                                                                        tyrianPurple,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        17.0),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  dataSnapshot
                                                                          .data!
                                                                          .docs[i]
                                                                      [
                                                                      'Address'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17.0),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            8.0),
                                                                child: Text(
                                                                  "Not Available",
                                                                  style: TextStyle(
                                                                      color:
                                                                          red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15.0),
                                                                ),
                                                              ),
                                                              // dataSnapshot.data!.docs[
                                                              //                 i][
                                                              //             'Avg_rating'] !=
                                                              //         null
                                                              //     ? Padding(
                                                              //         padding: const EdgeInsets
                                                              //                 .only(
                                                              //             top:
                                                              //                 4.0),
                                                              //         child:
                                                              //             SmoothStarRating(
                                                              //           rating: dataSnapshot
                                                              //               .data!
                                                              //               .docs[i]['Avg_rating'],
                                                              //           color:
                                                              //               tyrianPurple,
                                                              //           isReadOnly:
                                                              //               true,
                                                              //           borderColor:
                                                              //               tyrianPurple,
                                                              //         ))
                                                              //     : Text(""),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );

              // SingleChildScrollView(
              //   child:
              // );
            }
          },
        )

        // SingleChildScrollView(
        //   child: Container(
        //     child: Center(
        //       child: Column(
        //         children: [

        //           for (var i = 0; i < querySnapshot.documents.length; i++)
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Card(
        //                   elevation: 2.0,
        //                   child: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Container(
        //                             decoration: BoxDecoration(
        //                                 border: Border.all(color: tyrianPurple),
        //                                 borderRadius: BorderRadius.circular(4)),
        //                             child: Image.network(
        //                               querySnapshot.documents[i].data['url'],
        //                               fit: BoxFit.cover,
        //                               width: 100.0,
        //                               height: 100.0,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment.spaceEvenly,
        //                             children: [
        //                               Text(
        //                                 querySnapshot
        //                                     .documents[i].data['Kitchen Name'],
        //                                 style: TextStyle(
        //                                     color: tyrianPurple,
        //                                     fontWeight: FontWeight.bold,
        //                                     fontSize: 20.0),
        //                               ),
        //                               Text(querySnapshot
        //                                   .documents[i].data['Address']),
        //                             ],
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   )),
        //             ),
        //         ],
        //       ),
        //     ),
        //   ),
        // )
        );
  }
}
