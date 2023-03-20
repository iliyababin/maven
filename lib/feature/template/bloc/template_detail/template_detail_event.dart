part of 'template_detail_bloc.dart';

abstract class TemplateDetailEvent extends Equatable {
  const TemplateDetailEvent();
}

class TemplateDetailLoad extends TemplateDetailEvent {
  const TemplateDetailLoad({
    required this.templateId,
  });

  final int templateId;

  @override
  List<Object?> get props => [
    templateId,
  ];
}
