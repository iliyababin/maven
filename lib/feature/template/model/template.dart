import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';


@Entity(
  tableName: 'template',
  primaryKeys: [
    'template_id',
  ],
)
class Template extends Equatable {
  @ColumnInfo(name: 'template_id')
  @PrimaryKey(autoGenerate: true)
  final int? templateId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'sort_order')
  final int? sortOrder;

  const Template({
    this.templateId,
    required this.name,
    this.sortOrder,
  });

  Template copyWith({
    int? templateId,
    String? name,
    int? sortOrder,
  }) {
    return Template(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  String toString() {
    return 'Template{templateId: $templateId, name: $name, sortOrder: $sortOrder}';
  }

  @override
  List<Object?> get props => [
    templateId,
    name,
    sortOrder,
  ];
}