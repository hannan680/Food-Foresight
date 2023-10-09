import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/barcode_bloc/bloc/barcode_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/items_bloc/bloc/item_bloc.dart';
import 'package:food_foresight/blocs/recipe_bloc/bloc/recipe_bloc.dart';
import 'package:food_foresight/blocs/sortbloc/bloc/sort_bloc.dart';
import 'package:food_foresight/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:food_foresight/data/models/sortcriteria.dart';
import 'package:food_foresight/data/repository/auth_repository.dart';
import 'package:food_foresight/data/repository/barcode_repository.dart';
import 'package:food_foresight/data/repository/item_repository.dart';
import 'package:food_foresight/data/repository/notification_service.dart';
import 'package:food_foresight/data/repository/recipe_repository.dart';
import 'package:food_foresight/data/repository/user_repository.dart';
import 'package:food_foresight/firebase_options.dart';
import 'package:food_foresight/presentation/screens/add_item_screen/bloc/bloc/add_item_bloc.dart';
import 'package:food_foresight/presentation/screens/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:food_foresight/presentation/screens/onboarding_screen/onboarding_screen.dart';

import 'package:food_foresight/presentation/screens/login_screen/bloc/loginvalidation_bloc.dart';
import 'package:food_foresight/presentation/screens/login_screen/login_screen.dart';
import 'package:food_foresight/presentation/screens/signup_screen/bloc/signupvalidation_bloc.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './presentation/routes/app_routes.dart';
import './presentation/theme/appTheme.dart';

bool firstTime = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));

  await NotificationService().initNotification();
  firstTime = await isFirstTime();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(authRepository: AuthRepository())),
      BlocProvider<LoginvalidationBloc>(
          create: (context) => LoginvalidationBloc()),
      BlocProvider<SignupvalidationBloc>(
        create: (context) => SignupvalidationBloc(),
      ),
      BlocProvider<SignupvalidationBloc>(
        create: (context) => SignupvalidationBloc(),
      ),
      BlocProvider<AddItemBloc>(
        key: GlobalKey(),
        create: (context) => AddItemBloc(),
      ),
      BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(itemRepository: ItemRepository()),
      ),
      BlocProvider<SortBloc>(
        create: (context) => SortBloc(settings: Settings()),
      ),
      BlocProvider<RecipeBloc>(
        create: (context) =>
            RecipeBloc(RecipeRepository('942c4a6c31804437a04d71172e24f183')),
      ),
      BlocProvider<BarcodeBloc>(
        create: (context) =>
            BarcodeBloc(BarcodeRepository('xw8bueohgsdo9lu83yjmtniebzeom3')),
      ),
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(UserRepository()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const BottomNavigationScreen();
          } else {
            return firstTime ? const OnboardingScreen() : LoginScreen();
          }
        },
      ),
      routes: routes,
    );
  }
}

Future<bool> isFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (isFirstTime) {
    // Set the flag to false after the first launch
    await prefs.setBool('isFirstTime', false);
  }

  return isFirstTime;
}
