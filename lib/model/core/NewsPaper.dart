import 'dart:convert';

class NewsPaper {
  String sourceName;
  String imageUrl;
  String url;
  String fluxUrl;
  List<String> donationUrl;

  NewsPaper({this.sourceName, this.url, this.fluxUrl, this.donationUrl});

  Map<String, dynamic> toMap() {
    return {
      'sourceName': sourceName,
      'url': url,
      'fluxUrl': fluxUrl,
      'donationUrl': donationUrl,
    };
  }

  static NewsPaper fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NewsPaper(
      sourceName: map['sourceName'],
      url: map['url'],
      fluxUrl: map['fluxUrl'],
      donationUrl: map['donationUrl'],
    );
  }

  String toJson(String source) => json.encode(toMap());

  static NewsPaper fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Source(sourceName: $sourceName, url: $url, fluxUrl: $fluxUrl, donationUrl: $donationUrl)';
  }
}