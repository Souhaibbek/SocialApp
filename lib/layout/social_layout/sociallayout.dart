import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/modules/home/posts.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/components/components.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {
        if (state is SocialAddPostState) {
          navigateTo(
            context,
            AddPostScreen(),
          );
        }
      },
      builder: (BuildContext context, Object? state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  fontFamily: 'Jannah',
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Notification),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Search),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: cubit.currentIndex,
              items: cubit.items,
              onItemSelected: (index){
                cubit.changeBotNavBarItem(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }
}
