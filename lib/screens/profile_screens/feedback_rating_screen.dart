import 'dart:io';
import 'package:async/async.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gwc_customer/model/error_model.dart';
import 'package:gwc_customer/model/profile_model/feedback_model.dart';
import 'package:gwc_customer/repository/profile_repository/feedback_repo.dart';
import 'package:gwc_customer/services/profile_screen_service/feedback_service.dart';
import 'package:gwc_customer/widgets/constants.dart';
import 'package:gwc_customer/widgets/unfocus_widget.dart';
import 'package:gwc_customer/widgets/widgets.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:http/http.dart' as http;
import '../../repository/api_service.dart';
import '../../utils/app_config.dart';

class FeedbackRatingScreen extends StatefulWidget {
  const FeedbackRatingScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackRatingScreen> createState() => _FeedbackRatingScreenState();
}

class _FeedbackRatingScreenState extends State<FeedbackRatingScreen> {
  final feedbackController = TextEditingController();

  final _focusNode = FocusNode();

  bool isSubmitted = false;

  List<PlatformFile> files = [];
  List<File> fileFormatList = [];
  List<MultipartFile> newList = <MultipartFile>[];

  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if(!_focusNode.hasFocus){
        print("focus changed");
        setState(() {
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(() { });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: newUI(context),
    );
  }

  double rating = 0.0;
  Widget buildRating() {
    return SmoothStarRating(
      color: gMainColor,
      borderColor: gWhiteColor,
      rating: rating,
      size: 35,
      filledIconData: Icons.star_sharp,
      halfFilledIconData: Icons.star_half_sharp,
      defaultIconData: Icons.star_outline_sharp,
      starCount: 5,
      allowHalfRating: false,
      spacing: 1.0,
      onRatingChanged: (value){
        print(value);
        setState(() {
          rating = value;
        });
      },
    );
  }

  submitRating() async{
    setState(() {
      isSubmitted = true;
    });
    Map feedback = {
      'rating' : rating.toString(),
      'feedback' : feedbackController.text
    };

    final res = await FeedbackService(repository: repository).submitFeedbackService(feedback, newList);

    if(res.runtimeType == FeedbackModel){
      FeedbackModel model = res as FeedbackModel;
      AppConfig().showSnackbar(context, model.errorMsg ?? '');
    }
    else{
      ErrorModel model = res as ErrorModel;
      AppConfig().showSnackbar(context, model.message ?? '', isError: true);
    }
    setState(() {
      isSubmitted = false;
    });
  }

  final FeedbackRepository repository = FeedbackRepository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
  );

  oldUI(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h, bottom: 1.h),
            child:ListView(
              shrinkWrap: true,
              children: [
                buildAppBar(() {}),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Give Feedback',
                      style: TextStyle(
                          fontFamily: "GothamRoundedBold_21016",
                          color: gTextColor,
                          height: 2,
                          fontSize: 12.sp
                      ),
                    ),
                    Text('What do you think of the program',
                      style: TextStyle(
                        fontFamily: "GothamBold",
                        color: gTextColor,
                        height: 2,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    buildRating(),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Text('Do you have any thoughts you\'d like to share?',
                      style: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gTextColor,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      minLines: 6,
                      maxLines: 8,
                      focusNode: _focusNode,
                      controller: feedbackController,
                      keyboardType: TextInputType.multiline,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gMainColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gMainColor, width: 1),
                        ),
                        hintText: 'Your answer...',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          submitRating();
                        },
                        child: Container(
                          width: 60.w,
                          height: 6.h,
                          padding:
                          EdgeInsets.symmetric(horizontal: 5.w),
                          decoration: BoxDecoration(
                            color: feedbackController.text.isEmpty ? gMainColor : gPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: gMainColor, width: 1),
                          ),
                          child: Center(
                            child: (isSubmitted) ? buildThreeBounceIndicator() : Text(
                              'Submit',
                              style: TextStyle(
                                fontFamily: "GothamRoundedBold_21016",
                                color: feedbackController.text.isEmpty ? gPrimaryColor : gMainColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  newUI(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: const AssetImage("assets/images/eval_bg.png"),
            fit: BoxFit.fitWidth,
            colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.lighten)
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: showUI(context),
        ),
      ),
    );
  }
  showUI(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buildAppBar(() {
              //   Navigator.pop(context);
              // }),
              Text('How would you rate your experience with our Program?',
                style: TextStyle(
                    fontFamily: "GothamRoundedBold_21016",
                    color: gWhiteColor,
                    height: 2,
                    fontSize: 12.sp
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              buildRating(),
              SizedBox(
                height: 3.h,
              ),
            ],
          )
        ),
        SizedBox(
          height: 2.h,
        ),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2, color: Colors.grey.withOpacity(0.5))
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tell us a bit more about why you choose $rating',
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      color: gTextColor,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Form(
                    key: formKey,
                    child: TextFormField(
                      minLines: 6,
                      maxLines: 8,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Tell us more';
                        }
                      },
                      focusNode: _focusNode,
                      controller: feedbackController,
                      keyboardType: TextInputType.multiline,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gMainColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gMainColor, width: 1),
                        ),
                        hintText: 'Your answer...',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  (files.isEmpty) ? GestureDetector(
                    onTap: (){
                      pickFromFile();
                    },
                    child: Row(

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.folder),
                        Text('Upload File',
                          style: TextStyle(
                            fontFamily: 'GothamBold',
                            decoration: TextDecoration.underline,
                            color: gPrimaryColor
                          ),
                        )
                      ],
                    ),
                  ) : Text(
                    "Uploaded File",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "GothamRoundedBold_21016",
                        color: gPrimaryColor,
                        fontSize: 11.sp),
                  ),
                  if(files.isNotEmpty)
                    Image.file(
                      File(files.first.path.toString()),
                      width: 65.w,
                      height: 15.h,
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        if(rating == 0.0){
                          AppConfig().showSnackbar(context, "Please select the rating");
                        }
                        else if(formKey.currentState!.validate()){
                          submitRating();
                        }
                      },
                      child: Container(
                        width: 60.w,
                        height: 6.h,
                        padding:
                        EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration(
                          color: (feedbackController.text.isEmpty || rating == 0.0) ? gMainColor : gPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: gMainColor, width: 1),
                        ),
                        child: Center(
                          child: (isSubmitted) ? buildThreeBounceIndicator() : Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: "GothamRoundedBold_21016",
                              color: (feedbackController.text.isEmpty || rating == 0.0) ? gPrimaryColor : gMainColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void pickFromFile() async{
    final result = await FilePicker.platform
        .pickFiles(
      withReadStream: true,
      type: FileType.any,
      // allowedExtensions: ['pdf', 'jpg', 'png'],
      allowMultiple: false,
    );
    if (result == null) return;

    if(result.files.first.extension!.contains("png") || result.files.first.extension!.contains("jpg")){
      if(getFileSize(File(result.paths.first!)) <= 2){
        print("filesize: ${getFileSize(File(result.paths.first!))}Mb");
        files.add(result.files.first);
        addFilesToList(File(result.paths.first!));
      }
      else{
        AppConfig().showSnackbar(context, "File size must be <2Mb", isError: true);
      }
    }
    else{
      AppConfig().showSnackbar(context, "Please select png/jpg files", isError: true);
    }
    setState(() {});
  }

  getFileSize(File file){
    var size = file.lengthSync();
    num mb = num.parse((size / (1024*1024)).toStringAsFixed(2));
    return mb;
  }

  void _delete(int index) {
    files.removeAt(index);
    fileFormatList.removeAt(index);
    setState(() {});
  }

  addFilesToList(File file) async{
    newList.clear();
    setState(() {
      fileFormatList.add(file);
    });

    for (int i = 0; i < fileFormatList.length; i++) {
      var stream = http.ByteStream(DelegatingStream.typed(fileFormatList[i].openRead()));
      var length = await fileFormatList[i].length();
      var multipartFile = http.MultipartFile("files[]", stream, length,
          filename: fileFormatList[i].path);
      newList.add(multipartFile);
    }

    setState(() {});
  }


}
