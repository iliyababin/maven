import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maven/common/common.dart';
import 'package:maven/feature/user/screen/user_edit_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../user.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state.status.isLoading) {
          return Shimmer.fromColors(
            baseColor: T(context).color.surface.baseShimmer,
            highlightColor: T(context).color.surface.highlightShimmer,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(T(context).shape.large),
              ),
              height: 100,
            ),
          );
        } else if(state.status.isLoaded) {
          User user = state.user!;
          return ClipRRect(
            borderRadius: BorderRadius.circular(T(context).shape.large),
            child: Material(
              color: T(context).color.surface,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserEditScreen(user: user,),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(T(context).space.large),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement user avatar
                        },
                        child: CircleAvatar(
                          minRadius: 30,
                          maxRadius: 30,
                          child: SvgPicture.string(user.picture),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.username,
                            style: T(context).textStyle.headingMedium,
                          ),
                          Text(
                            user.description,
                            style: T(context).textStyle.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
