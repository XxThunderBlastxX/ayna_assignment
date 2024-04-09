import 'package:parse_json/parse_json.dart';

import '../../../../../app/utils/to_json.dart';

final class MessageModal with ToJson {
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sessionId': sessionId,
      'sendByMe': sendByMe,
    };
  }
}
