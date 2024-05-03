import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesk/core/utils/app_constants.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';
import 'package:tesk/features/races_view/model/race_model.dart';

class CustomRaceWidget extends StatelessWidget {
  const CustomRaceWidget({super.key, required this.raceModel});

  final RaceModel raceModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          color: raceWidgetColor,
          padding: const EdgeInsets.only(right: 5),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.34,
                height: MediaQuery.of(context).size.width * 9 / 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/races_images/${raceModel.image}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        size: getResponsiveFontSize(context, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        raceModel.name,
                        style: AppStyles.styleExtraBold16.copyWith(
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 16),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Organized by',
                        style: AppStyles.styleRegular14.copyWith(
                          color: Colors.blue,
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 14),
                        ),
                      ),
                      Text(
                        raceModel.organizer,
                        style: AppStyles.styleRegular14.copyWith(
                          color: secondaryColor,
                          fontSize:
                              getResponsiveFontSize(context, fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/distance_icon.svg'),
                          const SizedBox(width: 3),
                          Text(
                            raceModel.distances,
                            style: AppStyles.styleRegular14.copyWith(
                              color: primaryColor,
                              fontSize:
                                  getResponsiveFontSize(context, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/date_icon.svg'),
                          const SizedBox(width: 3),
                          Text(
                            raceModel.date,
                            style: AppStyles.styleRegular14.copyWith(
                              color: primaryColor,
                              fontSize:
                                  getResponsiveFontSize(context, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.39,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/location_icon.svg'),
                                const SizedBox(width: 3),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  child: Text(
                                    '${raceModel.city}, ${raceModel.country}',
                                    style: AppStyles.styleRegular14.copyWith(
                                      color: primaryColor,
                                      fontSize: getResponsiveFontSize(context,
                                          fontSize: 14),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset('assets/icons/Icon.svg'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
