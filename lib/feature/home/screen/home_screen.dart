import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Home',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Dashboard',
              size: HeadingSize.small,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: T(context).color.surface,
                              borderRadius: BorderRadius.circular(
                                T(context).shape.large,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.orange,
                                  size: 44,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '1',
                                        style: T(context).textStyle.headingMedium,
                                      ),
                                      Text(
                                        'Week Streak',
                                        style: T(context).textStyle.labelSmall,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: T(context).space.medium,
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            padding: EdgeInsets.all(
                              T(context).space.large,
                            ),
                            decoration: BoxDecoration(
                              color: T(context).color.surface,
                              borderRadius: BorderRadius.circular(
                                T(context).shape.large,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Total Workouts',
                                ),
                                Text(
                                  '27',
                                  style: T(context).textStyle.headingMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ),
            const Heading(
              title: 'Exercises',
            ),
            SliverList(delegate: SliverChildListDelegate([]),),
          ],
        ),
      ),
    );
  }
}
