const _baseUrl =
    "udemy-shop-fb-default-rtdb.asia-southeast1.firebasedatabase.app";

Uri firebaseUri(String resource) => Uri.https(_baseUrl, resource);
