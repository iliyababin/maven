import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'user',
  primaryKeys: [
    'id',
  ],
)
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.description,
    required this.weight,
    required this.height,
    required this.age,
  });

  const User.base({
    this.id = 1,
    this.username = 'John Doe',
    this.description = 'Weightlifter',
    this.weight = 150,
    this.height = 5.10,
    this.age = 18,
  });

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int id;

  @ColumnInfo(name: 'username')
  final String username;

  @ColumnInfo(name: 'description')
  final String description;

  @ColumnInfo(name: 'weight')
  final double weight;

  @ColumnInfo(name: 'height')
  final double height;

  @ColumnInfo(name: 'age')
  final int age;

  @override
  List<Object?> get props => [
    id,
    username,
    description,
    weight,
    height,
    age,
  ];
}