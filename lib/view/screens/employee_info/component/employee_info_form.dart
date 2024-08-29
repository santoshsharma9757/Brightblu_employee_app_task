import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/utils/app_utils.dart';
import 'package:brightblu_user_info/view/widgets/custom_button.dart';
import 'package:brightblu_user_info/view/widgets/custom_dropdown_form_field.dart';
import 'package:brightblu_user_info/view/widgets/custom_text_form_field.dart';
import 'package:brightblu_user_info/view_model/employee_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeInformationForm extends StatelessWidget {
  final String? employeeId;
  const EmployeeInformationForm({super.key, this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeInfoViewModel>(
      builder: (context, provider, child) {
        return Form(
          key: provider.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppString.addPersonalInfo,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                AppSpacing.verticalMedium,
                CustomTextFormField(
                  controller: provider.nameController,
                  hintText: AppString.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.nameMessage;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalMedium,
                CustomTextFormField(
                  controller: provider.emailController,
                  hintText: AppString.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.emailMessage;
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return AppString.validEmailMessage;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalMedium,
                CustomTextFormField(
                  hintText: AppString.age,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.age;
                    } else if (int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return AppString.validAgeMessage;
                    }
                    return null;
                  },
                  controller: provider.ageController,
                ),
                AppSpacing.verticalMedium,
                CustomTextFormField(
                  controller: provider.addressController,
                  hintText: AppString.address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.addressMessage;
                    }
                    return null;
                  },
                ),
                AppSpacing.verticalMedium,
                CustomDropdownFormField(
                  value: provider.selectedGender,
                  labelText: AppString.gender,
                  items: provider.gender,
                  onChanged: (value) {
                    provider.setGender(value.toString());
                  },
                ),
                AppSpacing.verticalMedium,
                CustomDropdownFormField(
                  value: provider.selectedEmploymentStatus,
                  labelText: AppString.employementStatus,
                  items: provider.employementStatus,
                  onChanged: (value) {
                    provider.setEmployementStatus(value.toString());
                  },
                ),
                AppSpacing.verticalMedium,
                GestureDetector(
                  onTap: () async {
                    await provider.setDob(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.selectedDate != null
                                ? provider.selectedDate.toString()
                                : AppString.dateofBirth,
                          ),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSpacing.verticalMedium,
                CustomSubmitButton(
                  buttonName: employeeId == null
                      ? AppString.generatePDF
                      : AppString.updatePDF,
                  onPressed: () async {
                    if (provider.formKey.currentState!.validate()) {
                      if (provider.selectedDate != null) {
                        var fileSaved =
                            await provider.generatePersonalInfoPdf();
                        if (fileSaved.path.isNotEmpty) {
                          provider.setIsPdfGenerated(true);
                        }
                      } else {
                        AppUtils.showToast(AppString.dobMesage);
                      }
                    }
                  },
                ),
                AppSpacing.verticalMedium,
              ],
            ),
          ),
        );
      },
    );
  }
}
