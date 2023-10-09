import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/barcode_bloc/bloc/barcode_bloc.dart';
import 'package:food_foresight/blocs/suggestions_bloc/bloc/suggestions_bloc.dart';
import 'package:food_foresight/data/repository/barcode_repository.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/bloc/bloc/add_item_bloc.dart';
import 'package:food_foresight/presentation/screens/login_screen/bloc/loginvalidation_bloc.dart';
import 'package:food_foresight/presentation/screens/signup_screen/bloc/signupvalidation_bloc.dart';

// Import your screen widgets
import '../screens/login_screen/login_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/otp_verification_screen/otp_verification_screen.dart';
import '../screens/reset_password_screen/reset_password_screen.dart';
import '../screens/signup_screen/signup_screen.dart';
import '../screens/forgot_password_screen/forgot_password_screen.dart';
import '../screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import '../screens/expiry_date_remainder_set_screen/expiry_date_remainder_set_screen.dart';
import '../screens/add_item_screen/add_item_screen.dart';
import '../screens/item_details_screen/item_details_screen.dart';
import '../screens/personal_info_screen/personal_info_screen.dart';
import '../screens/faqs_screen/faqs_screen.dart';
import '../screens/contact_us_screen/contact_us_screen.dart';
import '../screens/notification_screen/notification_screen.dart';
import '../screens/privacy_policy_screen/privacy_policy_screen.dart';
import '../screens/item_update_screen/item_update_screen.dart';
// import '../widgets/hidebottomui_overlay.dart';

class AppRoutes {
  static const String onboarding = '/on';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String forgotPassword = '/forgot_password';
  static const String otpVerification = '/otp_verification';
  static const String resetPassword = '/reset_password';
  static const String bottomNavigationScreen = "/bottom_nav";
  static const String expiryDateRemainderScreen = "/exp_reminder";
  static const String addItemScreen = "/add_item";
  static const String itemDetailsScreen = "/item_details";
  static const String personalInfoScreen = "/personal_info";
  static const String faqsScreen = "/faqs";
  static const String contactUsScreen = "/contact_us";
  static const String notificationScreen = "/notification";
  static const String privacyPolicyScreen = "/policy";
  static const String itemUpdateScreen = "/itemupdate";
}

final Map<String, WidgetBuilder> routes = {
  AppRoutes.onboarding: (context) => const OnboardingScreen(),
  AppRoutes.signup: (context) => SignupScreen(),
  AppRoutes.login: (context) => LoginScreen(),
  AppRoutes.otpVerification: (context) {
    final String email = ModalRoute.of(context)?.settings.arguments as String;
    return OtpVerificationScreen(email: email);
  },
  AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
  AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
  AppRoutes.bottomNavigationScreen: (context) => const BottomNavigationScreen(),
  AppRoutes.expiryDateRemainderScreen: (context) => ExpiryDateRemainderScreen(),
  AppRoutes.addItemScreen: (context) => BlocProvider(
      create: (ctx) => AddItemBloc(),
      child: BlocProvider(
        create: (context) => SuggestionsBloc(),
        child: const AddItemScreen(),
      )),
  AppRoutes.itemDetailsScreen: (context) => const ItemDetailsScreen(),
  AppRoutes.personalInfoScreen: (context) => const PersonalInformationScreen(),
  AppRoutes.faqsScreen: (context) => const FaqsScreen(),
  AppRoutes.contactUsScreen: (context) => const ContactUsScreen(),
  AppRoutes.notificationScreen: (context) => const NotificationScreen(),
  AppRoutes.privacyPolicyScreen: (context) => const PrivacyPolicyScreen(),
  AppRoutes.itemUpdateScreen: (context) => const ItemUpdateScreen(),
  // Add more routes as needed
};
