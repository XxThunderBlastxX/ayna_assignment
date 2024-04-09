part of 'cache.dart';

final class _CacheInternals {
  final SharedPreferences sharedPreferences;

  _CacheInternals(
    this.sharedPreferences,
  );

  /// Function to initialize cache
  static Future<_CacheInternals> initializeCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Read all secure storage values into cache
    return _CacheInternals(
      sharedPreferences,
    );
  }
}

/// This is set when the cache is initialized
_CacheInternals? _cacheInternals;

/// Get the cache and throw an error if it is not initialized
_CacheInternals get _cache =>
    _cacheInternals ??
    (throw Exception('Cache not initialized. Call initializeCache() first.'));

Future<void> initializeCache() async =>
    _cacheInternals = await _CacheInternals.initializeCache();
