import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCancelTopSection extends StatefulWidget {
  const BookingCancelTopSection({super.key});

  @override
  State<BookingCancelTopSection> createState() =>
      _BookingCancelTopSectionState();
}

class _BookingCancelTopSectionState extends State<BookingCancelTopSection> {
  final bookingDetailsModel = Get.arguments[0];
  int index = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          padding: const EdgeInsetsDirectional.only(top: 8, end: 8),
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: NetworkImage(bookingDetailsModel[index].residenceId.photo[0].publicFileUrl
                  .toString()),
              fit: BoxFit.fill,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),

        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  bookingDetailsModel[index].residenceId.residenceName ?? "",
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                    const SizedBox(width: 4),
                    Text("${(
                      bookingDetailsModel[index].residenceId!.ratings ?? "",
                    )}")
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.place_outlined,
                    color: Color(0xFF818181), size: 18),
                const SizedBox(width: 4),
                Text(
                  bookingDetailsModel[index].residenceId!.city ?? "",
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF818181),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
