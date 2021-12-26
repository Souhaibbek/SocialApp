import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/modules/socialcubit/socubit.dart';
import 'package:socialapp/modules/socialcubit/sostates.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).model != null,
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
          widgetBuilder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 8,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://image.freepik.com/photos-gratuite/vacances-hiver-concept-personnes-femme-rousse-joyeuse-pull-pointant-doigts-vers-bas-souriante-heureuse-devant-camera-montrant-promo-fond-bleu_1258-55273.jpg'),
                          width: double.infinity,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Communicate with friends',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Jannah',
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostsItem(
                      SocialCubit.get(context).posts[index],
                      SocialCubit.get(context).model,
                      context,
                      index,
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildPostsItem(
        PostModel model, SocialUserModel? userModel, context, index) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(userModel!.image),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${userModel.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, height: 1.3),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                child: Text(
                  '${model.postText}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Container(
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(model.postImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 16.0,
                      ),
                      Text('${SocialCubit.get(context).likes[index]}'),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      IconBroken.Chat,
                      size: 16.0,
                    ),
                    Text('${SocialCubit.get(context).comments[index]}'),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 1,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage(userModel.image),
                ),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () {
                    showBottomSheet(
                        elevation: 20.0,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200.0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage: NetworkImage(
                                          SocialCubit.get(context).model!.image,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '${SocialCubit.get(context).model!.name}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            height: 1.3),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Write a comment ..',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          IconBroken.Arrow___Right,
                                        ),
                                        onPressed: () {
                                          SocialCubit.get(context).commentPost(
                                              SocialCubit.get(context)
                                                  .postId[index]);
                                          Navigator.pop(context);
                                          print(SocialCubit.get(context)
                                              .comments
                                              .length);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      'Write a comment ...',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      Text(
                        'Like',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postId[index]);
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
