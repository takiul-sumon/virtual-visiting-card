import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_visiting_card/app/app.dart';
import 'package:virtual_visiting_card/provider/contact_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const VirtualVisitingCard(),
    ),
  );
}
