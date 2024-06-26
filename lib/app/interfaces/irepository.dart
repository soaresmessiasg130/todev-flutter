import 'package:to_dev/app/interfaces/ientity.dart';

abstract class IRepository<T extends IEntity> {
  Future<void> create(T obj);
  Future<T?> getOne(String id);
  Future<List<T>> getAll();
  Future<void> update(T obj);
  Future<void> delete(String id);
  Future<void> deleteAll();
}
