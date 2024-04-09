import 'package:parse_json/parse_json.dart';

final class MessageModal {
  final String message;
  final String sessionId;
  final bool sendByMe;

  MessageModal({
    required this.message,
    required this.sessionId,
    required this.sendByMe,
  });

  factory MessageModal.fromJson(dynamic json) => parse(MessageModal.new, json, {
        'message': string,
        'sessionId': string,
        'sendByMe': boolean,
      });
}
