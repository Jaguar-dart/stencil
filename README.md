# Stencil

A super simple type-safe, analyzer and code-completion friendly HTML
template library for Dart.

Think code-safe, code-completable alternative to mustache.

# Features

- [x] Data binding
    - [x] Content
    - [x] Attribute
- [x] Conditional nodes (if and else)
- [x] Loops
- [x] Components

# Usage

## Simple data binding

### Model

```dart
class Movie {
  final String name;

  final String description;

  final int stars;

  Movie(this.name, this.description, this.stars) {
    if (stars < 0 || stars > 5)
      throw new ArgumentError.value(stars, 'stars', 'Must be between 0 and 5!');
  }
}
```

### Components

```dart
class MovieCardComponent extends Component {
  final Movie movie;

  MovieCardComponent(this.movie);

  @override
  String render() {
    return '''
<div class="movie-card">
  <div>${movie.name}</div>
  <div>${movie.description}</div>
</div>
    ''';
  }
}
```

### Usage

```dart
final Movie castaway = new Movie(
    'Cast away',
    'Obsessively punctual FedEx executive Chuck Noland (Tom Hanks) is en route to an assignment in Malaysia when his plane crashes over the Pacific Ocean during a storm.',
    4);

print(new MovieCardComponent(castaway).render());
```

### Rendering

```
<div class="movie-card">
  <div>Cast away</div>
  <div>Obsessively punctual FedEx executive Chuck Noland (Tom Hanks) is en route to an assignment in Malaysia when his plane crashes over the Pacific Ocean during a storm.</div>
</div>
```

## Loop range

# Components

```dart
class RatingComponent extends Component {
  final int stars;

  RatingComponent(this.stars);

  @override
  String render() {
    return '''
<div class="stars-holder">
  ${until(stars, (i) => '<div class="star-filled"></div>\n  ')}
  ${until(5-stars, (i) => '<div class="star"></div>')}
</div>''';
  }
}
```

### Usage

```dart
print(new RatingComponent(4).render());
```

### Rendering

```
<div class="stars-holder">
  <div class="star-filled"></div>
  <div class="star-filled"></div>
  <div class="star-filled"></div>
  <div class="star-filled"></div>

  <div class="star"></div>
</div>
```

## Component

### Components

```dart
class RatingComponent extends Component {
  final int stars;

  RatingComponent(this.stars);

  @override
  String render() {
    return '''
<div class="stars-holder">
  ${until(stars, (i) => '<div class="star-filled"></div>\n  ')}
  ${until(5-stars, (i) => '<div class="star"></div>')}
</div>''';
  }
}

class MovieCardComponent extends Component {
  final Movie movie;

  MovieCardComponent(this.movie);

  @override
  String render() {
    return '''
<div class="movie-card">
  <div class="movie-name">${movie.name}</div>
  <div class="movie-description">${movie.description}</div>

  ${comp(new RatingComponent(movie.stars))}
</div>
    ''';
  }
```

### Usage

```dart
final Movie castaway = new Movie(
    'Cast away',
    'Obsessively punctual FedEx executive Chuck Noland (Tom Hanks) is en route to an assignment in Malaysia when his plane crashes over the Pacific Ocean during a storm.',
    4);

print(new MovieCardComponent(castaway).render());
```

### Rendering

```
<div class="movie-card">
  <div class="movie-name">Cast away</div>
  <div class="movie-description">Obsessively punctual FedEx executive Chuck Noland (Tom Hanks) is en route to an assignment in Malaysia when his plane crashes over the Pacific Ocean during a storm.</div>

  <div class="stars-holder">
  <div class="star-filled"></div>
  <div class="star-filled"></div>
  <div class="star-filled"></div>
  <div class="star-filled"></div>

  <div class="star"></div>
</div>
</div>
```