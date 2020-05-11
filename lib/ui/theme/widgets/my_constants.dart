import 'package:flutter/material.dart';
import 'package:flutter_social_gf_bloc_rx/models/user.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

User myAccount;

// Colors
const Color white = const Color(0xFFFFFFFF);
const Color base = const Color(0xFFBDBDBD);
const Color baseAccent = const Color(0xFF616161);
const Color pointer = const Color(0xFFF44336);

// Images
AssetImage logoImage = AssetImage('assets/darkBee.png');
AssetImage eventImage = AssetImage('assets/event.jpg');
AssetImage homeImage = AssetImage('assets/home.jpg');
AssetImage profileImage = AssetImage('assets/profile.jpg');

// Icons
Icon iHome = Icon(Icons.home);
Icon iFriends = Icon(Icons.group);
Icon iNotifications = Icon(Icons.notifications);
Icon iProfile = Icon(Icons.account_circle);
Icon iWrite = Icon(Icons.border_color);
Icon iSend = Icon(Icons.send);
Icon iCam = Icon(Icons.camera_enhance);
Icon iGallery = Icon(Icons.photo_library);
Icon iLikeEmpty = Icon(Icons.favorite_border);
Icon iLikeFull = Icon(Icons.favorite);
Icon iMsg = Icon(Icons.message);
Icon iSettings = Icon(Icons.settings);

// Keys
String kFirstname = 'firstname';
String kLastname = 'lastname';
String kImageUrl = 'imageUrl';
String kFollowers = 'followers';
String kFollowing = 'following';
String kUID = 'uid';
String kPostID = 'postID';
String kText = 'text';
String kDate = 'date';
String kLikes = 'likes';
String kComments = 'comments';
String kDescription = 'description';
String kType = 'type';
String kRef = 'ref';
String kWatched = 'watched';

// Functions
void hideKeyboard(BuildContext context) =>
    FocusScope.of(context).requestFocus(FocusNode());
void popContext(BuildContext context) => Navigator.pop(context);
void fDisposingBlocOf(String name) => print('Disposing of $name');
String fDate(int timestamp) {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  DateTime timePost = DateTime.fromMillisecondsSinceEpoch(timestamp);
  DateFormat format;
  if (now.difference(timePost).inDays > 0) {
    format = DateFormat.yMMMd('fr_FR');
  } else {
    format = DateFormat.Hm('fr_FR');
  }
  return format.format(timePost).toString();
}
