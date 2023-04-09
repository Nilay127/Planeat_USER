import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Config/config.dart';
import '/Widgets/color.dart';
import '/Widgets/loadingWidget.dart';
import 'orderdetails.dart';

class NewOrder extends StatefulWidget {
  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController _reason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Orders")
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Container(
            child: Center(
              child: circularProgress(),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: dataSnapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Present Orders",
                    //     style: TextStyle(
                    //         color: valhalla,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Column(
                      children: [
                        dataSnapshot.data!.docs[i]['c_id'] ==
                                EcommerceApp.sharedPreferences
                                    .getString(EcommerceApp.userUID)
                            ? dataSnapshot.data!.docs[i]
                                        ['order_status'] ==
                                    '1'
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      width: screenwidth,
                                      child: Card(
                                        elevation: 4.0,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail(
                                                        order: dataSnapshot.data
                                                            !.docs[i].data() as Map<String, dynamic>,
                                                        id: dataSnapshot
                                                            .data
                                                            !.docs[i]
                                                            .id,
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                       "Order ID: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17.0),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: screenwidth / 1.7,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0,
                                                                top: 8.0,
                                                                bottom: 8.0),
                                                        child: Text(
                                                          dataSnapshot
                                                              .data
                                                              !.docs[i]
                                                              .id,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          softWrap: true,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17.0),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                          dataSnapshot
                                                                  .data
                                                                  !.docs[i]
                                                                  [
                                                              'kitchen_image'],
                                                          height:
                                                              screenwidth / 3.5,
                                                          width:
                                                              screenwidth / 3.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 8.0,
                                                        ),
                                                        child: Container(
                                                          width:
                                                              screenwidth / 1.8,
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Wrap(
                                                                  children: [
                                                                    for (int j =
                                                                            0;
                                                                        j < dataSnapshot.data!.docs[i]['order_item'].length;
                                                                        j++)
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          dataSnapshot.data!.docs[i]['order_item'][j]['order_itemtitle'] +
                                                                              ", ",
                                                                          style: TextStyle(
                                                                              color: tyrianPurple,
                                                                              fontSize: 17.0,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    "Sold by : " +
                                                                        dataSnapshot
                                                                            .data
                                                                            !.docs[i]
                                                                            ['sp_name'],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    softWrap:
                                                                        true,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    '\$' +
                                                                        dataSnapshot
                                                                            .data
                                                                            !.docs[i]
                                                                            ['order_totalprice']
                                                                            .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                   "Order Status" +
                                                                        " : " +
                                                                       "Placed",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    DateFormat.yMMMd().add_jm().format(DateTime.parse(dataSnapshot
                                                                        .data
                                                                        !.docs[
                                                                            i]
                                                                        [
                                                                            'publishedDate']
                                                                        .toDate()
                                                                        .toString())),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: valhalla,
                                                            width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (c) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                         "Reason For Cancellation"),
                                                                      content:
                                                                          TextField(
                                                                        controller:
                                                                            _reason,
                                                                        decoration:
                                                                            InputDecoration(hintText:"Reason :"),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            FirebaseFirestore.instance.collection('Orders').doc(dataSnapshot.data!.docs[i].id).update({
                                                                              "order_status": "3",
                                                                              "rejection_reason": _reason.text + "- By Customer"
                                                                            });

                                                                            Navigator.pop(c);
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              content: Text("Order is Cancelled"),
                                                                            ));
                                                                          },
                                                                          child:
                                                                              Text("Confirm Rejection"),
                                                                        )
                                                                      ],
                                                                    ));
                                                      },
                                                      child: Text(
                                                       "Cancel Order",
                                                        style: TextStyle(
                                                            color: valhalla),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                : Text("")
                            : Text("")
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
