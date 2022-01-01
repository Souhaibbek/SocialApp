import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/modules/chat_details.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Conditional.single(
            fallbackBuilder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            widgetBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Friends list : ' ,style: TextStyle(fontWeight: FontWeight.bold,),),
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              userListBuilder(SocialCubit.get(context).users[index],context),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            color: Colors.grey,
                          );
                        },
                        itemCount: SocialCubit.get(context).users.length,
                      ),
                    ),
                  ],
                ),
              );
            },
            context: context,
            conditionBuilder: (context) =>
                SocialCubit.get(context).users.length > 0,
          ),
        );
      },
    );
  }
}

Widget userListBuilder(SocialUserModel userModel,context) => InkWell(
      onTap: () {
        navigateTo(context, ChatDetailsScreen(socialUserModel: userModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(userModel.image),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '${userModel.name}',
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.3),
            ),
          ],
        ),
      ),
    );
