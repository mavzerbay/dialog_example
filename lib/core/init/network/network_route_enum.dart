enum NetworkRoutes {POSTS}

extension NetworkRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.POSTS:
        return "/posts";
      default:
        throw Exception("Routes Not Found");
    }
  }
}