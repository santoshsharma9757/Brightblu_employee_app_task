import 'dart:math';

import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/constant/app_text_style.dart';
import 'package:brightblu_user_info/models/user_model.dart';
import 'package:brightblu_user_info/repositories/user_repository/user_repository.dart';
import 'package:brightblu_user_info/utils/app_utils.dart';
import 'package:brightblu_user_info/view/screens/employee_info/component/employee_info_form.dart';
import 'package:brightblu_user_info/view/screens/employee_info/component/pdf_content.dart';
import 'package:brightblu_user_info/view/widgets/common_app_bar.dart';
import 'package:brightblu_user_info/view/widgets/custom_text_button.dart';
import 'package:brightblu_user_info/view_model/employee_info_view_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({super.key});

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  late EmployeeInfoViewModel provider;
  @override
  void initState() {
    provider = Provider.of<EmployeeInfoViewModel>(context, listen: false);
    super.initState();
  }

  Color generateRandomColorWithOpacity() {
    final random = Random();
    Color baseColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    return baseColor.withOpacity(0.5);
  }

  final UserRepository userRepository = GetIt.instance<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      resizeToAvoidBottomInset: true,
      appBar: const CommonAppBar(title: AppString.employeeInformation),
      body: _buildEmployeeListSection(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          _showAddPersonalInfoBottomSheet(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildEmployeeListSection() {
    return StreamBuilder<List<UserInfo>>(
      stream: userRepository.streamAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTileCard(
                  initiallyExpanded: true,
                  baseColor: generateRandomColorWithOpacity(),
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(
                    "${user.name}",
                    style: AppTextStyles.heading5,
                  ),
                  subtitle: Text(
                    "${user.email}",
                    maxLines: 1,
                  ),
                  children: <Widget>[
                    const Divider(
                      thickness: 1.0,
                      height: 1.0,
                    ),
                    _buildButtonSection(user),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${AppString.error} ${snapshot.error}'));
        } else {
          return const Center(child: Text(AppString.noUserMesage));
        }
      },
    );
  }

  _buildButtonSection(UserInfo user) {
    return Consumer<EmployeeInfoViewModel>(
      builder: (context, emValue, child) => OverflowBar(
        alignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomTextButton(
            onPressed: () async {
              onEdit(user.id.toString(), user.name.toString());
            },
            icon: Icons.edit,
            text: AppString.edit,
            iconColor: Colors.teal,
          ),
          CustomTextButton(
            onPressed: () {
              viewPdf(user.name.toString());
            },
            icon: Icons.picture_as_pdf,
            text: AppString.viewPdf,
            iconColor: Colors.blue,
          ),
          CustomTextButton(
            onPressed: () {
              deleteUser(user.id.toString(), user.name.toString());
            },
            icon: Icons.delete_forever,
            text: AppString.delete,
            iconColor: Colors.red,
          )
        ],
      ),
    );
  }

  _showAddPersonalInfoBottomSheet(BuildContext context,
      [String? emId, String? emName]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppPadding.small,
            AppPadding.small,
            AppPadding.small,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Consumer<EmployeeInfoViewModel>(
              builder: (context, emvalue, child) => emvalue.isLoading
                  ? const Center(child: Text(AppString.generatingPdf))
                  : emvalue.isPdfGenerated
                      ? PdfContent(
                          employeeId: emId,
                          employeeName: emName,
                        )
                      : EmployeeInformationForm(
                          employeeId: emId,
                        )),
        );
      },
    );
  }

  Future<void> onEdit(String userId, String useName) async {
    await provider.fetchAndSetEmployeeInfo(userId);
    if (mounted) {
      _showAddPersonalInfoBottomSheet(
        context,
        userId.toString(),
        useName,
      );
    }
  }

  Future<void> viewPdf(String userName) async {
    AppUtils.snackBar(AppString.pdfDownloading, context);
    var path = await provider.downloadPdf(userName);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    if (path != null) {
      if (mounted) {
        Navigator.pushNamed(
          context,
          AppString.pdfViewScreen,
          arguments: {"filePath": path},
        );
      }
    } else {
      AppUtils.snackBar(AppString.someThingWrongMesage, context, true);
    }
  }

  Future<void> deleteUser(String userId, String useName) async {
    bool isRemoved = await provider.deleteEmployee(userId, useName);
    if (mounted) {
      if (isRemoved) {
        AppUtils.snackBar(AppString.deleteMesage, context, true);
      } else {
        AppUtils.snackBar(AppString.someThingWrongMesage, context, true);
      }
    }
  }
}
