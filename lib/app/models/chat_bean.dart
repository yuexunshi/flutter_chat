class ChatBean {
  final String msg;
  final int chatIndex;

  ChatBean({required this.msg, required this.chatIndex});

  factory ChatBean.fromJson(Map<String, dynamic> json) => ChatBean(
        msg: json["msg"],
        chatIndex: json["chatIndex"],
      );
}
