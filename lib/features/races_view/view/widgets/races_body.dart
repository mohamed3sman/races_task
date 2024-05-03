import 'package:flutter/material.dart';
import 'package:tesk/core/utils/app_constants.dart';
import 'package:tesk/core/utils/app_styles.dart';
import 'package:tesk/core/utils/methods.dart';
import 'package:tesk/core/widgets/custom_button.dart';
import 'package:tesk/core/widgets/custom_filter_widget.dart';
import 'package:tesk/core/widgets/custom_text_field.dart';
import 'package:tesk/features/races_view/model/json_reply.dart';
import 'package:tesk/features/races_view/model/race_model.dart';
import 'package:tesk/features/races_view/view/widgets/custom_race_widget.dart';

class RacesBody extends StatefulWidget {
  const RacesBody({super.key});

  @override
  State<RacesBody> createState() => _RacesBodyState();
}

class _RacesBodyState extends State<RacesBody> {
  RaceModel? raceModel;
  TextEditingController searchController = TextEditingController();
  TextEditingController locationSearchController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<String> racesInCountry = [];
  List<String> countriesList = [];
  String? selectedOption = "Real-time";

  final List<Map<String, dynamic>> raceData = dataList;

  List<Map<String, dynamic>> filteredLocations = [];

  List<Map<String, dynamic>> filteredRaces = [];
  List<String> selectedCountries = [];
  List<String> countries = [];
  List<String> allCountries = [];

  void getSelectedCountries() {
    setState(() {
      filteredRaces = raceData
          .where((race) => selectedCountries.contains(race['country']))
          .toList();
    });
    print(selectedCountries);
  }

  void getLocations() {
    setState(() {
      countries.clear();
      for (var race in raceData) {
        if (race['country']
                .toLowerCase()
                .startsWith(locationSearchController.text.toLowerCase()) &&
            !countries.contains(race['country'])) {
          countries.add(race['country']);
        }
      }
    });
  }

  void getAllCountries() {
    setState(() {
      allCountries.clear();
      for (var race in raceData) {
        if (!allCountries.contains(race['country'])) {
          allCountries.add(race['country']);
        }
      }
    });
  }

  void filterLocations(String location) {
    setState(() {
      filteredLocations = dataList
          .where((race) =>
              race['country'].toLowerCase().contains(location.toLowerCase()) ||
              race['city'].toLowerCase().contains(location.toLowerCase()))
          .toList();
    });
  }

  void searchByCountry(String country) {
    setState(() {
      racesInCountry.clear();
      for (var race in raceData) {
        if (race['country'].toLowerCase().startsWith(country.toLowerCase())) {
          racesInCountry.add(race['name']);
        }
      }
    });
  }

  void getCountries(String country) {
    setState(() {
      countriesList.clear();
      for (var country in raceData) {
        if (country['country']
                .toLowerCase()
                .startsWith(searchController.text.toLowerCase()) &&
            !countriesList.contains(country['country'])) {
          countriesList.add(country['country']);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
            bottom: MediaQuery.sizeOf(context).height * 0.12),
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              text: 'Search',
              suffixIcon: Icon(
                Icons.search_rounded,
                color: primaryColor,
                size: 30,
              ),
              onChanged: (value) {
                searchByCountry(value);
                getCountries(value);
              },
            ),
            searchController.text.isNotEmpty && countriesList.isNotEmpty
                ? SearchRacesResult(
                    racesInCountry: racesInCountry,
                    countriesList: countriesList)
                : const SizedBox(
                    height: 16,
                  ),
            Row(
              children: [
                AppliedFiltersContainer(selectedCountries: selectedCountries),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomFilterWidget(
                              colored: true,
                              filterName: 'Type',
                              onTap: () {
                                typeFilterBottomSheet(context);
                              }),
                          CustomFilterWidget(
                            colored:
                                selectedCountries.isNotEmpty ? true : false,
                            filterName: 'Location',
                            onTap: () {
                              locationBottomSheet(context);
                            },
                          ),
                          const CustomFilterWidget(
                              colored: false, filterName: 'Distance'),
                          const CustomFilterWidget(
                              colored: false, filterName: 'Date'),
                        ]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            ViewBody(
                raceData: raceData,
                selectedCountries: selectedCountries,
                selectedOption: selectedOption),
          ],
        ),
      ),
    );
  }

  Future<dynamic> locationBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.75,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'RACE Location',
                    style: AppStyles.styleSemiBold20.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: locationSearchController,
                    text: 'Search',
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      color: primaryColor,
                      size: 30,
                    ),
                    onChanged: (value) {
                      getLocations();
                      getAllCountries();
                      getSelectedCountries();
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: countries.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: locationSearchController.text.isNotEmpty
                            ? Text(countries[index])
                            : Text(allCountries[index]),
                        value: locationSearchController.text.isNotEmpty
                            ? selectedCountries.contains(countries[index])
                            : selectedCountries.contains(allCountries[index]),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value == true) {
                              locationSearchController.text.isNotEmpty
                                  ? selectedCountries.add(countries[index])
                                  : selectedCountries.add(allCountries[index]);
                              setState(() {});
                              print(selectedCountries);
                            } else {
                              locationSearchController.text.isNotEmpty
                                  ? selectedCountries.remove(countries[index])
                                  : selectedCountries
                                      .remove(allCountries[index]);
                              setState(() {});
                              print(selectedCountries);
                            }
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> typeFilterBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RACE TYPE',
                  style: AppStyles.styleSemiBold20.copyWith(
                    fontSize: getResponsiveFontSize(context, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RadioListTile<String>(
                  title: Text(
                    'Real-time Event',
                    style: AppStyles.styleMedium18.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 18),
                    ),
                  ),
                  value: 'Real-time',
                  groupValue: selectedOption,
                  activeColor: secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      print(selectedOption);
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    'Virtual',
                    style: AppStyles.styleMedium18.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 18),
                    ),
                  ),
                  value: 'Virtual',
                  groupValue: selectedOption,
                  activeColor: secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      print(selectedOption);
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    'All',
                    style: AppStyles.styleMedium18.copyWith(
                      fontSize: getResponsiveFontSize(context, fontSize: 18),
                    ),
                  ),
                  value: 'All',
                  groupValue: selectedOption,
                  activeColor: secondaryColor,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      print(selectedOption);
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomButton(
                  color: secondaryColor,
                  text: 'Done',
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppliedFiltersContainer extends StatelessWidget {
  const AppliedFiltersContainer({
    super.key,
    required this.selectedCountries,
  });

  final List<String> selectedCountries;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.filter_alt_rounded,
            color: Colors.white,
            size: 30,
          ),
          CircleAvatar(
            radius: 13,
            backgroundColor: const Color(0xffffe954),
            child: Text(
              selectedCountries.isNotEmpty ? '2' : '1',
              style: AppStyles.styleMedium18.copyWith(
                color: Colors.black,
                fontSize: getResponsiveFontSize(context, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewBody extends StatelessWidget {
  const ViewBody({
    super.key,
    required this.raceData,
    required this.selectedCountries,
    required this.selectedOption,
  });

  final List<Map<String, dynamic>> raceData;
  final List<String> selectedCountries;
  final String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: raceData.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final race = raceData[index];
        if ((selectedCountries.isEmpty ||
                selectedCountries.contains(race['country'])) &&
            (selectedOption == 'Real-time' || race['type'] == selectedOption)) {
          return CustomRaceWidget(
            raceModel: RaceModel(
              name: race['name'],
              organizer: race['organizer'] ?? "",
              date: race['date'],
              country: race['country'],
              city: race['city'],
              image: race['image'],
              type: race['type'],
              distances: race['distances'],
            ),
          );
        } else {
          // Return a SizedBox if the race doesn't meet the filter criteria
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class SearchRacesResult extends StatefulWidget {
  const SearchRacesResult({
    super.key,
    required this.racesInCountry,
    required this.countriesList,
  });

  final List<String> racesInCountry;
  final List<String> countriesList;

  @override
  State<SearchRacesResult> createState() => _SearchRacesResultState();
}

class _SearchRacesResultState extends State<SearchRacesResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: secondaryColor, width: 1.5),
          left: BorderSide(color: secondaryColor, width: 1.5),
          right: BorderSide(color: secondaryColor, width: 1.5),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.racesInCountry.isNotEmpty
                ? Text('Countries:',
                    style: AppStyles.styleMedium18.copyWith(
                        fontSize: getResponsiveFontSize(context, fontSize: 18)))
                : const Text('data'),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.countriesList.length,
              itemBuilder: (context, index) {
                print(widget.countriesList);
                return ListTile(
                  title: Text(widget.countriesList[index]),
                );
              },
            ),
            widget.racesInCountry.isNotEmpty
                ? Text('Races:',
                    style: AppStyles.styleMedium18.copyWith(
                        fontSize: getResponsiveFontSize(context, fontSize: 18)))
                : const Text(''),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.racesInCountry.length,
              itemBuilder: (context, index) {
                print(widget.racesInCountry);
                return ListTile(
                  title: Text(widget.racesInCountry[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
