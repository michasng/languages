import 'dart:convert';

import 'package:languages/models/to_json.dart';
import 'package:localstorage/localstorage.dart';

class LocalStorageRepository<T extends ToJson> {
  final LocalStorage localStorage;
  final String storageKey;
  final T Function() defaultFactory;
  final T Function(Map<String, dynamic> json) fromJson;

  T? cachedValue;

  LocalStorageRepository({
    required this.localStorage,
    required this.storageKey,
    required this.defaultFactory,
    required this.fromJson,
  });

  T? get() {
    if (cachedValue != null) return cachedValue;

    final raw = localStorage.getItem(storageKey);
    if (raw == null) return null;

    final json = jsonDecode(raw);
    if (json is! Map<String, dynamic>) return null;

    return cachedValue = fromJson(json);
  }

  T getOrDefault() {
    final value = get();
    if (value == null) return defaultFactory();
    return value;
  }

  void set(T value) {
    cachedValue = null;

    final json = value.toJson();
    final raw = jsonEncode(json);
    localStorage.setItem(storageKey, raw);
  }

  void update(T Function(T value) updateFn) {
    final value = getOrDefault();
    final newValue = updateFn(value);
    set(newValue);
  }
}
