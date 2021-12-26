import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/layout/social_layout/sociallayout.dart';
import 'package:socialapp/modules/login/loginscreen.dart';
import 'package:socialapp/modules/register/registercubit/regcubit.dart';
import 'package:socialapp/modules/register/registercubit/regstates.dart';
import 'package:socialapp/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var regNameController = TextEditingController();

  var regPhoneController = TextEditingController();

  var regEmailController = TextEditingController();

  var regPasswordController = TextEditingController();

  var regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialRegisterErrorState ) {
            showToast(
              msg: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialUserCreateErrorState ) {
            showToast(
              msg: state.error.toString(),
              state: ToastStates.ERROR,
            );
          }
          if(state is SocialUserCreateSuccessState){
            navigateAndFinish(context,SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: regFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            label: 'Username',
                            type: TextInputType.name,
                            controller: regNameController,
                            prefix: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Username';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Email',
                            type: TextInputType.emailAddress,
                            controller: regEmailController,
                            prefix: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Email';
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            label: 'Password',
                            type: TextInputType.visiblePassword,
                            controller: regPasswordController,
                            prefix: Icons.lock,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please Insert Password';
                              }
                            },
                            isPass: SocialRegisterCubit.get(context).isPassShow,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changeSuffixIcon();
                            }
                          ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: regPhoneController,
                          prefix: Icons.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please Insert Phone Number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! SocialRegisterLoadingState,
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                          widgetBuilder: (context) {
                            return defaultButton(
                              onPressed: () {
                                if (regFormKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: regEmailController.text,
                                      password: regPasswordController.text,
                                      username: regNameController.text,
                                      phone: regPhoneController.text,

                                  );
                                }
                              },
                              text: 'Register',
                              isUpperCase: true,
                            );
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You Have An Account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  SocialLoginScreen(),
                                );
                              },
                              child: Text('Login!'.toUpperCase()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
