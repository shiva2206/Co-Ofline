class NotificationModel{
  String? orderId;

  String? get order_id => orderId;

  set order_id(String? value) {
    orderId = value;
  }
  String? orderStatus;
  String? time;

  NotificationModel({required this.orderId, required this.orderStatus, required this.time });

}

class NotificationList {
  List<NotificationModel> statusList = [
    NotificationModel(
        orderId: '#1234567890', orderStatus: 'cancelled', time: '12:01 pm'),
    NotificationModel(
        orderId: '#1234567890', orderStatus: 'accepted ', time: '06:00 pm'),
    NotificationModel(orderId: '#1234567890', orderStatus: 'ready     ', time: '11:45 am')
  ];
}