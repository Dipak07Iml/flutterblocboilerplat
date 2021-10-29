//by Dipak07Iml
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterblocboilerplat/utils/shared_pref.dart';

const kGoogleApiKey = "";
const BASE_URL = "";
const PRIMARY_COLOR = Color.fromRGBO(25, 191, 138, 1);
const SECONDARY_COLOR = Color.fromRGBO(25, 191, 138, 1);
const GRAY = Color(0xFFeaeaea);
//If they said
const GRAYLIGHT1 = Color(0xffEBEBEB);
const GRAYLIGHT2 = Color.fromRGBO(235, 235, 235, 1);
const HINTCOLOR = Color.fromRGBO(255, 255, 255, 0.53);
const TEXTFIELDBG = Color.fromRGBO(31, 31, 31, 1);

const INNERSHADOWCOLOR = Color.fromRGBO(0, 0, 1, 0.49);

const WHITE = Colors.white;
const DARK_GRAY = Color(0xFFa3a3a3);
const BLACK = Color(0xFF232323);
const BLACKLIGHT = Color.fromRGBO(7, 7, 7, 1.0);
const PISTACHIO = Color(0xFFe4f6e8);
const LIGHT_GREEN = Color.fromRGBO(13, 148, 167, 0.08);
const LIGHT_BLUE = Color(0xFFe7edf8);
const TRANSPARENT_WHITE = Color.fromRGBO(255, 255, 255, 0.1);
const SEE_ALL_PAGE_PRIMARY_COLOR = Colors.white;
const RED = Color(0xffF34236);

//shared preference
const USER = "user";
const USER_TYPE = "type"; //1 = wholeseller && 2 = retail
const SERVICES = "services";
const USER_ID = "id";
const AUTH_TOKEN = "token";
const FCM_TOKEN = "device_token";
const ITEMS = "items";
const ID = "id";

// Routes
//// ----------- Common Routes ---------- ////
const LOGIN = "login";
const ONBORDING = "onbording_screen";
const REGISTER = "create_account";
const FORGOT_PASSWORD = "forget_password";
const WHOLESELLERHOMEPAGE1 = "home_dashboard";


/// ------------- End Rout --------------/////

//API keyword
const STATUS = "STATUS";
const SUCCESS = "success";
const MESSAGE = "message";
const RESULT = "RESULT";
const DATA = "data";
const IS_TOKEN_EXPIRED = "is_token_expire";
const HTTP_CODE = 'code';

// Alert Messages
const MSG_IS_NOT_LOGIN =
    "Please create/login in your account to further process. Do you want to login?";
const MSG_CANCEL_ORDER = "Cancel Order?";
const MSG_CANCEL_ORDER_MESSAGE = "Are you sure that you want to cancel Order?";
const MSG_LOGOUT = "Log Out?";
const MSG_LOGOUT_MESSAGE = "Are you sure you want to log out?";
const MSG_EVENT_TICKET_ADDED = "Event is added to cart";

class FontFamily {
  static var POPPINS_REGULAR = 'Poppins-Regular';
  static var POPPINS_MEDIUM = 'Poppins-Medium';
  static var POPPINS_SEMIBOLD = 'Poppins-SemiBold';
  static var MONTSERRAT_REGULAR = 'Montserrat-Regular';
  static var MONTSERAT_MEDIUM = 'Montserrat-Medium';
  static var MONTSERRAT_SEMIBOLD = 'Montserrat-SemiBold';
  static var PROXIMA_NOVA = 'Proxima-Nova';
  static var PROXIMA_NOVA_BOLD = 'Proxima-Nova-Bold';
  static var PROXIMA_NOVA_REGULAR = 'ProximaNova-Regular';
  static var METROPOLIS_BOLD = 'metropolis_boldr';
  static var POPPINS_LIGHT = 'poppins-light';
  static var METROPOLIS_REGULAR = 'Metropolis-Regular';
}

class PersonalDocumentsStatus {
  static var PENDING = 'pending';
  static var IN_PROGRESS = 'inprogress';
  static var SUCCESS = 'success';
}

class ProfileListStatus {
  static var SWITCH = 'switch';
  static var NEXT_SCREEN = 'next_screen';
}

//image path
class ImgName {
  static var PLACE_HOLDER = 'assets/placeholder.png';
}

class ProfileListstring {
  static var SHOW_ONLINE_STATUS = 'Show online Status';
  static var ACCOUNT_DETAILS = 'Account Details';
  static var TRANSACTIONS = 'Transactions';
  static var SETTINGS = 'Settings';
  static var INVITE_CLIENTS = 'Invite Clients';
  static var FEEDBACK = 'Feedback';
  static var LOG_OUT = 'Log Out';
  static var SERVICE_PROVIDER_MODE = 'Service Provider Mode';
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorsFont {
  static Color SECOND_TITLE = HexColor("#000000");
  static Color FIRST_TITLE = HexColor("#000000");
  static Color SEARCH_LIST_SECOND_TITLE = HexColor("#8A8A8F");
  static Color RECOMMENDED_FOR_YOU = HexColor("#000000");
  static Color SEE_ALL = HexColor("#50BD9A");
  static Color SEE_AL = HexColor("#50BD9A");
  static Color SEE_A = HexColor("#50BD9A");
  static Color SEE_ = HexColor("#50BD9A");
  static Color MICHAEL_WILLIAMS = HexColor("#000000");
  static Color PLUMBER = Color(0xFFa3a3a3);
  static Color APP_BAR_POPULAR = HexColor("#000000");
  static Color POPULAR_CARD_STRING = HexColor("#FFAA08");
  static Color PROFILE_LIST_TITLE = HexColor("#2D2D2D");
}

class ColorsBasic {
  static Color PROFILE_HEADER = HexColor("#19BF8A");
  static Color BORDER_COLOR = HexColor("#EBEBEB");
  static Color CHAT_DETAIL_CONTAINER = HexColor("#EFEFF4");
}

class FontSize {
  static double RECOMMENDED_FOR_YOU = 19;
  static double FIRST_TITLE = 26;
  static double SEARCH_LIST_TITLE = 18;
  static double SECOND_TITLE = 20;
  static double SEARCH_LIST_SECOND_TITLE = 16;
  static double LBL_SUB_TITLE = 22;
  static double SEE_ALL = 14;
  static double MICHAEL_WILLIAMS = 16;
  static double PLUMBER = 13;
  static double APP_BAR_POPULAR = 24;
  static double POPULAR_CARD_STRING = 17;
  static double PROFILE_LIST_TITLE = 20;
}

// showSnakeBar(BuildContext context, String msg) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         msg ?? '',
//         style: TextStyle(color: WHITE),
//       ),
//     ),
//   );
// }

showColoredSnakeBar({BuildContext con, String msg, Color color}) {
  ScaffoldMessenger.of(con).showSnackBar(
    SnackBar(
      content: Text(
        msg ?? '',
        style: TextStyle(color: WHITE),
      ),
      backgroundColor: color,
    ),
  );
}

confirmAlertDialog(
  context,
  title,
  message,
  Function actionPressed,
) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      "No",
      textAlign: TextAlign.center,
      // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget noButton = TextButton(
    child: Text(
      "Yes",
      textAlign: TextAlign.center,
      // style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    onPressed: actionPressed,
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    title: Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    content: Text(message,
        textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
    actions: [okButton, noButton],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

resetAndNavigateLogin(BuildContext context) async {
  await SharedPref.saveString(AUTH_TOKEN, '');
  await SharedPref.saveInt(USER_TYPE, 0);
  await SharedPref.saveObject(USER, null);
  await SharedPref.resetData();
  Navigator.pushNamedAndRemoveUntil(context, ONBORDING, (route) => false);
}
