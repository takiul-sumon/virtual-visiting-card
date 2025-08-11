import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:virtual_visiting_card/app/app_routes.dart';
import 'package:virtual_visiting_card/screens/home_page.dart';

class VirtualVisitingCard extends StatelessWidget {
  const VirtualVisitingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.name,
      onGenerateRoute: AppRoutes.getRoute,
      builder: EasyLoading.init(),
    );
  }
}
