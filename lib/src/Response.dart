class TgSDKResponse {
  final String scene;
  final String result;
  final String error;
  final bool couldReward;

  TgSDKResponse.fromMap(Map map)
      : scene = map["scene"],
        result = map["result"],
        error = map["error"],
        couldReward = map["couldReward"];
}

class PreloadResponse {
  final String result;

  PreloadResponse.fromMap(Map map)
      : result = map["result"];
}