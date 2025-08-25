
import '../entity/child.dart';

abstract class ChildrenRepository {
  Future<List<Child>> getChildren();
  Future<void> addChild(Child child);
  Future<void> deleteChild(String id);
}
