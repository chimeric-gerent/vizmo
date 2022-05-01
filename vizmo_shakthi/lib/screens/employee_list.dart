import 'package:flutter/material.dart';
import 'package:vizmo_shakthi/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:vizmo_shakthi/modals/employee_data.dart';
import 'package:vizmo_shakthi/screens/employee_detail.dart';
import '../providers/employee_list_provider.dart';
import 'package:page_transition/page_transition.dart';

class EmployeeList extends StatelessWidget {
  EmployeeList({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  Widget searchStrip(EmployeesProvider emPr) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Icon(
              Icons.search,
              color: Colors.black,
              size: 12,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: TextFormField(
                controller: searchController,
                onEditingComplete: () {
                  emPr.changeSearch(searchController.text);
                },
                style: TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  // labelText: "Search By Vendor Name",
                  // labelStyle: TextStyle(
                  //     fontSize: 14, letterSpacing: 1, color: Colors.grey[400]),

                  hintText: "Search By",
                  hintStyle: TextStyle(
                      fontSize: 12, letterSpacing: 1, color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (() {
              emPr.changeSearch("");
            }),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paginationContainer(EmployeesProvider empPr, int length) {
    int currentPage = empPr.currentPage;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              currentPage > 1 || length == 10
                  ? GestureDetector(
                      onTap: (() {
                        empPr.changePage(empPr.currentPage - 1);
                      }),
                      child: const Icon(
                        Icons.arrow_left_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  : Container(),
              Text(
                empPr.currentPage.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              length < 10
                  ? Container()
                  : GestureDetector(
                      onTap: (() {
                        empPr.changePage(empPr.currentPage + 1);
                      }),
                      child: const Icon(
                        Icons.arrow_right_sharp,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white)),
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: DropdownButton<String>(
                  value: empPr.currentSort,
                  // isExpanded: true,
                  hint: const Text("Sort"),
                  style: const TextStyle(
                    color: Color(0xFFB6B7B7),
                    // fontFamily: "Metropolis",
                    fontWeight: FontWeight.normal,
                  ),
                  underline: Container(),
                  onChanged: (String? newValue) {
                    empPr.changeSort(newValue!);
                  },
                  items: ["name", "email", "country", "createdAt"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          // color: Colors.black,
                          color: Color(0xFF939598),

                          // fontFamily: "Metropolis",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget employeeListView(EmployeesProvider employeeListProvider) {
    List<EmployeeData> emp = employeeListProvider.employees;
    return SingleChildScrollView(
      child: Column(
        children: [
          searchStrip(employeeListProvider),
          paginationContainer(employeeListProvider, emp.length),
          emp.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: emp.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    EmployeeData eachEmp = emp[index];
                    return GestureDetector(
                      onTap: (() {
                        Navigator.push(
                            context,
                            PageTransition(
                              alignment: Alignment.bottomCenter,
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: EmployeeDetailPage(
                                employee: eachEmp,
                              ),
                              childCurrent: EmployeeList(),
                            ));
                      }),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Card(
                          color: Constants.secondaryColor,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 75,
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    eachEmp.avatar,
                                    // height: 100,
                                    // width: 80,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          eachEmp.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   "Phone : " + eachEmp.phone,
                                      //   style:
                                      //       const TextStyle(color: Colors.white),
                                      // ),
                                      // Text(
                                      //   "Email : " + eachEmp.email,
                                      //   style:
                                      //       const TextStyle(color: Colors.white),
                                      // ),
                                      // Text(
                                      //   "Departments : " +
                                      //       eachEmp.department.join(","),
                                      //   style:
                                      //       const TextStyle(color: Colors.white),
                                      // ),
                                      // Text(
                                      //   "Country : " + eachEmp.country,
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //     overflow: TextOverflow.ellipsis,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    EmployeesProvider employeeListProvider =
        Provider.of<EmployeesProvider>(context, listen: true);
    return ChangeNotifierProvider.value(
      value: employeeListProvider,
      child: Scaffold(
        backgroundColor: Constants.baseColor,
        appBar: AppBar(
          backgroundColor: Constants.secondaryColor,
          title: const Text("Employee List"),
        ),
        body: employeeListView(employeeListProvider),
      ),
    );
  }
}
