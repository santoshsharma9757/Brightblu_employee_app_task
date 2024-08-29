import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isFromPdfView;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.isFromPdfView=false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isFromPdfView,
      backgroundColor:AppColors.lightBlue,
      title: Text(title),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
