import 'package:app/view/home/pages/choose_address_page.dart';
import 'package:app/view/home/pages/notice_detail_page.dart';
import 'package:app/view/login/login_page.dart';
import 'package:app/view/login/splash_page.dart';
import 'package:app/view/menu_container.dart';
import 'package:app/view/order/pages/order_detail_page.dart';
import 'package:app/view/profile/pages/account_management_page.dart';
import 'package:app/view/profile/pages/feed_back_page.dart';
import 'package:app/view/profile/pages/feed_back_record.dart';
import 'package:app/view/profile/pages/update_password_page.dart';
import 'package:app/view/profile/pages/user_info_detail_page.dart';
import 'package:common_utils/common_utils.dart';

class YFRouter {
  static const String splash = "/splash";
  static const String menuContainer = "/menuContainer";
  static const String login = "/login";
  static const String chooseAddress = "/chooseAddress";
  static const String noticeDetail = "/noticeDetail";
  static const String webviewPlugin = "/webviewPlugin";
  static const String userInfoDetail = "/userInfoDetail";
  static const String updatePassword = "/updatePassword";
  static const String orderDetail = "/orderDetail";
  static const String accountManagement = "/accountManagement";
  static const String feedBackRecord = "/feedBackRecord";
  static const String feedBack = "/feedBack";

  static List<GetPage> routes() {
    return [
      GetPage(name: splash, page: () => const SplashPage()),
      GetPage(name: login, page: () => const LoginPage()),
      GetPage(name: menuContainer, page: () => const MenuContainer()),
      GetPage(name: chooseAddress, page: () => const ChooseAddressPage()),
      GetPage(name: noticeDetail, page: () => const NoticeDetailPage()),
      GetPage(name: webviewPlugin, page: () => WebviewPluginPage()),
      GetPage(name: userInfoDetail, page: () => const UserInfoDetailPage()),
      GetPage(name: updatePassword, page: () => const UpdatePasswordPage()),
      GetPage(name: orderDetail, page: () => const OrderDetailPage()),
      GetPage(name: accountManagement, page: () => const AccountManagementPage()),
      GetPage(name: feedBackRecord, page: () => const FeedBackRecordPage()),
      GetPage(name: feedBack, page: () => const FeedBackPage()),
    ];
  }

  static onUnknownRoute() {}
}
