import 'package:flutter/material.dart';
import 'package:virtual_visiting_card/models/contact_model.dart';
import 'package:virtual_visiting_card/screens/form_page.dart';
import 'package:virtual_visiting_card/screens/home_page.dart';
import 'package:virtual_visiting_card/screens/scan_page.dart';

class AppRoutes {
  static Route<dynamic> getRoute(RouteSettings settings) {
    late final Widget screenWidget;
    if (settings.name == HomePage.name) {
      screenWidget = HomePage();
    } else if (settings.name == ScanPage.name) {
      screenWidget = ScanPage();
    } else if (settings.name == FormPage.name) {
      final ContactModel contactModel = settings.arguments as ContactModel;
      screenWidget = FormPage(contactModel: contactModel);
    } else {
      screenWidget = Scaffold(body: Center(child: Text('Page not found')));
    }
    return MaterialPageRoute(builder: (context) => screenWidget);
  }
}
