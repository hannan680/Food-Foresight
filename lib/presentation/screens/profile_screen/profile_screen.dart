import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/blocs/user_bloc/bloc/user_bloc.dart';
import 'package:food_foresight/data/repository/auth_repository.dart';
import 'package:food_foresight/data/repository/image_picker_service.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import 'package:food_foresight/presentation/widgets/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? image;
  String? profilePic;

  ImageProvider? imageFetched;

  bool isImageLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    profilePic = context
        .read<AuthenticationBloc>()
        .authRepository
        .getCurrentUser()!
        .photoURL;
    if (profilePic != null) {
      imageFetched = NetworkImage(profilePic!);
      imageFetched!.resolve(const ImageConfiguration()).addListener(
            ImageStreamListener((imageInfo, call) {
              setState(() {
                isImageLoading = false;
              });
            }, onError: (exception, stackTrace) {
              setState(() {
                isImageLoading = false;
              });
            }),
          );
    } else {
      isImageLoading = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isImageLoading);
    final user = FirebaseAuth.instance.currentUser;
    profilePic = context
        .read<AuthenticationBloc>()
        .authRepository
        .getCurrentUser()!
        .photoURL;

    print(profilePic);
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    image == null
                        ? Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              "",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ))
                        : InkWell(
                            onTap: () {
                              context
                                  .read<UserBloc>()
                                  .add(UpdateProfilePic(image!.path));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: BlocConsumer<UserBloc, UserState>(
                                listener: (context, state) {
                                  if (state is ProfilePicUploadErrorState) {
                                    setState(() {
                                      image = null;
                                    });
                                  }
                                },
                                builder: (context, state) {
                                  print(state);

                                  if (state is ProfilePicUploadErrorState) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Error uploading profile pic!"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                  if (state is ProfilePicUploadedState) {
                                    return const Text(
                                      "",
                                    );
                                  }
                                  return Text(
                                    state is ProfilePicUploadingState
                                        ? "saving..."
                                        : " save",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                isImageLoading
                    ? Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: image != null
                            ? FileImage(File(image!.path))
                            : profilePic != null
                                ? NetworkImage(
                                    profilePic!,
                                  )
                                : const AssetImage('assets/images/avatar.png')
                                    as ImageProvider<
                                        Object>, // Replace with your image asset
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              print("clicked");
                              final selectedImage =
                                  await ImagePickerService().pickSingleImage();
                              if (selectedImage != null) {
                                setState(() {
                                  image = selectedImage;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.edit, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 10),
                Text(
                  user?.displayName != null ? user!.displayName! : "Username",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  user?.email != null ? user!.email! : "email@email.com",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/settingsIcon.png"),
                              Text('Settings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.personalInfoScreen);
                              },
                              child: ListTile(
                                title: Text('Personal Info'),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                            Divider(height: 0), // Add divider
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.notificationScreen);
                              },
                              child: ListTile(
                                title: Text('Notification'),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                            Divider(height: 0), // Add divider
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.contactUsScreen);
                              },
                              child: ListTile(
                                title: Text('Contact us'),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                            Divider(height: 0), // Add divider
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.faqsScreen);
                              },
                              child: ListTile(
                                title: Text('FAQ\'s'),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          ],
                        ), // Add spacing
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actionsPadding: EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              icon: Icon(
                                Icons.logout,
                                color: theme.primaryColor,
                              ),
                              title: const Text(
                                'Are you sure you want to log out',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundedButton(
                                      minSize: Size(120, 20),
                                      text: "Cancel",
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      fontColor: Colors.grey,
                                      border: true,
                                      borderColor: Colors.grey,
                                      color: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    RoundedButton(
                                        minSize: Size(120, 20),
                                        text: "Yes",
                                        onTap: () async {
                                          await AuthRepository().signOut();
                                          Navigator.of(context).pop();
                                        })
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: theme.primaryColor,
                                ),
                                Text('Log Out',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, height: 2))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
