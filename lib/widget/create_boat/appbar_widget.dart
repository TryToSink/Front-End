import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:profile_try_to_sink/screens/profile_page.dart';

AppBar buildAppBar(BuildContext context) {
  const appBarBGColor = Color(0xFF293241);

  return AppBar(
    leading: const BackButton(
        color: Colors.white,
      ),
    
    elevation: 0,
    backgroundColor: appBarBGColor,
    toolbarHeight: 30,
  );
}
