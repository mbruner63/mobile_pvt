import 'package:intl/intl.dart';

class PVT_Data {
  String Study = "STUDY";
  int Before_Rating = 5;
  int After_Rating = 5;
  String E_Initials = "MLB";
  String S_Initials = "MLB";
  String S_ID = "0001";
  int Trial_Number = 1;
  String Trial_Date = "12/12/21";
  String Trial_Time = "1200";
  int ISI_Min = 1000;
  int ISI_Max = 10000;
  int Trial_length = 60;
  String PVT_Serial_Num = "0001";
  List<int> reactionTimes = [];
  List<int> stimulationTimes = [];
  String Main_Email = "";

  void Set_Date_Time() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String formatted = formatter.format(now);
    Trial_Date = formatted;
    final DateFormat timeFormatter = DateFormat('hhmm');
    final String timeFormatted = timeFormatter.format(now);
    Trial_Time = timeFormatted;
  }

  void ResetData() {
    reactionTimes = [];
    stimulationTimes = [];
  }

  void InsetData(int reaction_time, int stimulation_time) {
    reactionTimes.add(reaction_time);
    stimulationTimes.add(stimulation_time);
  }
}

PVT_Data pvt_data = new PVT_Data();
