/// A function that evaluates a condition
typedef bool Condition();

/// Renders using [renderer] when [cond] is true. Renders using [elseRenderer]
/// otherwise.
String when(/* bool | Condition */ cond, String renderer(),
    [String elseRenderer() = nopRender]) {
  if (cond is Condition) cond = cond();
  if (cond) return renderer();
  return elseRenderer();
}

/// Render lists based on [Iterable]
String forEach<T>(Iterable<T> elements, String renderer(T item)) =>
    elements.map(renderer).join();

/// Render lists based on ranges
String range(int start, int end, String renderer(int index), [int step = 1]) =>
    _range(start, end, step).map(renderer).join();

/// Render lists based on ranges from 0 to arbitrary positive integer
String until(int end, String renderer(int index), [int step = 1]) =>
    _rangeUntil(end, step).map(renderer).join();

/// Render lists based on iterating over a [Map]
String map<KT, VT>(Map<KT, VT> map, String renderer(KT key, VT v, int index)) {
  final sb = new StringBuffer();

  int i = 0;
  for (KT key in map.keys) {
    sb.write(renderer(key, map[key], i));
    i++;
  }

  return sb.toString();
}

/// Iterable geenrator for ranging
Iterable<int> _range(int start, int end, [int step = 1]) sync* {
  if (step <= 0)
    throw new ArgumentError.value(step, 'step', 'Must be greater than 1!');

  if (start < end) {
    for (int i = start; i < end; i += step) {
      yield i;
    }
  } else {
    for (int i = start; i > end; i -= step) {
      yield i;
    }
  }
}

/// Iterable generator for until-ranging
Iterable<int> _rangeUntil(int end, [int step = 1]) sync* {
  if (step <= 0)
    throw new ArgumentError.value(step, 'step', 'Must be greater than 1!');

  if (end < 0) throw new ArgumentError.value(end, 'end', 'Must be positive!');

  for (int i = 0; i < end; i += step) {
    yield i;
  }
}

/// A Simple no-operation renderer
String nopRender() => '';
