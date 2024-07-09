import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';

class SearchEndDrawer extends StatefulWidget {

  const SearchEndDrawer({super.key});

  @override
  State<SearchEndDrawer> createState() => _SearchEndDrawerState();
}

class _SearchEndDrawerState extends State<SearchEndDrawer> {

  List<String> categoryList = ["Popular", "Regular", "Trending", "Luxury", "Lakefront", "Mansion", "Farms", "Desert", "Island"];
  int selectedCategory = -1;
  List<String> bedList = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10+"];
  int selectedBed = -1;

  List<String> priceList = ["\$10 - \$50", "\$60 - \$100", "\$110 - \$150", "\$160 - \$200", "\$210 - \$250"];
  int selectedPrice = -1;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFF818181)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.blackPrimary,
                  size: 18,
                ),
              )
            ],
          ),
          const SizedBox(height: 40),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsetsDirectional.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.blackPrimary,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: categoryList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 24
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          selectedCategory = index;
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                          decoration: ShapeDecoration(
                            color: index == selectedCategory ? AppColors.blackPrimary : AppColors.transparentColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.5, color: index == selectedCategory ? AppColors.blackPrimary : const Color(0xFF818181)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            categoryList[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              color: index == selectedCategory ? AppColors.whiteColor : AppColors.blackPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Number of Beds',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.blackPrimary,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: bedList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: MediaQuery.of(context).size.width,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 24
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => setState(() {
                          selectedBed = index;
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                          decoration: ShapeDecoration(
                            color: index == selectedBed ? AppColors.blackPrimary : AppColors.transparentColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.5, color: index == selectedBed ? AppColors.blackPrimary : const Color(0xFF818181)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            bedList[index],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.raleway(
                              color: index == selectedBed ? AppColors.whiteColor : AppColors.blackPrimary,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Price Range',
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1, width: MediaQuery.of(context).size.width,
                    color: AppColors.blackPrimary,
                  ),
                  const SizedBox(height: 16),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(priceList.length, (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => setState(() {
                            selectedPrice = index;
                          }),
                          child: Row(
                            children: [
                              Container(
                                height: 18, width: 18,
                                padding: const EdgeInsetsDirectional.all(0.5),
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.black20, width: 1)
                                ),
                                child: index == selectedPrice ? Container(
                                  height: 18, width: 18,
                                  decoration: BoxDecoration(
                                      color: AppColors.blackPrimary,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.blackPrimary, width: 1)
                                  ),
                                ) : null,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                priceList[index],
                                style: GoogleFonts.raleway(

                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  ),

                  const SizedBox(height: 24),

                  CustomElevatedButton(
                    onPressed: (){},
                    titleText: "Apply",
                    buttonWidth: MediaQuery.of(context).size.width,
                    buttonColor: AppColors.blackPrimary,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
