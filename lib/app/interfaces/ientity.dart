abstract class IEntity {
  int? id;
  DateTime? created;
  DateTime? updated;

  IEntity({
    this.id,
    this.created,
    this.updated,
  });

  List<String> getFields() => [];

  Map<String, dynamic> toMap() => {};

  IEntity fromMap(Map<String, dynamic> map);

  @override
  String toString() => 'Entity()';
}
