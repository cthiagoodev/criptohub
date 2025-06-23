import 'package:criptohub/domain/utils/deep_equatable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SimpleEntity simpleEntity1;
  late SimpleEntity simpleEntity2;
  late SimpleEntity simpleEntity3;
  late SimpleEntity simpleEntity4;

  late ListEntity listEntity1;
  late ListEntity listEntity2;
  late ListEntity listEntity3;
  late ListEntity listEntity4;

  late MapEntity mapEntity1;
  late MapEntity mapEntity2;
  late MapEntity mapEntity3;
  late MapEntity mapEntity4;
  late MapEntity mapEntity5;

  late NestedEntity nestedEntity1;
  late NestedEntity nestedEntity2;
  late NestedEntity nestedEntity3;
  late NestedEntity nestedEntity4;

  late NullablePropsEntity nullableEntity1;
  late NullablePropsEntity nullableEntity2;
  late NullablePropsEntity nullableEntity3;
  late NullablePropsEntity nullableEntity4;
  late NullablePropsEntity nullableEntity5;

  setUpAll(() {
    simpleEntity1 = SimpleEntity('user1', 10, true);
    simpleEntity2 = SimpleEntity('user1', 10, true);
    simpleEntity3 = SimpleEntity('user2', 10, true);
    simpleEntity4 = SimpleEntity('user1', 20, false);

    listEntity1 = ListEntity('names', [1, 2, 3], ['a', 'b']);
    listEntity2 = ListEntity('names', [1, 2, 3], ['a', 'b']);
    listEntity3 = ListEntity('names', [1, 2, 4], ['a', 'b']);
    listEntity4 = ListEntity('names', [3, 2, 1], []);

    mapEntity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
    mapEntity2 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
    mapEntity3 = MapEntity('config', {'setting1': 1, 'setting2': 'other'});
    mapEntity4 = MapEntity('config', {'setting1': 1, 'setting3': 'value'});
    mapEntity5 = MapEntity('null_map', {'key1': null, 'key2': 'value'});

    final child1 = SimpleEntity('child1', 100, true);
    final child2 = SimpleEntity('child1', 100, true);
    final child3 = SimpleEntity('child2', 200, false);

    final listChild1_1 = ListEntity('listA', [1,2], ['x']);
    final listChild1_2 = ListEntity('listA', [1,2], ['x']);
    final listChild2 = ListEntity('listB', [3,4], ['y']);

    final listForNested1 = [listChild1_1];
    final listForNested2 = [listChild1_2];
    final listForNested3 = [listChild2];

    nestedEntity1 = NestedEntity('parent1', child1, listForNested1);
    nestedEntity2 = NestedEntity('parent1', child2, listForNested2);
    nestedEntity3 = NestedEntity('parent1', child3, listForNested1);
    nestedEntity4 = NestedEntity('parent1', child1, listForNested3);

    nullableEntity1 = NullablePropsEntity(null, null, null);
    nullableEntity2 = NullablePropsEntity(null, null, null);
    nullableEntity3 = NullablePropsEntity('name', 30, null);
    nullableEntity4 = NullablePropsEntity('name', null, ['item1']);
    nullableEntity5 = NullablePropsEntity(null, 30, ['item1']);
  });

  group("DeepEquatable Mixin", () {
    test("should consider two simple entities with same props as equal", () {
      expect(simpleEntity1, equals(simpleEntity2));
      expect(simpleEntity1.hashCode, equals(simpleEntity2.hashCode));
    });

    test('should consider two simple entities with different props as not equal', () {
      expect(simpleEntity1, isNot(equals(simpleEntity3)));
      expect(simpleEntity1, isNot(equals(simpleEntity4)));
    });

    test('should consider an entity equal to itself', () {
      final entity = simpleEntity1;
      expect(entity, equals(entity));
    });

    test('should consider entities of different types as not equal', () {
      expect(simpleEntity1, isNot(equals(listEntity1)));
    });
  });

  group('ListEntity Equality', () {
    test('should consider entities with identical lists as equal', () {
      expect(listEntity1, equals(listEntity2));
      expect(listEntity1.hashCode, equals(listEntity2.hashCode));
    });

    test('should consider entities with different list content as not equal', () {
      expect(listEntity1, isNot(equals(listEntity3)));
    });

    test('should consider entities with same list elements but different order as not equal', () {
      expect(listEntity1, isNot(equals(listEntity4)));
    });

    test('should consider entities with different list lengths as not equal', () {
      final entity1 = ListEntity('names', [1, 2, 3], []);
      final entity2 = ListEntity('names', [1, 2], []);
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle lists with null elements correctly', () {
      final entityWithNullsA = ListEntity('null_list', [1, null, 3], ['x', null]);
      final entityWithNullsB = ListEntity('null_list', [1, null, 3], ['x', null]);
      final entityNoNullsC = ListEntity('null_list', [1, 2, 3], ['x', null]);
      final entityDiffNullPlacementD = ListEntity('null_list', [1, 3, null], ['x', null]);

      expect(entityWithNullsA, equals(entityWithNullsB));
      expect(entityWithNullsA.hashCode, equals(entityWithNullsB.hashCode));
      expect(entityWithNullsA, isNot(equals(entityNoNullsC)));
      expect(entityWithNullsA, isNot(equals(entityDiffNullPlacementD)));
    });
  });

  group('MapEntity Equality', () {
    test('should consider entities with identical maps as equal', () {
      expect(mapEntity1, equals(mapEntity2));
      expect(mapEntity1.hashCode, equals(mapEntity2.hashCode));
    });

    test('should consider entities with different map values as not equal', () {
      expect(mapEntity1, isNot(equals(mapEntity3)));
    });

    test('should consider entities with different map keys as not equal', () {
      expect(mapEntity1, isNot(equals(mapEntity4)));
    });

    test('should consider entities with different map sizes as not equal', () {
      final entity1 = MapEntity('config', {'setting1': 1, 'setting2': 'value'});
      final entity2 = MapEntity('config', {'setting1': 1});
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle maps with null values correctly', () {
      expect(mapEntity5, equals(MapEntity('null_map', {'key1': null, 'key2': 'value'})));
      expect(mapEntity5.hashCode, equals(MapEntity('null_map', {'key1': null, 'key2': 'value'}).hashCode));
      expect(mapEntity5, isNot(equals(MapEntity('null_map', {'key1': 'not_null', 'key2': 'value'}))));
    });
  });

  group('NestedEntity Equality', () {
    test('should correctly compare entities with nested DeepEquatable objects', () {
      expect(nestedEntity1, equals(nestedEntity2));
      expect(nestedEntity1.hashCode, equals(nestedEntity2.hashCode));
      expect(nestedEntity1, isNot(equals(nestedEntity3)));
      expect(nestedEntity1, isNot(equals(nestedEntity4)));
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
      expect(nullableEntity1, equals(nullableEntity2));
      expect(nullableEntity1.hashCode, equals(nullableEntity2.hashCode));
    });

    test('should consider entities with some null and some non-null properties', () {
      final entity1 = NullablePropsEntity('name', 30, ['item1']);
      final entity2 = NullablePropsEntity('name', 30, ['item1']);

      expect(entity1, equals(entity2));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1, isNot(equals(nullableEntity3)));
      expect(entity1, isNot(equals(nullableEntity4)));
      expect(entity1, isNot(equals(nullableEntity5)));
    });
  });

  group('toString() Tests', () {
    test('should return a useful string representation for SimpleEntity', () {
      final entity = SimpleEntity('test_id', 123, true);
      expect(entity.toString(), 'SimpleEntity{test_id, 123, true}');
    });

    test('should return a useful string representation for ListEntity', () {
      final entity = ListEntity('my_list', [1, 2], ['a', 'b']);
      expect(entity.toString(), contains('ListEntity{my_list, [1, 2], [a, b]}'));
    });

    test('should return a useful string representation for MapEntity', () {
      final entity = MapEntity('my_map', {'key1': 'value1', 'key2': 123});
      expect(entity.toString(), contains('MapEntity{my_map, {key1: value1, key2: 123}}'));
    });
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
  final List<int?> numbers;
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