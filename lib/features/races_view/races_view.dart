import 'package:flutter/material.dart';
import 'package:tesk/core/utils/app_constants.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';
import 'package:tesk/features/races_view/view/races_view_body.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RacesView extends StatelessWidget {
  const RacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            title: SvgPicture.asset('assets/icons/app_icon.svg'),
            actions: [
              Stack(
                children: [
                  SvgPicture.asset('assets/icons/Vector.svg'),
                  const Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              SvgPicture.asset('assets/icons/Profile picture.svg'),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              unselectedLabelColor: const Color(0xffcdd3e4),
              labelColor: Colors.white,
              indicatorColor: secondaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 6,
              labelPadding: const EdgeInsets.only(bottom: 14.5),
              tabs: [
                Text('RUN',
                    style: AppStyles.styleSemiBold18.copyWith(
                        fontSize:
                            getResponsiveFontSize(context, fontSize: 18))),
                Text('COMMUNITY',
                    style: AppStyles.styleSemiBold18.copyWith(
                        fontSize:
                            getResponsiveFontSize(context, fontSize: 18))),
                Text('RACES',
                    style: AppStyles.styleSemiBold18.copyWith(
                        fontSize:
                            getResponsiveFontSize(context, fontSize: 18))),
              ],
            ),
            backgroundColor: primaryColor,
          ),
        ),
        body: const RacesViewBody(),
      ),
    );
  }
}
