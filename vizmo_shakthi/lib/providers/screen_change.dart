import 'package:flutter/material.dart';

class PageChange extends ChangeNotifier {
  var pageNo = 0;

  int get getPageNo {
    print(pageNo);
    return pageNo;
  }

  void changeScreen(int i) {
    print("chaned");
    pageNo = i;
    notifyListeners();
  }
}
