import 'package:Maven/common/model/workout.dart';
import 'package:Maven/common/model/workout_folder.dart';
import 'package:Maven/feature/workout/bloc/workout/workout_bloc.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:Maven/widget/custom_app_bar.dart';
import 'package:Maven/widget/custom_scaffold.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReorderWorkoutScreen extends StatefulWidget {
  const ReorderWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ReorderWorkoutScreen> createState() => _ReorderWorkoutScreenState();
}

class _ReorderWorkoutScreenState extends State<ReorderWorkoutScreen> {

  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.build(
      context: context,
      appBar: CustomAppBar.build(
          title: "Reorder",
          context: context
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          print(state.status);
          if(state.status == WorkoutStatus.loading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == WorkoutStatus.success || state.status == WorkoutStatus.reordering) {
            List<WorkoutFolder> workoutFolders = state.workoutFolders;
            List<Workout> workouts = state.workouts;

            print("building");
            lists = workoutFolders.map((workoutFolder) {
              return DragAndDropList(
                header: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    workoutFolder.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                children: workouts
                    .where((workout) => workout.workoutFolderId == workoutFolder.workoutFolderId)
                    .map((workout) {
                  return DragAndDropItem(
                    child: ListTile(
                      title: Text(workout.name),
                    ),
                  );
                }).toList()
              );
            }).toList();

            return DragAndDropLists(
              listPadding: const EdgeInsets.all(16),
              listInnerDecoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .canvasColor,
                borderRadius: BorderRadius.circular(10),
              ),
              children: lists,
              itemDivider: Divider(
                thickness: 2,
                height: 2,
                color: mt(context).backgroundColor
              ),
              itemDecorationWhileDragging: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) => _onReorderListItem(oldItemIndex, oldListIndex, newItemIndex, newListIndex, workouts, context),
              onListReorder: _onReorderList,
            );
          } else {
            return Text("oopsirew");
          }
        },
      ),
    );
  }

  DragHandle _buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }

  void _onReorderListItem(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      List<Workout> workouts,
      BuildContext context
      ) {
    print("reordering");
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);

      List<Workout> eh = workouts;

      final movedWorkout = eh.removeAt(oldItemIndex);
      eh.insert(newItemIndex, movedWorkout);

      context.read<WorkoutBloc>().add(ReorderWorkouts(
        workouts: workouts
      ));
    });
    print("finfished");
  }

  void _onReorderList(
      int oldListIndex,
      int newListIndex,
      ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
