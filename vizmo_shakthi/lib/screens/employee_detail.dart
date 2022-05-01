import 'package:flutter/material.dart';
import 'package:vizmo_shakthi/constants/constants.dart';
import 'package:vizmo_shakthi/modals/employee_data.dart';

class EmployeeDetailPage extends StatelessWidget {
  const EmployeeDetailPage({Key? key, required this.employee})
      : super(key: key);
  final EmployeeData employee;
  Widget eachText(String txt) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Text(
            txt,
            style: const TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.baseColor,
        appBar: AppBar(
          backgroundColor: Constants.secondaryColor,
          title: const Text("Employee Detail"),
        ),
        body: SizedBox(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width / 1.5,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  employee.avatar,
                ),
              ),
              eachText(
                "Name : " + employee.name,
              ),
              eachText(
                "Phone : " + employee.phone,
              ),
              eachText(
                "Email : " + employee.email,
              ),
              eachText(
                "Birthday : " + employee.birthday,
              ),
              eachText(
                "Departments : " + employee.department.join(","),
              ),
              eachText(
                "Country : " + employee.country,
              ),
              eachText(
                "Created At : " + employee.createdAt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
