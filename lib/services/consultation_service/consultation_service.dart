
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../repository/consultation_repository/get_slots_list_repository.dart';

class ConsultationService extends ChangeNotifier{
  final ConsultationRepository? repository;

  ConsultationService({this.repository});

  Future getAppointmentSlotListService(String selectedDate, {String? appointmentId}) async{
    return await repository!.getAppointmentSlotListRepo(selectedDate, appointmentId: appointmentId);
  }

  Future bookAppointmentService(String date, String slotTime, {String? appointmentId, bool isPostprogram = false}) async{
    return await repository!.bookAppointmentSlotListRepo(date, slotTime, appointmentId: appointmentId, isPostprogram: isPostprogram);
  }

  Future joinWithKaleyra(String name, String joinUrl, String accessToken) async{
    final String channelName = "callNative";


    var channel = MethodChannel(channelName);
    print("joinWithKaleyra");

    Map m = {
      'user_id': name,
      'access_token': accessToken,
      'url': joinUrl
    };

    try{
      listenForCall();
      var result = await channel.invokeMethod("kaleyra_call", m).whenComplete(() {
        // _showProgress = false;
        // notifyListeners();
      });
      print("Provider joinWithKaleyra" + result.toString());
      // final users = result['users'];
      // print("users: ${users.runtimeType}");
      notifyListeners();

    } on PlatformException catch(e){
      print("Provider joinWithKaleyra error" + e.message.toString());
      // _errorMsg = e.message.toString();
      // _isGetHomeListSuccess = false;
      notifyListeners();
    }
    // return _isGetHomeListSuccess;
  }

  Future getAccessToken(String kaleyraUID) async{
    return await repository!.getAccessTokenRepo(kaleyraUID);
  }

  listenForCall()
  {
    String eventChannelName = "callNative1";

    print("Listen call");
    var channel1 = EventChannel(eventChannelName);

    //same key is used in the native code also
    try {
      print('called');
      var result;
      final result1 = channel1.receiveBroadcastStream('eventChannel');
      print("eventchannel: ${result1.asBroadcastStream().listen((event) {
        // ("type","onNetworkStatusChanged");
        print("event==>: $event");
        // if(event['type'].toString().contains(Constants.onNetworkChange)){
        //   _deviceNetworkStatus = event['status'];
        // }
        // if(event['type'].toString().contains(Constants.onStatusChange)){
        //   _deviceStatus = event['status'].toString().contains("false") ? false : true;
        // }
      })}");
      print("result1: $result1");
      notifyListeners();
      return result1;
    }
    on PlatformException catch (e) {
      print('error: $e');
      notifyListeners();
      // Unable to open the browser print(e);
    }
  }



}