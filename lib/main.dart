import 'package:flutter/material.dart';
import 'package:vemdora_flutter_frontend/routes/my_router.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vemdora',
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          initialRoute: '/suppliermenulist',
          onGenerateRoute: MyRouter.generateRoute,
        );
      },
    );
  }
}
