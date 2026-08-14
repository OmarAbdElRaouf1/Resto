import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                width: double.infinity,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),

              Gap(12.h),

              // Product name
              Container(
                width: 120.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),

              Gap(8.h),

              // Description
              Container(
                width: double.infinity,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),

              Gap(6.h),

              Container(
                width: 80.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),

              const Spacer(),

              // Price / rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
