import 'package:flutter/foundation.dart';

class GoogleFormObj {
  String formLink;
  String formName;
  String formCreatedAt;

  GoogleFormObj(
      {@required this.formLink, @required this.formName, this.formCreatedAt});

  GoogleFormObj.fromJson(jsonObj) {
    this.formLink = jsonObj['link'];
    //this.formLink = this.formLink.replaceAll('viewform', 'edit');

    this.formName = jsonObj['title'];
    this.formCreatedAt = jsonObj['createdAt'];
  }
}
