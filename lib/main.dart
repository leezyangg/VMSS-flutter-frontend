import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vemdora_flutter_frontend/providers/user_state.dart';
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
        return ChangeNotifierProvider<UserState>(
          create: (_) => UserState(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vemdora',
            theme: ThemeData(
              primaryColor: Colors.blue[50],
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
            ),
            initialRoute: '/',
            onGenerateRoute: MyRouter.generateRoute,
          ),
        );
      },
    );
  }
}
