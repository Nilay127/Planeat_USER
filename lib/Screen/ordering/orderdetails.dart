import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '/Widgets/color.dart';
import 'package:url_launcher/url_launcher.dart';


class OrderDetail extends StatefulWidget {
  final Map<String, dynamic> order;
  final String id;
  OrderDetail({required this.order, required this.id});
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Order",
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Order Details",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID: ",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              Text(
                                widget.id,
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ],
                          ),
                        ),
                        widget.order['order_status'] == '1'
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 8.0, right: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order status" +
                                          ": ",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    Text(
                                      "Placed",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ],
                                ))
                            : widget.order['order_status'] == '2'
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                         "Order status"+
                                              ": ",
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                        Text(
                                          "Preparing",
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                      ],
                                    ))
                                : widget.order['order_status'] == '3'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                right: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Order Status"+
                                                        ": ",
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ),
                                                  Text(
                                                    "Reject",
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                right: 8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Reason : ",
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ),
                                                  Text(
                                                    widget.order[
                                                        'rejection_reason'],
                                                    style: TextStyle(
                                                        fontSize: 17.0),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )
                                    : widget.order['order_status'] == '4'
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Order status"+
                                                      ": ",
                                                  style:
                                                      TextStyle(fontSize: 17.0),
                                                ),
                                                Text(
                                                  "Out for delivery",
                                                  style:
                                                      TextStyle(fontSize: 17.0),
                                                ),
                                              ],
                                            ))
                                        : widget.order['order_status'] == '5'
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    top: 8.0,
                                                    right: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                       "Order status" +
                                                          ": ",
                                                      style: TextStyle(
                                                          fontSize: 17.0),
                                                    ),
                                                    Text(
                                                      "delivered",
                                                      style: TextStyle(
                                                          fontSize: 17.0),
                                                    ),
                                                  ],
                                                ))
                                            : Text(""),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                              right: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 "Payment Status : ",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                                Text(
                                  widget.order['payment_status'],
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8.0,
                              right: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time : ",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                                Text(
                                  DateFormat.yMMMd().add_jm().format(
                                      DateTime.parse(widget
                                          .order['publishedDate']
                                          .toDate()
                                          .toString())),
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ],
                            )),
                        widget.order['order_rating'] != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      top: 8.0,
                                      right: 8.0,
                                    ),
                                    child: Text(
                                      "Order rating",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8.0,
                                      right: 8.0,
                                    ),
                                    child: SmoothStarRating(
                                      rating: widget.order['order_rating'],
                                      isReadOnly: true,
                                      color: tyrianPurple,
                                      borderColor: tyrianPurple,
                                    ),
                                  )
                                ],
                              )
                            : Padding(padding: EdgeInsets.only(top: 8.0)),
                        widget.order['order_review'] != null &&
                                widget.order['order_review'] != ""
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    right: 8.0,
                                    bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Review : ",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    Text(
                                      widget.order['order_review'],
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ],
                                ))
                            : Padding(padding: EdgeInsets.only(top: 8.0)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                           "Item Details",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                          children: [
                            for (int j = 0;
                                j < widget.order['order_item'].length;
                                j++)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        widget.order['order_item'][j]
                                            ['order_itemimage'],
                                        width: screenwidth / 4,
                                        height: screenwidth / 4,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: screenwidth * 0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8.0, right: 8.0),
                                          child: Text(
                                            widget.order['order_item'][j]
                                                ['order_itemtitle'],
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8.0, right: 8.0),
                                          child: Text(
                                            widget.order['order_item'][j]
                                                ['order_itemdescription'],
                                            style: TextStyle(fontSize: 17.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, top: 8.0, right: 8.0),
                                          child: Text(
                                            '\$' +
                                                widget.order['order_item'][j]
                                                        ['order_itemprice']
                                                    .toString(),
                                            style: TextStyle(fontSize: 17.0),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 8.0,
                                              right: 8.0,
                                              bottom: 8.0),
                                          child: Text(
                                          "Qunatity" +
                                                " : " +
                                                widget.order['order_item'][j]
                                                        ['order_itemquantity']
                                                    .toString(),
                                            style: TextStyle(fontSize: 17.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                        widget.order['notes'] == ""
                            ? Text("")
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    top: 8.0,
                                    right: 8.0,
                                    bottom: 8.0),
                                child: Text(
                                 "Note : " +
                                      widget.order['notes'],
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                           "Provider Details",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     child: Image.network(
                            //       widget.order['kitchen_image'],
                            //       width: screenwidth / 4,
                            //       height: screenwidth / 4,
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenwidth * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0, right: 8.0),
                                      child: Text(
                                        widget.order['sp_name'],
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 8.0, right: 8.0),
                                      child: Text(
                                        widget.order['sp_address'],
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '📞 ' + widget.order['sp_phone'],
                                        style: TextStyle(fontSize: 17.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Delivery Details",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Text(
                            widget.order['c_name'],
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Text(
                            widget.order['c_address'],
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            var url = 'tel:+44' + widget.order['c_phone'];
                            if (await canLaunch(url) != null) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            '📞 ' + widget.order['c_phone'],
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Text(
                           "Time Slot : " +
                                widget.order['time_slot'],
                            style: TextStyle(fontSize: 17.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  child: Container(
                    width: screenwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Payment Details",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, right: 8.0),
                              child: Text(
                               "Item Price",
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, right: 8.0),
                              child: Text(
                                '\$'+
                                    (widget.order['order_totalprice'] - 30)
                                        .toString(),
                                style: TextStyle(fontSize: 17.0),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              Text(
                                '\$'+ "30",
                                style: TextStyle(fontSize: 17.0),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(fontSize: 17.0),
                              ),
                              Text(
                                '\$'+
                                    widget.order['order_totalprice'].toString(),
                                style: TextStyle(fontSize: 17.0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
