import 'package:criptohub/domain/utils/deep_equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("DeepEquatable Mixin", () {
    test("should consider two simple entities with same props as equal", () {
      final entity1 = SimpleEntity('user1', 10, true);
      final entity2 = SimpleEntity('user1', 10, true);
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should consider two simple entities with different props as not equal', () {
      final entity1 = SimpleEntity('user1', 10, true);
      final entity2 = SimpleEntity('user2', 10, true);
      final entity3 = SimpleEntity('user1', 20, true);
      final entity4 = SimpleEntity('user1', 10, false);

      expect(entity1, isNot(equals(entity2)));
      expect(entity1, isNot(equals(entity3)));
      expect(entity1, isNot(equals(entity4)));
    });

    test('should consider an entity equal to itself', () {
      final entity = SimpleEntity('self', 99, true);
      expect(entity, equals(entity));
    });

    test('should consider entities of different types as not equal', () {
      final entityA = SimpleEntity('id1', 10, true);
      final entityB = ListEntity('id1', [], []);
      expect(entityA, isNot(equals(entityB)));
    });

  });

  group('ListEntity Equality', () {
    test('should consider entities with identical lists as equal', () {
      final entity1 = ListEntity('names', [1, 2, 3], ['a', 'b']);
      final entity2 = ListEntity('names', [1, 2, 3], ['a', 'b']);
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should consider entities with different list content as not equal', () {
      final entity1 = ListEntity('names', [1, 2, 3], ['a', 'b']);
      final entity2 = ListEntity('names', [1, 2, 4], ['a', 'b']);
      final entity3 = ListEntity('names', [1, 2, 3], ['a', 'c']);

      expect(entity1, isNot(equals(entity2)));
      expect(entity1, isNot(equals(entity3)));
    });

    test('should consider entities with same list elements but different order as not equal', () {
      final entity1 = ListEntity('names', [1, 2, 3], []);
      final entity2 = ListEntity('names', [3, 2, 1], []);
      expect(entity1, isNot(equals(entity2)));
    });

    test('should consider entities with different list lengths as not equal', () {
      final entity1 = ListEntity('names', [1, 2, 3], []);
      final entity2 = ListEntity('names', [1, 2], []);
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle lists with null elements correctly', () {
      final entity1 = ListEntity('null_list', [1, ?null, 3], ['x', null]);
      final entity2 = ListEntity('null_list', [1, ?null, 3], ['x', null]);
      final entity3 = ListEntity('null_list', [1, 2, 3], ['x', null]);

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(entity3)));
    });
  });

  group('MapEntity Equality', () {
    test('should consider entities with identical maps as equal', () {
      final entity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      final entity2 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should consider entities with different map values as not equal', () {
      final entity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      final entity2 = MapEntity('config', {'setting1': 1, 'setting2': 'other'});
      expect(entity1, isNot(equals(entity2)));
    });

    test('should consider entities with different map keys as not equal', () {
      final entity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      final entity2 = MapEntity('config', {'setting1': 1, 'setting3': 'value'});
      expect(entity1, isNot(equals(entity2)));
    });

    test('should consider entities with different map sizes as not equal', () {
      final entity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      final entity2 = MapEntity('config', {'setting1': 1});
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle maps with null values correctly', () {
      final entity1 = MapEntity('null_map', {'key1': null, 'key2': 'value'});
      final entity2 = MapEntity('null_map', {'key1': null, 'key2': 'value'});
      final entity3 = MapEntity('null_map', {'key1': 'not_null', 'key2': 'value'});

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(entity3)));
    });
  });

  group('NestedEntity Equality', () {
    test('should correctly compare entities with nested DeepEquatable objects', () {
      final child1 = SimpleEntity('child1', 100, true);
      final child2 = SimpleEntity('child1', 100, true);
      final child3 = SimpleEntity('child2', 200, false);

      final listChild1_1 = ListEntity('listA', [1,2], ['x']);
      final listChild1_2 = ListEntity('listA', [1,2], ['x']);
      final listChild2 = ListEntity('listB', [3,4], ['y']);

      final entity1 = NestedEntity('parent1', child1, [listChild1_1]);
      final entity2 = NestedEntity('parent1', child2, [listChild1_2]);
      final entity3 = NestedEntity('parent1', child3, [listChild1_1]);
      final entity4 = NestedEntity('parent1', child1, [listChild2]);

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(entity3)));
      expect(entity1, isNot(equals(entity4)));
    });

    test('should correctly compare entities with nested lists of DeepEquatable objects', () {
      final list1 = [ListEntity('A', [1], []), ListEntity('B', [2], [])];
      final list2 = [ListEntity('A', [1], []), ListEntity('B', [2], [])];
      final list3 = [ListEntity('A', [1], []), ListEntity('C', [3], [])];

      final entity1 = NestedEntity('parent_list', SimpleEntity('x', 0, true), list1);
      final entity2 = NestedEntity('parent_list', SimpleEntity('x', 0, true), list2);
      final entity3 = NestedEntity('parent_list', SimpleEntity('x', 0, true), list3);

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(entity3)));
    });
  });

  group('NullablePropsEntity Equality', () {
    test('should consider entities with identical null properties as equal', () {
      final entity1 = NullablePropsEntity(null, null, null);
      final entity2 = NullablePropsEntity(null, null, null);
      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
    });

    test('should consider entities with some null and some non-null properties', () {
      final entity1 = NullablePropsEntity('name', 30, ['item1']);
      final entity2 = NullablePropsEntity('name', 30, ['item1']);
      final entity3 = NullablePropsEntity('name', 30, null);
      final entity4 = NullablePropsEntity('name', null, ['item1']);
      final entity5 = NullablePropsEntity(null, 30, ['item1']);

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(entity3)));
      expect(entity1, isNot(equals(entity4)));
      expect(entity1, isNot(equals(entity5)));
    });
  });

  test('toString() should return a useful string representation for SimpleEntity', () {
    final entity = SimpleEntity('test_id', 123, true);
    expect(entity.toString(), 'SimpleEntity{test_id, 123, true}');
  });

  test('toString() should return a useful string representation for ListEntity', () {
    final entity = ListEntity('my_list', [1, 2], ['a', 'b']);
    expect(entity.toString(), contains('ListEntity{my_list, [1, 2], [a, b]}'));
  });

  test('toString() should return a useful string representation for MapEntity', () {
    final entity = MapEntity('my_map', {'key1': 'value1', 'key2': 123});
    expect(entity.toString(), contains('MapEntity{my_map, {key1: value1, key2: 123}}'));
  });
}

final class SimpleEntity with DeepEquatable {
  final String id;
  final int value;
  final bool isActive;

  SimpleEntity(this.id, this.value, this.isActive);

  @override
  List<Object?> get props => [id, value, isActive];
}

final class ListEntity with DeepEquatable {
  final String name;
  final List<int> numbers;
  final List<String?> texts;

  ListEntity(this.name, this.numbers, this.texts);

  @override
  List<Object?> get props => [name, numbers, texts];
}

final class MapEntity with DeepEquatable {
  final String type;
  final Map<String, dynamic> data;

  MapEntity(this.type, this.data);

  @override
  List<Object?> get props => [type, data];
}

final class NestedEntity with DeepEquatable {
  final String parentId;
  final SimpleEntity child;
  final List<ListEntity> childrenLists;

  NestedEntity(this.parentId, this.child, this.childrenLists);

  @override
  List<Object?> get props => [parentId, child, childrenLists];
}

final class NullablePropsEntity with DeepEquatable {
  final String? name;
  final int? age;
  final List<String>? items;

  NullablePropsEntity(this.name, this.age, this.items);

  @override
  List<Object?> get props => [name, age, items];
}