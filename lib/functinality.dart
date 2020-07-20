import 'package:int_range/int_range.dart';
import 'package:hijri/hijri_calendar.dart';

class AgeFunction {
  List<int> months = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  List<int> daysInMonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  int presentDay = DateTime.now().day.toInt();
  int presentMonth = DateTime.now().month;
  int presentYear = DateTime.now().year.toInt();
  int _dayOfBirth ;
  int _monthOfBirth ;
  int _yearOfBirth ;

  var hijPresent = new HijriCalendar.now();


 void setBirth(day,month,year){
   _dayOfBirth = day;
   _monthOfBirth = month;
   _yearOfBirth = year;
 }

  bool leapYear(year){
    if(year % 4 == 0){
      if(year % 100 == 0){
        if(year % 400 == 0){
          return true;
        } else{
          return false;
        }
      } else {
      return true;
    }
    } else{
      return false;
    }
  }

  //For Year
  int yearAge(){
    int age;
    if (months.indexOf(_monthOfBirth) > months.indexOf(presentMonth)){
      age = (presentYear - _yearOfBirth) - 1;
      return age;
    }else{
      age = (presentYear - _yearOfBirth);
      return age;
    }
  }


  int dayNum(day, mth, yr) {
    int pos = day;
    var newList = daysInMonth.sublist(0, mth);
    if (leapYear(yr) == true) {
      newList[2] = 29;
      for (var i = 0; i < newList.length; i++) {
        pos += newList[i];}
      return pos;
    } else {
      for (var i = 0; i < newList.length; i++) {
        pos += newList[i];}
      return pos;
    }
  }

  int remDays(_dayOfBirth, _monthOfBirth, _yearOfBirth){
   int position = dayNum(_dayOfBirth, _monthOfBirth, _yearOfBirth);
   int rem;
   if(leapYear(_yearOfBirth) == true){
     rem = 366 - position;
     return rem;
   }else{
     rem = 365 - position;
     return rem;
   }
  }

  // For Months
  int remMonth(){
    int rem;
    if(presentMonth < _monthOfBirth){
      rem = 12 - (_monthOfBirth - presentMonth);
      return rem;
    }else{
      rem = presentMonth - _monthOfBirth;
      return rem;
    }
  }
  // For Days
  int totalDays(){
   int remain = remDays(_dayOfBirth, _monthOfBirth, _yearOfBirth);
   int totalNumDays;
   if(presentYear == _yearOfBirth){
     totalNumDays = dayNum(presentDay, presentMonth, presentYear) - dayNum(_dayOfBirth, _monthOfBirth, _yearOfBirth) + 1;
   }else if(presentYear - _yearOfBirth ==1){
     totalNumDays = remain + dayNum(presentDay, presentMonth, presentYear);
   }else{
     for (int i in (_yearOfBirth + 1).till(presentYear)) {
       if(leapYear(i) == true){
         remain += 366;
       }else{
         remain += 365;
       }
     }
     totalNumDays = remain + dayNum(presentDay, presentMonth, presentYear) + 1;
   }
   return totalNumDays;
  }

  //Total Hij days
  int totalHijDays(da, mo, ye){
    DateTime hDate = HijriCalendar().hijriToGregorian(ye, mo, da);
    int remain = remDays(hDate.day, hDate.month, hDate.year);
    int totalNumDays;
    if(presentYear == hDate.year){
      totalNumDays = dayNum(presentDay, presentMonth, presentYear) - dayNum(hDate.day, hDate.month, hDate.year) + 1;
    }else if(presentYear - hDate.year ==1){
      totalNumDays = remain + dayNum(presentDay, presentMonth, presentYear);
    }else{
      for (int i in (hDate.year + 1).till(presentYear)) {
        if(leapYear(i) == true){
          remain += 366;
        }else{
          remain += 365;
        }
      }
      totalNumDays = remain + dayNum(presentDay, presentMonth, presentYear) + 1;
    }
    return totalNumDays;
  }
}