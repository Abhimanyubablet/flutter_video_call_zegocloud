import 'package:flutter/cupertino.dart';
import 'package:video_calling_task/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZimVideocall extends StatefulWidget {
  final String callid;
  final String userid;

  const ZimVideocall({
    super.key,
    required this.callid,
    required this.userid
  });

  @override
  State<ZimVideocall> createState() => _ZimVideocallState();
}

class _ZimVideocallState extends State<ZimVideocall> {
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: Utils.appId,
        appSign: Utils.appSignin,
        callID: widget.callid,
        userID: widget.userid,
        userName: "User : ${widget.userid}",
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
