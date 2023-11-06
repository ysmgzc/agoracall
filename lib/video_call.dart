import 'dart:async';
import 'dart:convert';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideoCall extends StatefulWidget {
  String channelName;
  VideoCall({required this.channelName}); 
   @override
  _VideoCallState createState() => _VideoCallState();
  }

class _VideoCallState extends State<VideoCall> {
 late final AgoraClient client;  
 bool _loading = true; // Başlangıçta false olarak ayarlandı
  String tempToken = "";
  void initAgora() async {   
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "11cbd9028a3a414d96928831fc206001",
        tempToken: tempToken.toString(),
        channelName: widget.channelName,
      ),
      enabledPermission: [Permission.camera, Permission.microphone]);
  await client.initialize();
  setState(() {
    _loading = false;     
     print("ysm: ${tempToken}");
    print("kanal: ${widget.channelName}");    
    });
  }
  @override  
  void initState() {
    getToken();    
    super.initState();
  }
  Future<void> getToken() async {    String link =
      "https://agora-node-tokenserver-1.gezici267.repl.co/access_token?channelName=${widget.channelName}";    
      Response _response = await get(Uri.parse(link));
  Map data = jsonDecode(_response.body);   
   setState(() {
    tempToken = data["token"];      
    print("hello ysm :${tempToken}");
  });   
   setState(() {
    initAgora();   
     });
  }
  @override  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(        
        child: _loading
          ? Center(                
            child: CircularProgressIndicator(),
      ): Stack(
        children: [                 
          AgoraVideoViewer(
          client: client,
         ),
          AgoraVideoButtons(client: client)               
          ],
      ),      ),
    );  }
}