import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../../theme/theme.dart';
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
          return Container();
        } else if(state.status.isLoaded) {
          User user = state.user;
          return Container(
            padding: EdgeInsets.all(T(context).space.large),
            decoration: BoxDecoration(
              color: T(context).color.surface,
              borderRadius: BorderRadius.circular(T(context).shape.large),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement user avatar
                      },
                      child: const CircleAvatar(
                        minRadius: 25,
                        child: Text('A'),
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    height: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Weight ${s(context).parseWeight(user.weight).truncateZeros} ${s(context).weightUnit.name}',
                      textAlign: TextAlign.center,
                      style: T(context).textStyle.labelSmall,
                    ),
                    const Text('|'),
                    Text(
                      'Height ${s(context).parseHeight(user.height).truncateZeros} ${s(context).distanceUnit.name}',
                      textAlign: TextAlign.center,

                      style: T(context).textStyle.labelSmall,
                    ),
                    const Text('|'),
                    Text(
                      'Age ${user.age}',
                      textAlign: TextAlign.center,
                      style: T(context).textStyle.labelSmall,
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
