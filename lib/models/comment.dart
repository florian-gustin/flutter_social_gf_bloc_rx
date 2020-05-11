import 'package:flutter_social_gf_bloc_rx/ui/theme/widgets.dart';

class Comment {
  String userID, text, date;

  Comment(Map<dynamic, dynamic> map) {
    userID = map[kUID];
    text = map[kText];
    date = fDate(map[kDate]);
  }
}
