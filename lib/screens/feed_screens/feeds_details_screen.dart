import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/constants.dart';

class FeedsDetailsScreen extends StatefulWidget {
  final String profile;
  final String userName;
  final String userAddress;
  final String reelsImage;
  final String comments;

  const FeedsDetailsScreen(
      {Key? key,
      required this.profile,
      required this.userName,
      required this.userAddress,
      required this.reelsImage,
      required this.comments})
      : super(key: key);

  @override
  State<FeedsDetailsScreen> createState() => _FeedsDetailsScreenState();
}

class _FeedsDetailsScreenState extends State<FeedsDetailsScreen> {
  ByteData? placeHolderImage;

  void loadAsset(String name) async {
    var data = await rootBundle.load('assets/images/$name');
    setState(() => placeHolderImage = data);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.reelsImage);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: gGreyColor,
                            offset: Offset(2, 3),
                            blurRadius: 50,
                          ),
                        ],
                      ),
                      child: Image(
                        image: const AssetImage(
                            "assets/images/Icon ionic-ios-arrow-back.png"),
                        fit: BoxFit.fill,
                        height: 2.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  SizedBox(
                    height: 5.h,
                    width: 10.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: AssetImage(widget.profile),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                              fontFamily: "GothamMedium",
                              color: gPrimaryColor,
                              fontSize: 11.sp),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          widget.userAddress,
                          style: TextStyle(
                              fontFamily: "GothamBook",
                              color: gMainColor,
                              fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert,
                        color: gTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  image: NetworkImage(widget.reelsImage),
                ),
                // FadeInImage.memoryNetwork(
                //     placeholder: placeHolderImage.buffer.asUint8List(),
                //     image: widget.reelsImage ?? ''),
              ),
              //   SizedBox(height: 1.h),
              Text(
                widget.comments ?? "Lorem",
                style: TextStyle(
                    fontSize: 9.sp,
                    height: 1.3,
                    fontFamily: "GothamBook",
                    color: gTextColor),
              ),
              SizedBox(height: 1.h),
              Text(
                "0 View",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: gBlackColor,
                  fontFamily: "GothamMedium",
                ),
              ),
              Container(
                color: gGreyColor.withOpacity(0.2),
                height: 2,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("assets/images/Likes Icon.png"),
                    height: 3.h,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "Like",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: gBlackColor,
                      fontFamily: "GothamBook",
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Image(
                    image: const AssetImage("assets/images/Share Icon.png"),
                    height: 3.h,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "Share",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: gBlackColor,
                      fontFamily: "GothamBook",
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
