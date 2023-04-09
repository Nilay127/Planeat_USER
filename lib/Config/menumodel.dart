import 'dart:convert';

Menumodel menumodelFromJson(String str) => Menumodel.fromJson(json.decode(str));

String menumodelToJson(Menumodel data) => json.encode(data.toJson());

class Menumodel {
  Menumodel(
      {required this.url,
      required this.address,
      required this.email,
      required this.kitchenName,
      required this.phoneNo,
      required this.uid,
      required this.avg_rating,
      required this.available});

  String url;
  String address;
  String email;
  String kitchenName;
  String phoneNo;
  String uid;
  bool available;
  double avg_rating;

  factory Menumodel.fromJson(Map<String, dynamic> json) => Menumodel(
      url: json["url"],
      address: json["Address"],
      email: json["email"],
      kitchenName: json["Kitchen Name"],
      phoneNo: json["Mobile_no"],
      uid: json["uid"],
      avg_rating: json["Avg_rating"],
      available: json["available"]);

  Map<String, dynamic> toJson() => {
        "url": url,
        "Address": address,
        "email": email,
        "Kitchen Name": kitchenName,
        "Mobile_no": phoneNo,
        "available": available,
        "avg_rating": avg_rating
      };
}
