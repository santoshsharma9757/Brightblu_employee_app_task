import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:brightblu_user_info/constant/app_screen_utils.dart';
import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/utils/app_utils.dart';
import 'package:brightblu_user_info/view/screens/employee_info/component/pdf_view.dart';
import 'package:brightblu_user_info/view/widgets/custom_button.dart';
import 'package:brightblu_user_info/view_model/employee_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PdfContent extends StatelessWidget {
  final String? employeeId;
  final String? employeeName;
  const PdfContent({super.key, this.employeeId, this.employeeName});
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeInfoViewModel>(
      builder: (context, provider, child) {
        return SizedBox(
          height: AppScreenUtils.screenHeightPercentage(context, 0.7),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: provider.file!.path.isNotEmpty
                      ? PdfViewer(
                          filePath: provider.file!.path,
                          headerTitle: AppString.genetatePDF,
                        )
                      : const Center(child: Text(AppString.noPdfAvailable)),
                ),
              ),
              CustomSubmitButton(
                  buttonName: AppString.upload,
                  isloading: provider.isPDFUploading,
                  onPressed: () async {
                    onUpload(provider, context);
                  }),
              AppSpacing.verticalMedium
            ],
          ),
        );
      },
    );
  }

  onUpload(EmployeeInfoViewModel provider, BuildContext context) async {
    var isUploadedToServer = await provider.saveEmpoyeData(
        employeeId: employeeId, empName: employeeName);
    if (isUploadedToServer) {
      Navigator.pop(context);
      AppUtils.snackBar(AppString.fileUplodedMessage, context);
    } else {
      AppUtils.snackBar(AppString.someThingWrongMesage, context, true);
    }
  }
}
