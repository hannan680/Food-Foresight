import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_foresight/blocs/bloc/auth_bloc.dart';
import 'package:food_foresight/presentation/routes/app_routes.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/rounded_button.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  User? user;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    user = context.read<AuthenticationBloc>().authRepository.getCurrentUser();
    _nameController.text = user!.displayName!;
    _emailController.text = user!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.loading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state.status == AuthenticationStatus.unauthenticated) {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
        if (state.status == AuthenticationStatus.error) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  color: theme.primaryColor.withOpacity(.4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        Column(
                          children: [
                            Text(
                                'Hi, ${user?.displayName != null ? user!.displayName : "User"}',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ]),
                ),
                Positioned(
                  bottom: -80,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!) as ImageProvider
                        : const AssetImage(
                            'assets/images/avatar.png'), // Replace with your image asset
                  ),
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomFormField(
                      controller: _nameController,
                      prefixIcon: Icons.person_2_outlined,
                      label: "Name",
                      hintText: "Name"),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      label: "Email",
                      hintText: "Email"),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                      controller: _passwordController,
                      prefixIcon: Icons.password_outlined,
                      label: "Password",
                      hintText: "Password"),
                  SizedBox(
                    height: 30,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ))
                      : RoundedButton(
                          text: "Delete Account",
                          onTap: () {
                            if (_passwordController.text != '' &&
                                _emailController.text != "") {
                              print("hello");
                              context.read<AuthenticationBloc>().add(
                                  DeleteAccount(
                                      password: _passwordController.text));
                            }
                          },
                          leading: const Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Icon(Icons.lock_clock),
                          ),
                        ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}
