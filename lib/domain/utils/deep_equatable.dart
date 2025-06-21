import 'package:collection/collection.dart';

/// A mixin that facilitates value-based object comparison in Dart,
/// including deep comparison for collections (lists and maps).
///
/// To use DeepEquatableMixin, apply it to your class and override the `props`
/// getter to return a list of all properties that should be used for equality checks.
mixin DeepEquatable {
  List<Object?> get props;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    final DeepEquatable otherEquatable = other as DeepEquatable;

    if (props.length != otherEquatable.props.length) {
      return false;
    }

    for (int i = 0; i < props.length; i++) {
      final p1 = props[i];
      final p2 = otherEquatable.props[i];

      if (p1 is Iterable && p2 is Iterable) {
        if (!const DeepCollectionEquality().equals(p1, p2)) {
          return false;
        }
      } else if (p1 is Map && p2 is Map) {
        if (!const DeepCollectionEquality().equals(p1, p2)) {
          return false;
        }
      } else if (p1 != p2) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode {
    final deepHashes = props.map((p) {
      if (p is Iterable) {
        return const DeepCollectionEquality().hash(p);
      } else if (p is Map) {
        return const DeepCollectionEquality().hash(p);
      }
      return p.hashCode;
    }).toList();

    return Object.hashAll(deepHashes);
  }

  @override
  String toString() {
    return '$runtimeType{${props.map((p) => p.toString()).join(', ')}}';
  }
}