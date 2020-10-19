import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'functinality.dart';
import 'hijri_functions.dart';


AgeFunction ageFunction = AgeFunction();
HijAgeFunction hijAgeFunc = HijAgeFunction();
class AgeCounter extends StatefulWidget {
  @override
  _AgeCounterState createState() => _AgeCounterState();
}

class _AgeCounterState extends State<AgeCounter> {
  var dateTime;
  var yourDate;
  String formattedDate;
  int year;
  int month;
  int totalDaysCount;
  var hijDate ;
  var dateTimeB;
  DateTime newDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('BIRTH INFORMATION',
              style: TextStyle(color: Color(0xFF03369E),
                fontSize: 36.0,
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
              )),

          SizedBox(height: 50,),
          Text('Choose Your Date Of Birth',
              style: TextStyle (color: Color(0xFF03369E),
                fontSize: 18.0,
                fontFamily: 'Raleway',
              )),
          SizedBox(
              height: 7.0
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 3),
                  height: 38,
                  width: 157,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: FlatButton(
                    color: Color(0xFF0080FF),
                    onPressed: (){
                      showDatePicker(context: context,
                          initialDate: dateTime == null? DateTime.now(): dateTime,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now()
                      ).then((dateB){setState(() {
                        dateTime = dateB;
                        formattedDate = DateFormat.yMMMMd().format(dateTime);
                        ageFunction.setBirth(dateB.day.toInt(),dateB.month.toInt(), dateB.year.toInt());
                        year = ageFunction.yearAge();
                        month = ageFunction.remMonth();
                        totalDaysCount = ageFunction.totalDays();
                      });
                      });
                    },
                    child: Text('Gregorian', style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Container(
                    height: 38,
                    width: 157,
                    child: FlatButton(
                      color: Color(0xFF0080FF),
                      onPressed:(){showHijriDatePicker(
                        context: context,
                        //locale: Locale('ar', 'SA'),
                        initialDate: dateTimeB == null? HijriCalendar.now(): dateTimeB,
                        lastDate: HijriCalendar.now(),
                        firstDate: HijriCalendar()
                          ..hYear = 1400
                          ..hMonth = 1
                          ..hDay = 1,
                        initialDatePickerMode: DatePickerMode.day,
                      ).then((date){setState(() {
                        dateTimeB = date;
                        formattedDate = dateTimeB.fullDate();
                        newDate = HijriCalendar().hijriToGregorian(date.hYear, date.hMonth, date.hDay);
                        hijAgeFunc.setBirth(date.hDay, date.hMonth, date.hYear);
                        year = hijAgeFunc.hijYearAge();
                        month = hijAgeFunc.hijMonth();
                        totalDaysCount = ageFunction.totalHijDays(date.hDay, date.hMonth, date.hYear);
                      });
                      });
                      },
                      child: Text('Hijri Date',
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'
                        ),
                      ),
                    ),
                  ),
                ),
              )],
          ),

          SizedBox(height: 50,),

          Text(dateTime == null ? '': 'Your date of birth is',
              style: TextStyle(fontSize: 20,
                  fontFamily: 'Raleway',
                  color: Color(0xFF03369E))),
          Text(dateTime == null ? 'Check Your Age In:': '$formattedDate',
              style: TextStyle(fontSize: 18,
                  fontFamily: 'Raleway',
                  color: Color(0xFF03369E))),
          SizedBox(
              height: 7.0
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Container(
                    width: 157,
                    height: 38,
                    child: FlatButton(
                      color: Color(0xFF0080FF),
                      onPressed: (){
                        setState(() {
                          Alert(context: context, title: "DONE", desc: "Your age is $year years and $month months")
                              .show();
                        });
                      },
                      child: Text('Years',
                          style: TextStyle(color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Container(
                    width: 157,
                    height: 38,
                    child: FlatButton(
                      color: Color(0xFF0080FF),
                      onPressed: (){
                        setState(() {
                          Alert(context: context, title: "DONE", desc: "You have used $totalDaysCount days on earth")
                              .show();
                        });
                      },
                      child: Text('Days',
                          style: TextStyle(color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 50,),

          Text(hijDate==null?'': 'Your Hijrah Date Of Birth Is',
              style: TextStyle(fontSize: 18,
                  fontFamily: 'Raleway',
                  color: Color(0xFF03369E))),
          Text(hijDate==null?'Know Your Hijri Date Of Birth': '$hijDate',
              style: TextStyle(fontSize: 18,
                  fontFamily: 'Raleway',
                  color: Color(0xFF03369E))),
          SizedBox(
              height: 7.0
          ),
          Container(
            height: 44,
            width: 329,
            child: FlatButton(
              color: Color(0xFF0080FF),
              onPressed: (){
                showDatePicker(context: context,
                    initialDate: yourDate == null? DateTime.now(): yourDate,
                    firstDate: DateTime(1938),
                    lastDate: DateTime.now()
                ).then((dateA) {setState((){
                  yourDate = dateA;
                  hijDate = HijriCalendar.fromDate(new DateTime(yourDate.year, yourDate.month, yourDate.day)).fullDate();
                });
                });
              },
              child: Text('Choose your Gregorian Date of Birth',
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'),
              ),
            ),
          )
        ],
      ),
    );
  }
}