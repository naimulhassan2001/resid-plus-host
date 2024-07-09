import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_model/booking_list_model.dart';

class BookingDetailsTopSection extends StatefulWidget {

  final BookingListModel bookingListModel;
  final int index;
  const BookingDetailsTopSection({super.key, required this.bookingListModel, required this.index});

  @override
  State<BookingDetailsTopSection> createState() => _BookingDetailsTopSectionState();
}

class _BookingDetailsTopSectionState extends State<BookingDetailsTopSection> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var data = widget.bookingListModel.data!.attributes!.bookings![widget.index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CarouselSlider.builder(
              itemCount: data.residenceId?.photo?.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageIndex) =>
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data.residenceId!.photo![itemIndex].publicFileUrl.toString()),

                        ),
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                  ),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                enableInfiniteScroll: false,
                viewportFraction: 1,
                height: MediaQuery.of(context).size.height*0.5,
                autoPlay: true,
              ),
            ),
            const SizedBox(height: 10),
            DotsIndicator(
              decorator: DotsDecorator(
                color: Colors.grey.withOpacity(0.2),
                activeColor: AppColors.blackPrimary,
              ),
              dotsCount: data.residenceId?.photo?.length ?? 0,
              position: currentIndex,
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data.residenceId!.residenceName.toString(),
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Color(0xFFFBA91D), size: 18),
                        const SizedBox(width: 4),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '(',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: data.residenceId!.ratings.toString(),
                                style: GoogleFonts.openSans(
                                  color: const Color(0xFF333333),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ')',
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF333333),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
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
                      data.residenceId!.city.toString(),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFFF2E1E3),
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                "${data.residenceId!.status}".toUpperCase(),
                style: GoogleFonts.raleway(
                  color: const Color(0xFFD7263D),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
