
import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/view/screens/employee_info/component/pdf_view.dart';
import 'package:brightblu_user_info/view/screens/employee_info/employee_info_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppString.employeeScreen:
        return MaterialPageRoute(builder: (context) => const EmployeeInfoScreen());
      case AppString.pdfViewScreen:
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(builder: (context) =>  PdfViewer(
          filePath: args['filePath']??"",
        ));  
      default:
        return null;
    }
  }
}
