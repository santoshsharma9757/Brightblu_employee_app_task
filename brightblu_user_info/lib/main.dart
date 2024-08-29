import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/core/di.dart';
import 'package:brightblu_user_info/routes/app_generated_route.dart';
import 'package:brightblu_user_info/view_model/employee_info_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  setupDI();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BrightBluApp());
}

class BrightBluApp extends StatelessWidget {
  const BrightBluApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmployeeInfoViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: AppColors.customColor),
        initialRoute: AppString.employeeScreen,
        onGenerateRoute: AppRoutes.onGeneratedRoute,
      ),
    );
  }
}
