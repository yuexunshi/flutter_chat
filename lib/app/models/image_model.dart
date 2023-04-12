import 'package:flutter_nb_net/flutter_net.dart';

/// created : 1681113416
/// data : [{"url":"https://oaidalleapiprodscus.blob.core.windows.net/private/org-qVnnz3MAPhHq866Qnn636Toc/user-24zYIugaIVMyT9HlGgvkDUSi/img-7WC8HBNej8kYDgPLNbngJfkI.png?st=2023-04-10T06%3A56%3A56Z&se=2023-04-10T08%3A56%3A56Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-04-09T14%3A58%3A26Z&ske=2023-04-10T14%3A58%3A26Z&sks=b&skv=2021-08-06&sig=s4KXPLp351cgw0HTFA2sJDobyV1d0Ill1LpR7qxz/ng%3D"},{"url":"https://oaidalleapiprodscus.blob.core.windows.net/private/org-qVnnz3MAPhHq866Qnn636Toc/user-24zYIugaIVMyT9HlGgvkDUSi/img-gwY5LH6WzVBkimCqGepb1OWj.png?st=2023-04-10T06%3A56%3A56Z&se=2023-04-10T08%3A56%3A56Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-04-09T14%3A58%3A26Z&ske=2023-04-10T14%3A58%3A26Z&sks=b&skv=2021-08-06&sig=RhAApTPCP1iKvWZ21wdn5qq1nb6JdYIi20cJ4iCL5Mk%3D"}]

class ImageModel extends BaseNetModel{
  ImageModel({
      this.created, 
      this.data,});

  ImageModel.fromJson(dynamic json) {
    created = json['created'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ImageBean.fromJson(v));
      });
    }
  }
  num? created;
  List<ImageBean>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = created;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return ImageModel.fromJson(json);
  }

}

/// url : "https://oaidalleapiprodscus.blob.core.windows.net/private/org-qVnnz3MAPhHq866Qnn636Toc/user-24zYIugaIVMyT9HlGgvkDUSi/img-7WC8HBNej8kYDgPLNbngJfkI.png?st=2023-04-10T06%3A56%3A56Z&se=2023-04-10T08%3A56%3A56Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-04-09T14%3A58%3A26Z&ske=2023-04-10T14%3A58%3A26Z&sks=b&skv=2021-08-06&sig=s4KXPLp351cgw0HTFA2sJDobyV1d0Ill1LpR7qxz/ng%3D"

class ImageBean {
  ImageBean({
      this.url,});

  ImageBean.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}