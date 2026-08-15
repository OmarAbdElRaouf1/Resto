import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:resto/core/theme/app_colors.dart';
import 'package:resto/core/widgets/custom_text.dart';

class Review {
  const Review({required this.name, required this.rating, required this.comment});

  final String name;
  final int rating;
  final String comment;
}

/// UI-only reviews list + "add a review" form. Nothing here is persisted or
/// sent to the backend — new reviews just get added to local state.
class ProductReviewsSection extends StatefulWidget {
  const ProductReviewsSection({super.key});

  @override
  State<ProductReviewsSection> createState() => _ProductReviewsSectionState();
}

class _ProductReviewsSectionState extends State<ProductReviewsSection> {
  final List<Review> _reviews = const [
    Review(
      name: 'Sara Ahmed',
      rating: 5,
      comment: 'Amazing taste, will definitely order again!',
    ),
    Review(
      name: 'Mohamed Ali',
      rating: 4,
      comment: 'Good portion size and fresh ingredients.',
    ),
  ];

  final _commentController = TextEditingController();
  int _newRating = 5;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;

    setState(() {
      _reviews.insert(
        0,
        Review(name: 'You', rating: _newRating, comment: comment),
      );
      _commentController.clear();
      _newRating = 5;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Reviews',
          size: 16,
          weight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),

        Gap(12.h),

        _AddReviewCard(
          rating: _newRating,
          controller: _commentController,
          onRatingChanged: (rating) => setState(() => _newRating = rating),
          onSubmit: _submitReview,
        ),

        Gap(16.h),

        for (final review in _reviews) _ReviewTile(review: review),
      ],
    );
  }
}

class _AddReviewCard extends StatelessWidget {
  const _AddReviewCard({
    required this.rating,
    required this.controller,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  final int rating;
  final TextEditingController controller;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StarRow(rating: rating, onChanged: onRatingChanged),

          Gap(10.h),

          TextField(
            controller: controller,
            minLines: 1,
            maxLines: 3,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Write a review...',
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          Gap(10.h),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onSubmit,
              child: const CustomText(
                text: 'Post Review',
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.15),
            child: CustomText(
              text: review.name.isNotEmpty ? review.name[0] : '?',
              size: 14,
              weight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),

          const Gap(10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: review.name,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const Gap(8),
                    _StarRow(rating: review.rating, size: 14),
                  ],
                ),

                const Gap(4),

                Text(
                  review.comment,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of 5 stars. Pass [onChanged] to make it tappable (rating input),
/// leave it null to render a read-only rating.
class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating, this.onChanged, this.size = 22});

  final int rating;
  final ValueChanged<int>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < rating;
        final star = Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          color: Colors.amber,
          size: size,
        );

        if (onChanged == null) return star;

        return GestureDetector(onTap: () => onChanged!(index + 1), child: star);
      }),
    );
  }
}
