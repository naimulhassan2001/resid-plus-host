import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/main.dart';
import 'package:resid_plus/service/notification.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService extends GetxController{

  late io.Socket socket;

  // NotificationClass notificationClass = NotificationClass();

  List<dynamic> messageList = [];
  String chatId = "";

  bool isLoading = false;
  //
  void connectToSocket() {
    socket = io.io(
      ApiUrlContainer.socketUrl,
      io.OptionBuilder().setTransports(['websocket']).enableAutoConnect().build()
    );

    socket.onConnect((data) => print("Connection Established"));
    socket.onConnectError((data) => print("Connection Error"));

    socket.connect();

    socket.on('join-check', (data) {
      print("this is: $data");
    });

    socket.on('new-chat', (chat) {
      chatId = chat["_id"];
      joinChat(chatId);
      update();
    });

    socket.on('all-messages', (messages) {
      messageList.clear();
      isLoading = true;
      update();

      if(messages is List){
        for(var message in messages){
          if(message is Map<String, dynamic>){
            messageList.add(message);
          }
        }
      }

      isLoading = false;
      update();
    });

    socket.on('host-notification', (data) {
      if (data == null) {
        print("No Data: $data");
      } else {
        NotificationHelper.showNotification(body: data, fln: fln);
        print("This is  Data: $data");
        //print("This is Data msg : ${data['allNotification'][0]['message']}");
      }
    });
  }

  void joinRoom(String uid) {
    socket.emit('join-room', {'uid': uid});
  }

  void addNewChat(Map chatInfo, String uid) {
    socket.emit('add-new-chat', {'chatInfo': chatInfo, "uid": uid});
  }

  joinChat(String uid) {
    socket.emit('join-chat', {'uid': uid});
  }

  addNewMessage(String message, String sender, String chat) {
    socket.emit('add-new-message', {"message": message, "sender": sender, "chat": chat});
  }

  getAllChats(String uid) {
    socket.emit('get-all-chats', {'uid': uid});
  }

  void getNotification(String uid) {
    socket.emit('join-room', {'uid': uid});
  }

  fetchAllChat({required Function(List<dynamic>) didFetchChats}){
    List<dynamic> preMessageList = messageList;
    didFetchChats(preMessageList);
  }

  void disconnect() {
    socket.disconnect();
  }
}
