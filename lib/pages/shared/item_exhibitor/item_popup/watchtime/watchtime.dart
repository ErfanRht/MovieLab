import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/general.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/toast.dart';

class AddWatchTime extends StatefulWidget {
  final FullShow? fullShow;
  final Future<dynamic> Function() updateShowData;
  final Color backgroundColor;
  const AddWatchTime({
    Key? key,
    this.fullShow,
    required this.updateShowData,
    required this.backgroundColor,
  }) : super(key: key);
  @override
  AddWatchTimeState createState() => AddWatchTimeState();
}

class AddWatchTimeState extends State<AddWatchTime> {
  final PreferencesShareholder _preferencesShareholder =
      PreferencesShareholder();
  late bool isOtherDateSectionOpen, showDateSelector;
  late TimeOfDay selectedTime;
  late DateTime selectedDate;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    isOtherDateSectionOpen = false;
    showDateSelector = false;
    selectedTime = TimeOfDay.now();
    selectedDate = DateTime.now();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: widget.backgroundColor,
      duration: const Duration(milliseconds: 125),
      height: !isOtherDateSectionOpen ? 225 : 350,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 25, bottom: 15),
                child: Text(
                  "When did you watch this?",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.25),
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              markAsWatched(date: DateTime.now(), time: TimeOfDay.now());
            },
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
            child: Row(
              children: const [
                Icon(
                  FontAwesomeIcons.calendar,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Right now",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              markAsWatched(
                  date: DateTime.parse(widget.fullShow!.releaseDate),
                  time: TimeOfDay.now());
            },
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.film,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Release date",
                      style: TextStyle(
                          fontSize: 13.5, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Text(
                  widget.fullShow!.releaseDate,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              if (!isOtherDateSectionOpen) {
                setState(() {
                  isOtherDateSectionOpen = true;
                });
                await Future.delayed(const Duration(milliseconds: 100));
                setState(() {
                  showDateSelector = true;
                });
              } else {
                setState(() {
                  isOtherDateSectionOpen = false;
                  showDateSelector = false;
                });
              }
            },
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.penToSquare,
                      color:
                          !isOtherDateSectionOpen ? Colors.white : kAccentColor,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Other date",
                      style: TextStyle(
                          color: !isOtherDateSectionOpen
                              ? Colors.white
                              : kAccentColor,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Icon(
                    !isOtherDateSectionOpen
                        ? FontAwesomeIcons.angleDown
                        : FontAwesomeIcons.angleUp,
                    color:
                        !isOtherDateSectionOpen ? Colors.white : kAccentColor,
                    size: 17.5)
              ],
            ),
          ),
          const SizedBox(
            height: 7.5,
          ),
          showDateSelector
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => _selectDate(context),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: IntrinsicWidth(
                            child: TextField(
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 2),
                                  ),
                                  labelText: "Date",
                                  hintText:
                                      "${months[selectedDate.month - 1]} ${selectedDate.day}, ${selectedDate.year}",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w700),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                          onPressed: () => _selectTime(context),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: IntrinsicWidth(
                            child: TextField(
                              readOnly: true,
                              onTap: () => _selectTime(context),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                        width: 2),
                                  ),
                                  labelText: "Date",
                                  hintText:
                                      "${selectedTime.hour} : ${selectedTime.minute}",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w700),
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 17.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GmButton(
                            text: "Apply",
                            onTap: () {
                              markAsWatched(
                                  date: selectedDate, time: selectedTime);
                              setState(() {
                                isOtherDateSectionOpen = false;
                                showDateSelector = false;
                              });
                            },
                            backgroundColor: kAccentColor.withOpacity(0.75),
                            color: Colors.white)
                      ],
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  // Select when the user has watched the item
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: kSecondaryColor,
                primaryColor: kPrimaryColor,
                colorScheme: const ColorScheme.light(
                  primary: kPrimaryColor,
                  onPrimary: Colors.white,
                  onSurface: Colors.white,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
              ),
              child: child!);
        },
        initialDate: selectedDate,
        currentDate: DateTime.now(),
        selectableDayPredicate: (DateTime date) =>
            date.isAfter(DateTime.now()) ? false : true,
        firstDate: DateTime(1901),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Select what time of the day the user has watched the item
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      builder: (BuildContext context, child) {
        return Theme(
            data: ThemeData.dark().copyWith(
              primaryColor: kPrimaryColor,
              timePickerTheme: const TimePickerThemeData(
                backgroundColor: kSecondaryColor,
                dialTextColor: Colors.white,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ),
            child: child!);
      },
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  // Add the item to the History list
  markAsWatched({required DateTime date, required TimeOfDay time}) async {
    _preferencesShareholder.addShowToList(
        showPreview: convertFullShowToShowPreview(fullShow: widget.fullShow!),
        listName: "history",
        date: date,
        time: time,
        fullShow: widget.fullShow);
    widget.updateShowData();

    await Future.delayed(const Duration(milliseconds: 200));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 50));

    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      child: ToastWidget(
        mainText: "Saved to History",
        buttonText: "See list",
        buttonColor: kAccentColor,
        pushOnButtonTap: true,
        listName: "history",
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
    widget.updateShowData();
  }
}
