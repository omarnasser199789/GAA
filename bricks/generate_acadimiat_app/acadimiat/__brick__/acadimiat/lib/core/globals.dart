import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../features/home_feature/domain/entities/fav_entity.dart';
import '../features/my_courses_feature/presentation/pages/my_course/activety_by_id_page.dart';
import '../features/my_courses_feature/presentation/pages/my_course/tabs/lessons_tab/pages/lecture_page.dart';
import '../features/my_courses_feature/presentation/pages/my_course/tabs/notes_tab.dart';
import '../features/my_courses_feature/presentation/widgets/discussion_widget/discussion_widget.dart';
import '../features/my_courses_feature/presentation/widgets/video_widget/amazon_video.dart';
import '../features/my_courses_feature/presentation/widgets/video_widget/vimeo_video.dart';
import 'package:sqflite/sqflite.dart';


/// I want to use this global key for the next tasks
/// A-when user add a new note: I'm using this key to add the new note to MyLectureEntity -> CurrentVideo -> List<Bookmark>
GlobalKey<LecturePageState> lecturePageKey  = GlobalKey();
GlobalKey<NotesTabState> bookMarksWidgetKey  = GlobalKey();
GlobalKey<AmazonVideoWidgetState> amazonVideoWidgetKey = GlobalKey();
GlobalKey<VimeoVideoWidgetState> vimeoVideoWidgetKey= GlobalKey();
// GlobalKey<DiscussionWidgetState> discussionWidgetKey= GlobalKey();
GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
GlobalKey<ActivityByPageIdState> activityByPageIdKey = GlobalKey();

int globalCategoryId=-1;
double lineSpace=1.8;

List<FavEntity> favEntity=[];

var lang='en';


late SharedPreferences globalSH;
const EdgeInsetsGeometry defaultPadding=EdgeInsets.only(left: 17,right: 17,top: 15);
const double bottomPadding=15;

Map<String, String> cookies = {};
Map<String, String> headers = {"content-type": "text/json"};
var timeout = 200;

String connectionId="";
String REFRESH = "";
int page = 0;
int lastPage = 0;
late int courseId;
String CHANNEL_NAME="CHANNEL_NAME";
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const CACHED_USER_LANGUAGE="CACHED_USER_LANGUAGE";
const CUSTOMER_ID = 'CUSTOMER_ID';
const CUSTOMER_EMAIL = 'CUSTOMER_EMAIL';
const USER_ID = 'USER_ID';
const CACHED_UN = 'CACHED_UN';
const CACHED_UP = 'CACHED_UP';
const MY_COURSES_List = 'my_courses_list';
const CACHED_Refresh_TOKEN = "CACHED_Refresh_TOKEN";
const CACHED_JWT_TOKEN = 'CACHED_JWT_TOKEN';
const iS_Show_Case = 'iS_Show_Case';
const isItTheFirstTimeYouOpenTheApp = 'is_It_The_First_Time_You_Open_The_App';
String JWT = "";

final counterNotifier = ValueNotifier<String>("");

String vimeoAccessKey = "d83d133237fd6aa8c78760307719c021";
String baseUrl="";
String baseSignalRUrl="";
String publishableKey="pk_test_51M9Du6FAvw48kHUrJgvlxs6JDLDwsTr9wO0BouoYyN9mb3ycNW0Wvjxa5NBuKZwUwjTA0kZujBJEk0TqVVQF37C600VaGrFHsm";
String SECRET_KEY="sk_test_51M9Du6FAvw48kHUrXilKsyKK8vUChCO2PYAz6tOBCGuk2oTRcMKPlXNmbmYKeEoAEaiZaz5FFwxMy6r1K6M1nyUk00GHNOOqWe";
String merchantIdentifier="merchant.co.elt.acadmiat";
String shareCourseText="لمعرفة تفاصيل اكثر عن دورة #### *** قم بتحميل التطبيق الآن *** Google Play: https://play.google.com/store/apps *** App Store: https://apps.apple.com";
int? selectedLanguage = -1;
late Future<Database>   database ;
late Database db;
double svgWidth=30;
double childAspectRatio=0.85;













