part of widget;

class CustomStarRating extends StatelessWidget {
  final double rating;
  final bool isReadOnly;
  final RatingChangeCallback? onRating;

  const CustomStarRating({super.key, required this.rating, this.isReadOnly = true, this.onRating});

  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      rating: rating,
      size: 20.0,
      starCount: 5,
      color: Colors.yellow,
      borderColor: Colors.orange,
      // isReadOnly: isReadOnly,
      // onRated: onRating,
    );
  }
}
