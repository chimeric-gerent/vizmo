import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/screen_change.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key, this.pageProvider}) : super(key: key);
  final pageProvider;

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                // _changePage(context, 0);
                widget.pageProvider.changeScreen(0);
              },
              child: Icon(Icons.list)),
          GestureDetector(
            onTap: () {
              widget.pageProvider.changeScreen(1);
              // _changePage(context, 1);
            },
            child: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
