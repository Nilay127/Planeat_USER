import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '/Config/menumodel.dart';
import '/Screen/home.dart';
import '/Screen/ordering/order.dart';

import '/Widgets/color.dart';
import '/Widgets/loadingWidget.dart';

class ProviderDetail extends StatefulWidget {
  final Menumodel? model;
  ProviderDetail({this.model});

  @override
  _ProviderDetailState createState() => _ProviderDetailState();
}

var date = DateTime.now();
String dropdownValue = DateFormat('EEEE').format(date);
// String dropdownValue = "Monday";
var dinnermodel;
var lunchmodel;
late DocumentSnapshot lunch;
late DocumentSnapshot dinner;
String a = "Lunch";
String b = "Dinner";
late int x;
var menuitem;

class _ProviderDetailState extends State<ProviderDetail> {
  getdatalunch() async {
    lunch = await FirebaseFirestore.instance
        .collection('weeklymenu')
        .doc(widget.model!.uid + a + dropdownValue)
        .get();

    setState(() {
      lunchmodel = lunch.data() as Map<String, dynamic>;
    });
  }

  getdatadinner() async {
    dinner = await FirebaseFirestore.instance
        .collection('weeklymenu')
        .doc(widget.model!.uid + b + dropdownValue)
        .get();

    setState(() {
      dinnermodel = dinner.data() as Map<String, dynamic>;
    });
  }

  getorderdata() async {
    menuitem = await FirebaseFirestore.instance
        .collection('serviceprovider')
        .doc(widget.model!.uid)
        .collection("dailymenu")
        .snapshots();

    // var temp = new List();

    // checkitem = menuitem.documents.map((doc) => temp.add(doc.data)).toList();

    // print(temp);
  }

  @override
  void initState() {
    // TODO: implement initState
    getdatadinner();
    getdatalunch();
    getorderdata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
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
          "Tiffin Details",
          style: TextStyle(color: valhalla),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          widget.model!.url,
                          fit: BoxFit.cover,
                          width: screenwidth / 3.5,
                          height: screenwidth / 3.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model!.kitchenName,
                            style: TextStyle(
                                color: tyrianPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.model!.address,
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ),
                          widget.model!.available == true
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Available",
                                    style: TextStyle(
                                        color: green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Not Available",
                                    style: TextStyle(
                                        color: red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                          widget.model!.avg_rating != null
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: SmoothStarRating(
                                    rating: widget.model!.avg_rating,
                                    isReadOnly: true,
                                    color: tyrianPurple,
                                    borderColor: tyrianPurple,
                                  ))
                              : Text(""),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              widget.model!.available == true
                  ? Column(
                      children: [
                        lunchmodel == null && dinnermodel == null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: screenwidth,
                                  decoration: BoxDecoration(
                                      color: tyrianPurple,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                     "Not Taking Orders",
                                      style: TextStyle(
                                          color: white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : lunchmodel != null && dinnermodel != null
                                ? lunchmodel['status'] == true &&
                                        dinnermodel['status'] == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: screenwidth,
                                          decoration: BoxDecoration(
                                              color: tyrianPurple,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Orders(
                                                          lunchmodel:
                                                              lunchmodel,
                                                          dinnermodel:
                                                              dinnermodel,
                                                          kitchen: widget.model,
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              "Order Now",
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : lunchmodel['status'] == true &&
                                            dinnermodel['status'] == false
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenwidth,
                                              decoration: BoxDecoration(
                                                  color: tyrianPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Orders(
                                                              lunchmodel:
                                                                  lunchmodel,
                                                              kitchen:
                                                                  widget.model,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                "Order Now",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : lunchmodel['status'] == false &&
                                                dinnermodel['status'] == true
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: screenwidth,
                                                  decoration: BoxDecoration(
                                                      color: tyrianPurple,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Orders(
                                                                      dinnermodel:
                                                                          dinnermodel,
                                                                      kitchen:
                                                                          widget
                                                                              .model,
                                                                    )),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Order Now",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: screenwidth,
                                                  decoration: BoxDecoration(
                                                      color: tyrianPurple,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Not Taking Orders",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                : lunchmodel == null && dinnermodel != null
                                    ? dinnermodel['status'] == true
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenwidth,
                                              decoration: BoxDecoration(
                                                  color: tyrianPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Orders(
                                                              dinnermodel:
                                                                  dinnermodel,
                                                              kitchen:
                                                                  widget.model,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                 "Order Now",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenwidth,
                                              decoration: BoxDecoration(
                                                  color: tyrianPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                 "Not Taking Orders",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                    : lunchmodel['status'] == true
                                        ? Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenwidth,
                                              decoration: BoxDecoration(
                                                  color: tyrianPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Orders(
                                                              lunchmodel:
                                                                  lunchmodel,
                                                              kitchen:
                                                                  widget.model,
                                                            )),
                                                  );
                                                },
                                                child: Text(
                                                  "Order Now",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: screenwidth,
                                              decoration: BoxDecoration(
                                                  color: tyrianPurple,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Not Taking Orders",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     color: tyrianPurple,
                        //     child: Text(
                        //       "Pre Book / Subscribe",
                        //       style: TextStyle(
                        //           color: valhalla,
                        //           fontSize: 20.0,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: screenwidth,
                        decoration: BoxDecoration(
                            color: tyrianPurple,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Not Taking Orders",
                            style: TextStyle(
                                color: white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 10.0, bottom: 10.0, top: 10.0),
                child: Text(
                  "Today's Special Menu",
                  style: TextStyle(
                      color: valhalla,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidth - 75.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: valhalla, width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5.0,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 8.0,
                                      bottom: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Text(
                                      dropdownValue + ' ' + ' ' + "Lunch",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: valhalla),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, bottom: 8.0),
                                    child: lunchmodel == null ||
                                            lunchmodel['status'] == false
                                        ? Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Image.network(
                                                    'https://icon-library.com/images/no-data-icon/no-data-icon-10.jpg',
                                                    height: screenwidth / 5,
                                                    width: screenwidth / 5,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Text(
                                                  "Will Update soon",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      lunchmodel[
                                                          'thumbnailUrl'],
                                                      fit: BoxFit.cover,
                                                      height: screenwidth / 5,
                                                      width: screenwidth / 5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenwidth / 20,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          lunchmodel['title'],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0,
                                                              color: valhalla),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          lunchmodel[
                                                              'Description'],
                                                          style: TextStyle(
                                                              fontSize: 17.0),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        '\$' +
                                                            lunchmodel['price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0,
                                                            color: valhalla),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenwidth - 75.0,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: valhalla, width: 1),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5.0,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 8.0,
                                      bottom: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Text(
                                      dropdownValue + ' ' + ' ' + "Dinner",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          color: valhalla),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, bottom: 8.0),
                                    child: dinnermodel == null ||
                                            dinnermodel['status'] == false
                                        ? Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Image.network(
                                                    'https://icon-library.com/images/no-data-icon/no-data-icon-10.jpg',
                                                    height: screenwidth / 5,
                                                    width: screenwidth / 5,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                Text(
                                                  "Will Update soon",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      dinnermodel[
                                                          'thumbnailUrl'],
                                                      fit: BoxFit.cover,
                                                      height: screenwidth / 5,
                                                      width: screenwidth / 5,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenwidth / 20,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          dinnermodel['title'],
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0,
                                                              color: valhalla),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.0,
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          dinnermodel[
                                                              'Description'],
                                                          style: TextStyle(
                                                              fontSize: 17.0),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        '\$' +
                                                            dinnermodel['price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0,
                                                            color: valhalla),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 10.0, bottom: 10.0, top: 10.0),
                child: Text(
                 "Other Items",
                  style: TextStyle(
                      color: valhalla,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('serviceprovider')
                    .doc(widget.model!.uid)
                    .collection("dailymenu")
                    .orderBy("publishedDate", descending: true)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  if (!dataSnapshot.hasData) {
                    return circularProgress();
                  } else {
                    return Column(
                      children: [
                        for (int i = 0;
                            i < dataSnapshot.data!.docs.length;
                            i++)
                          dataSnapshot.data!.docs[i]['status'] == true
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: screenwidth,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    dataSnapshot
                                                        .data!
                                                        .docs[i]
                                                        ['thumbnailUrl'],
                                                    height: screenwidth / 5,
                                                    width: screenwidth / 5,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: screenwidth / 2.3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dataSnapshot
                                                            .data!
                                                            .docs[i]
                                                            ['title'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0),
                                                      ),
                                                      SizedBox(
                                                        height: 2.0,
                                                      ),
                                                      Text(
                                                        dataSnapshot
                                                                .data!
                                                                .docs[i]
                                                                [
                                                            'Description'],
                                                        style: TextStyle(
                                                            fontSize: 17.0),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        softWrap: true,
                                                      ),
                                                      SizedBox(
                                                        height: 2.0,
                                                      ),
                                                      Text(
                                                        '\$' +
                                                            dataSnapshot
                                                                .data!
                                                                .docs[i]
                                                                ['price']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(padding: EdgeInsets.all(0.0)),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
