import 'package:Maven/feature/program/widget/folder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/model/folder.dart';
import '../bloc/program_detail/program_detail_bloc.dart';

class ProgramDetailScreen extends StatefulWidget {
  const ProgramDetailScreen({Key? key,
    required this.programId,
  }) : super(key: key);

  final int programId;

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  void loadProgram() => context.read<ProgramDetailBloc>().add(ProgramDetailLoad(programId: widget.programId));

  @override
  void initState() {
    super.initState();
    loadProgram();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page,),
        child: BlocBuilder<ProgramDetailBloc, ProgramDetailState>(
          builder: (context, state) {
            if(state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isLoaded) {
              List<Folder> folders = state.folders;
              return ListView.separated(
                itemCount: folders.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16,);
                },
                itemBuilder: (context, index) {
                  Folder folder = folders[index];

                  return FolderWidget(
                    folder: folder,
                    templates: folder.templates,
                  );
                },
              );
            } else {
              return Text(
                'eror',
                style: mt(context).textStyle.subtitle2,
              );
            }
          },
        ),
      ),
    );
  }
}
