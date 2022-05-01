// import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modals/employee_data.dart';

class EmployeesProvider extends ChangeNotifier {
  List<EmployeeData> _employees = [];
  int companyId = 0, _pageNo = 1;
  String params = "?limit=10", _searchString = "", _sortString = "name";

  EmployeesProvider() {
    getEmployees();
  }

  Future getEmployees() async {
    // APIHelpers helpers = APIHelpers();

    var url = Uri.parse(
        'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee' +
            params +
            "&page=" +
            _pageNo.toString() +
            "&search=" +
            _searchString +
            "&sortBy=" +
            _sortString +
            "&order=asc");
    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();
    print(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      return;
    }

    String empString = await response.stream.bytesToString();
    var empTemp = jsonDecode(empString);
    print(empString);
    List<EmployeeData> employees = [];

    List employeeCollection = empTemp;

    for (var c in employeeCollection) {
      EmployeeData eachEmployee = EmployeeData(
          int.parse(c["id"]),
          c["name"],
          c["avatar"],
          c["email"],
          c["phone"],
          c["country"],
          c["birthday"],
          c["createdAt"],
          c["department"]);
      employees.add(eachEmployee);
    }

    setEmployee(employees);
  }

  void changeParams(String pms) {
    print("chaned" + pms);
    _employees = [];
    params = pms;
    getEmployees();
  }

  void changePage(int pageno) {
    print("chaned" + pageno.toString());
    _employees = [];
    notifyListeners();
    _pageNo = pageno;
    getEmployees();
  }

  void changeSort(String sort) {
    print("chaned" + sort.toString());
    _employees = [];
    notifyListeners();
    _sortString = sort;
    getEmployees();
  }

  void changeSearch(String search) {
    print("chaned" + search.toString());
    _employees = [];
    notifyListeners();
    _searchString = search;
    getEmployees();
  }

  List<EmployeeData> get employees {
    if (_employees == null) {
      return [];
    }
    return _employees;
  }

  int get currentPage {
    return _pageNo;
  }

  String get currentSearch {
    return _searchString;
  }

  String get currentSort {
    return _sortString;
  }

  void setEmployee(List<EmployeeData> employees) {
    _employees = employees;
    notifyListeners();
  }
}
