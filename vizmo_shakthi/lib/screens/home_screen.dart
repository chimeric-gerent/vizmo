import 'package:flutter/material.dart';
import 'package:vizmo_shakthi/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:vizmo_shakthi/screens/employee_list.dart';
import 'package:vizmo_shakthi/screens/profile_screen.dart';
import '../providers/screen_change.dart';
import 'bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
  Widget getBody(int i) {
    switch (i) {
      case 0:
        return EmployeeList();
      case 1:
        return const ProfileScreen();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<PageChange>(context, listen: true);

    return ChangeNotifierProvider.value(
      value: pageProvider,
      child: SafeArea(
        child: Scaffold(
          body: getBody(pageProvider.getPageNo),
          backgroundColor: Constants.baseColor,
          bottomNavigationBar: HomeBottomBar(pageProvider: pageProvider),
        ),
      ),
    );
  }
}
