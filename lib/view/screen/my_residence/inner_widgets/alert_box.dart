import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/my_residence/delete_repo/delete_repo.dart';

class AlertBox extends StatefulWidget {
  final String id;
  const AlertBox({super.key,required this.id });

  @override
  State<AlertBox> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        width: 350,
        child: Column(
          children: [
             Text(
              "You sure want Delete to Residence".tr,
              style: const TextStyle(
                  color: AppColors.blackPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                     onTap: () {
                    var repo = DeleteResidence(apiService: Get.find());
                    repo.deleteResidence(id: widget.id);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.blackPrimary, width: 1),
                          color: AppColors.transparentColor,
                          borderRadius: BorderRadius.circular(8)),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Yes".tr,
                          style: const TextStyle(
                              color: AppColors.blackPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.blackPrimary,
                          borderRadius: BorderRadius.circular(8)),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "No".tr,
                          style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
