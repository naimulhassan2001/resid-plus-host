import 'package:flutter/material.dart';
import 'package:resid_plus/utils/app_colors.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{

  final double appBarHeight;
  final double? appBarWidth;
  final Color appBarBgColor;
  final Widget appBarContent;
  final bool isElevation;

  const CustomAppBar({

    this.appBarHeight = 64,
    this.appBarWidth,
    this.appBarBgColor = Colors.transparent,
    required this.appBarContent,
    this.isElevation = false,
    super.key
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(appBarWidth ?? double.infinity, appBarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {

    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.only(start: 20, top: 24, end: 20, bottom: 0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.appBarBgColor,
          boxShadow: widget.isElevation ? [
            BoxShadow(
              color: AppColors.blackPrimary.withOpacity(0.1),
              offset: const Offset(-5, -5),
              blurRadius: 10,
              spreadRadius: 10
            )
          ] : []
        ),
        child: widget.appBarContent,
      ),
    );
  }
}
