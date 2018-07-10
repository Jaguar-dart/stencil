// Copyright (c) 2017, SERAGUD. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:stencil/stencil.dart';

/// Sample model
class Movie {
  final String name;

  final String description;

  final int stars;

  Movie(this.name, this.description, this.stars) {
    if (stars < 0 || stars > 5)
      throw new ArgumentError.value(stars, 'stars', 'Must be between 0 and 5!');
  }
}

/// Demonstrates loops using [until]
class RatingComponent extends Component {
  final int stars;

  RatingComponent(this.stars);

  @override
  String render() {
    return '''
<div class="stars-holder">
  ${until(stars, (i) => '<div class="star star-filled">\u2b50</div>\n  ')}
  ${until(5-stars, (i) => '<div class="star">\u2b50</div>')}
</div>''';
  }
}

// Demonstrates simple binding
class MovieComponent extends Component {
  final Movie movie;

  MovieComponent(this.movie);

  @override
  String render() {
    return '''
<div class="movie-card">
  <div class="movie-name">${movie.name}</div>
  <div class="movie-description">${movie.description}</div>
</div>    
    ''';
  }
}

/// Demonstrates nested components
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
}

void main() {
  final Movie castaway = new Movie(
      'Cast away',
      'Obsessively punctual FedEx executive Chuck Noland (Tom Hanks) is en route to an assignment in Malaysia when his plane crashes over the Pacific Ocean during a storm.',
      4);

  querySelector('#example-loop').setInnerHtml(RatingComponent(4).render());
  querySelector('#example-data-binding')
      .setInnerHtml(MovieComponent(castaway).render());
  querySelector('#example-component')
      .setInnerHtml(MovieCardComponent(castaway).render());
}
