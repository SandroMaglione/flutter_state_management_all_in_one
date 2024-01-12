class _Node<V> {
  final String key;
  V? value;

  final _Node<V>? left;
  final _Node<V>? mid;
  final _Node<V>? right;

  _Node({
    required this.key,
    this.value,
    this.left,
    this.mid,
    this.right,
  });

  @override
  bool operator ==(Object other) =>
      (other is _Node<V>) &&
      other.key == key &&
      other.value == value &&
      other.left == left &&
      other.mid == mid &&
      other.right == right;

  @override
  int get hashCode =>
      key.hashCode ^
      value.hashCode ^
      left.hashCode ^
      mid.hashCode ^
      right.hashCode;
}

class _ITrieIterator<V> implements Iterator<(String, V)> {
  List<(_Node<V>, String, bool)> stack = [];
  late (String, V) _current;

  final ITrie<V> _trie;

  _ITrieIterator(this._trie) {
    final root = _trie._root;
    if (root != null) {
      stack.add((root, "", false));
    }
  }

  @override
  (String, V) get current => _current;

  @override
  bool moveNext() {
    while (stack.isNotEmpty) {
      final (node, keyString, isAdded) = stack.removeLast();

      if (isAdded) {
        final value = node.value;
        if (value != null) {
          final key = keyString + node.key;
          _current = (key, value);
          return true;
        }
      } else {
        _addToStack(node, keyString);
      }
    }

    return false;
  }

  void _addToStack(_Node<V> node, String keyString) {
    final right = node.right;
    if (right != null) {
      stack.add((right, keyString, false));
    }

    final mid = node.mid;
    if (mid != null) {
      stack.add((mid, keyString + node.key, false));
    }
    stack.add((node, keyString, true));

    final left = node.left;
    if (left != null) {
      stack.add((left, keyString, false));
    }
  }
}

class ITrie<V> extends Iterable<(String, V)> {
  final _Node<V>? _root;
  final int _count;

  const ITrie._(this._root, this._count);

  factory ITrie.empty() => ITrie._(null, 0);
  factory ITrie.fromIterable(Iterable<(String, V)> entries) {
    ITrie<V> itrie = ITrie.empty();
    for (final (key, value) in entries) {
      itrie = itrie.insert(key, value);
    }
    return itrie;
  }

  @override
  Iterator<(String, V)> get iterator => _ITrieIterator(this);

  ITrie<V> insert(String key, V value) {
    if (key.isEmpty) return this;

    // -1:left | 0:mid | 1:right
    final List<int> dStack = [];
    final List<_Node<V>> nStack = [];

    _Node<V> n = _root ?? _Node(key: key[0]);
    int cIndex = 0;

    while (cIndex < key.length) {
      final c = key[cIndex];
      nStack.add(n);

      final compare = c.compareTo(n.key);
      if (compare > 0) {
        dStack.add(1);

        final right = n.right;
        if (right == null) {
          n = _Node(key: c);
        } else {
          n = right;
        }
      } else if (compare < 0) {
        dStack.add(-1);

        final left = n.left;
        if (left == null) {
          n = _Node(key: c);
        } else {
          n = left;
        }
      } else {
        final mid = n.mid;
        if (cIndex == key.length - 1) {
          n.value = value;
        } else if (mid == null) {
          dStack.add(0);
          n = _Node(key: key[cIndex + 1]);
        } else {
          dStack.add(0);
          n = mid;
        }

        cIndex += 1;
      }
    }

    // Rebuild path to leaf node (Path-copying immutability)
    for (int s = nStack.length - 2; s >= 0; --s) {
      final n2 = nStack[s];
      final d = dStack[s];
      if (d < 0) {
        // left
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: nStack[s + 1],
          mid: n2.mid,
          right: n2.right,
        );
      } else if (d > 0) {
        // right
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: n2.mid,
          right: nStack[s + 1],
        );
      } else {
        // mid
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: nStack[s + 1],
          right: n2.right,
        );
      }
    }

    return ITrie._(nStack[0], _count + 1);
  }

  V? get(String key) {
    if (_root == null || key.isEmpty) return null;

    _Node<V> n = _root;
    int cIndex = 0;

    while (cIndex < key.length) {
      final c = key[cIndex];
      final compare = c.compareTo(n.key);
      if (compare > 0) {
        final right = n.right;
        if (right == null) {
          return null;
        } else {
          n = right;
        }
      } else if (compare < 0) {
        final left = n.left;
        if (left == null) {
          return null;
        } else {
          n = left;
        }
      } else {
        if (cIndex == key.length - 1) {
          return n.value;
        } else {
          final mid = n.mid;
          if (mid == null) {
            return null;
          } else {
            n = mid;
            cIndex += 1;
          }
        }
      }
    }

    return null;
  }

  ITrie<V> remove(String key) {
    if (_root == null || key.isEmpty) return this;

    _Node<V> n = _root;
    // -1:left | 0:mid | 1:right
    final List<int> dStack = [];
    final List<_Node<V>> nStack = [];

    int cIndex = 0;
    while (cIndex < key.length) {
      final c = key[cIndex];
      final compare = c.compareTo(n.key);
      if (compare > 0) {
        final right = n.right;
        if (right == null) {
          return this;
        } else {
          nStack.add(n);
          dStack.add(1);
          n = right;
        }
      } else if (compare < 0) {
        final left = n.left;
        if (left == null) {
          return this;
        } else {
          nStack.add(n);
          dStack.add(-1);
          n = left;
        }
      } else {
        if (cIndex == key.length - 1) {
          if (n.value != null) {
            nStack.add(n);
            dStack.add(0);
            cIndex += 1;
          } else {
            return this;
          }
        } else {
          final mid = n.mid;
          if (mid == null) {
            return this;
          } else {
            nStack.add(n);
            dStack.add(0);
            n = mid;
            cIndex += 1;
          }
        }
      }
    }

    final removeNode = nStack[nStack.length - 1];
    nStack[nStack.length - 1] = _Node(
      key: removeNode.key,
      left: removeNode.left,
      mid: removeNode.mid,
      right: removeNode.right,
    );

    // Rebuild path to leaf node (Path-copying immutability)
    for (int s = nStack.length - 2; s >= 0; --s) {
      final n2 = nStack[s];
      final d = dStack[s];
      final child = nStack[s + 1];
      final nc = child.left == null && child.mid == null && child.right == null
          ? null
          : child;
      if (d < 0) {
        // left
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: nc,
          mid: n2.mid,
          right: n2.right,
        );
      } else if (d > 0) {
        // right
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: n2.mid,
          right: nc,
        );
      } else {
        // mid
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: nc,
          right: n2.right,
        );
      }
    }

    return ITrie._(nStack[0], _count - 1);
  }

  ITrie<V> modify(String key, V Function(V value) f) {
    if (_root == null || key.isEmpty) return this;

    _Node<V> n = _root;
    // -1:left | 0:mid | 1:right
    final List<int> dStack = [];
    final List<_Node<V>> nStack = [];

    int cIndex = 0;
    while (cIndex < key.length) {
      final c = key[cIndex];
      final compare = c.compareTo(n.key);
      if (compare > 0) {
        final right = n.right;
        if (right == null) {
          return this;
        } else {
          nStack.add(n);
          dStack.add(1);
          n = right;
        }
      } else if (compare < 0) {
        final left = n.left;
        if (left == null) {
          return this;
        } else {
          nStack.add(n);
          dStack.add(-1);
          n = left;
        }
      } else {
        if (cIndex == key.length - 1) {
          if (n.value != null) {
            nStack.add(n);
            dStack.add(0);
            cIndex += 1;
          } else {
            return this;
          }
        } else {
          final mid = n.mid;
          if (mid == null) {
            return this;
          } else {
            nStack.add(n);
            dStack.add(0);
            n = mid;
            cIndex += 1;
          }
        }
      }
    }

    final updateNode = nStack[nStack.length - 1];
    final value = updateNode.value;
    if (value == null) {
      return this;
    }

    nStack[nStack.length - 1] = _Node(
      key: updateNode.key,
      value: f(value), // Update
      left: updateNode.left,
      mid: updateNode.mid,
      right: updateNode.right,
    );

    // Rebuild path to leaf node (Path-copying immutability)
    for (int s = nStack.length - 2; s >= 0; --s) {
      final n2 = nStack[s];
      final d = dStack[s];
      final child = nStack[s + 1];
      if (d < 0) {
        // left
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: child,
          mid: n2.mid,
          right: n2.right,
        );
      } else if (d > 0) {
        // right
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: n2.mid,
          right: child,
        );
      } else {
        // mid
        nStack[s] = _Node(
          key: n2.key,
          value: n2.value,
          left: n2.left,
          mid: child,
          right: n2.right,
        );
      }
    }

    return ITrie._(nStack[0], _count);
  }

  ITrie<V> insertMany(Iterable<(String, V)> iter) {
    var itrie = this;
    for (final (key, value) in iter) {
      itrie = itrie.insert(key, value);
    }
    return itrie;
  }

  ITrie<V> removeMany(Iterable<String> iter) {
    var itrie = this;
    for (final key in iter) {
      itrie = itrie.remove(key);
    }
    return itrie;
  }

  (String, V)? longestPrefixOf(String key) {
    if (_root == null || key.isEmpty) return null;

    _Node<V> n = _root;
    (String, V)? longestPrefixNode;
    int cIndex = 0;

    while (cIndex < key.length) {
      final c = key[cIndex];

      final value = n.value;
      if (value != null) {
        longestPrefixNode = (key.substring(0, cIndex + 1), value);
      }

      final compare = c.compareTo(n.key);
      if (compare > 0) {
        final right = n.right;
        if (right == null) {
          break;
        } else {
          n = right;
        }
      } else if (compare < 0) {
        final left = n.left;
        if (left == null) {
          break;
        } else {
          n = left;
        }
      } else {
        final mid = n.mid;
        if (mid == null) {
          break;
        } else {
          n = mid;
          cIndex += 1;
        }
      }
    }

    return longestPrefixNode;
  }

  Iterable<(String, V)> withPrefix(String prefix) =>
      where((entry) => entry.$1.startsWith(prefix));

  Iterable<String> keysWithPrefix(String prefix) =>
      withPrefix(prefix).map((e) => e.$1);

  Iterable<V> valuesWithPrefix(String prefix) =>
      withPrefix(prefix).map((e) => e.$2);

  Iterable<String> get keys => map((entry) => entry.$1);
  Iterable<V> get values => map((entry) => entry.$2);
  bool has(String key) => get(key) != null;

  @override
  int get length => _count;

  @override
  String toString() {
    return "ITrie(${toList().toString()})";
  }

  @override
  bool operator ==(Object other) => (other is ITrie<V>) && other._root == _root;

  @override
  int get hashCode => _root.hashCode;
}
