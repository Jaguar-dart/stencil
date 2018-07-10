library stencil;

import 'package:stencil/core/core.dart' as core;

String render(Component comp) => comp.render();

/// Base class for a Stencil component
///
/// Use [render] method to render the compoenent
///
/// Extend render method to implement templates
///
/// Use [forEach] in templates to
abstract class Component {
  /// Conditional rendering
  String when(/* bool | Condition */ cond, /* String | Function */ renderer,
          [/* String | Function */ elseRenderer = '']) =>
      core.when(cond, renderer, elseRenderer);

  /// Render lists based on [Iterable]
  String forEach<T>(Iterable<T> elements, String renderer(T item)) =>
      core.forEach(elements, renderer);

  /// Render lists based on ranges
  String range(int start, int end, String renderer(int index),
          [int step = 1]) =>
      core.range(start, end, renderer, step);

  /// Render lists based on ranges from 0 to arbitrary positive integer
  String until(int end, String renderer(int index), [int step = 1]) =>
      core.until(end, renderer, step);

  /// Render lists based on iterating over a [Map]
  String map<KT, VT>(
          Map<KT, VT> map, String renderer(KT key, VT v, int index)) =>
      core.map(map, renderer);

  /// Render another component
  String comp(Component c) => c.render();

  /// Implements the actual rendering
  String render();
}
