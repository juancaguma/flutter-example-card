import 'package:flutter/material.dart';

import 'app_bar.dart';

class AppBarScreen extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarScreen({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
 
  @override
  Widget build(BuildContext context) {
    return AppBarList(context);
  }
}
