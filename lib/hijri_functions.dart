import 'functinality.dart';

AgeFunction ageFunc = AgeFunction();

class HijAgeFunction{

  int hijDOB;
  int hijMOB;
  int hijYOB;
  DateTime fDate;


  void setBirth(day,month,year){
    hijDOB = day;
    hijMOB = month;
    hijYOB = year;
  }

  int hijMonth(){
    int total = ageFunc.totalHijDays(hijDOB, hijMOB, hijYOB);
    double monthsRem = (total % 354.3);
    int noOfMonths = (monthsRem / 29.5).floor();
    return noOfMonths;
  }

  int hijYearAge(){
    int total = ageFunc.totalHijDays(hijDOB, hijMOB, hijYOB);
    int noOfYears = (total / 354.3).floor();
    return noOfYears;
  }


}