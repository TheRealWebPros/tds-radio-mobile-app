// To parse this JSON data, do
//
//     final stationSchedule = stationScheduleFromJson(jsonString);

import 'dart:convert';

class StationSchedule {
  Schedule? schedule;
  String? timezone;
  String? streamUrl;
  String? streamFormat;
  String? fallbackUrl;
  String? fallbackFormat;
  String? stationUrl;
  String? scheduleUrl;
  String? language;
  String? timestamp;
  DateTime? dateTime;
  int? updated;
  bool? success;
  Endpoints? endpoints;

  StationSchedule({
    this.schedule,
    this.timezone,
    this.streamUrl,
    this.streamFormat,
    this.fallbackUrl,
    this.fallbackFormat,
    this.stationUrl,
    this.scheduleUrl,
    this.language,
    this.timestamp,
    this.dateTime,
    this.updated,
    this.success,
    this.endpoints,
  });

  factory StationSchedule.fromRawJson(String str) =>
      StationSchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationSchedule.fromJson(Map<String, dynamic> json) =>
      StationSchedule(
        schedule: json["schedule"] == null
            ? null
            : Schedule.fromJson(json["schedule"]),
        timezone: json["timezone"],
        streamUrl: json["stream_url"],
        streamFormat: json["stream_format"],
        fallbackUrl: json["fallback_url"],
        fallbackFormat: json["fallback_format"],
        stationUrl: json["station_url"],
        scheduleUrl: json["schedule_url"],
        language: json["language"],
        timestamp: json["timestamp"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        updated: json["updated"],
        success: json["success"],
        endpoints: json["endpoints"] == null
            ? null
            : Endpoints.fromJson(json["endpoints"]),
      );

  Map<String, dynamic> toJson() => {
        "schedule": schedule?.toJson(),
        "timezone": timezone,
        "stream_url": streamUrl,
        "stream_format": streamFormat,
        "fallback_url": fallbackUrl,
        "fallback_format": fallbackFormat,
        "station_url": stationUrl,
        "schedule_url": scheduleUrl,
        "language": language,
        "timestamp": timestamp,
        "date_time": dateTime?.toIso8601String(),
        "updated": updated,
        "success": success,
        "endpoints": endpoints?.toJson(),
      };
}

class Endpoints {
  String? station;
  String? broadcast;
  String? schedule;
  String? shows;
  String? genres;
  String? languages;

  Endpoints({
    this.station,
    this.broadcast,
    this.schedule,
    this.shows,
    this.genres,
    this.languages,
  });

  factory Endpoints.fromRawJson(String str) =>
      Endpoints.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Endpoints.fromJson(Map<String, dynamic> json) => Endpoints(
        station: json["station"],
        broadcast: json["broadcast"],
        schedule: json["schedule"],
        shows: json["shows"],
        genres: json["genres"],
        languages: json["languages"],
      );

  Map<String, dynamic> toJson() => {
        "station": station,
        "broadcast": broadcast,
        "schedule": schedule,
        "shows": shows,
        "genres": genres,
        "languages": languages,
      };
}

class Schedule {
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;
  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;

  Schedule({
    this.friday,
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
  });

  factory Schedule.fromRawJson(String str) =>
      Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        friday: json["Friday"] == null
            ? []
            : List<Day>.from(json["Friday"]!.map((x) => Day.fromJson(x))),
        saturday: json["Saturday"] == null
            ? []
            : List<Day>.from(json["Saturday"]!.map((x) => Day.fromJson(x))),
        sunday: json["Sunday"] == null
            ? []
            : List<Day>.from(json["Sunday"]!.map((x) => Day.fromJson(x))),
        monday: json["Monday"] == null
            ? []
            : List<Day>.from(json["Monday"]!.map((x) => Day.fromJson(x))),
        tuesday: json["Tuesday"] == null
            ? []
            : List<Day>.from(json["Tuesday"]!.map((x) => Day.fromJson(x))),
        wednesday: json["Wednesday"] == null
            ? []
            : List<Day>.from(json["Wednesday"]!.map((x) => Day.fromJson(x))),
        thursday: json["Thursday"] == null
            ? []
            : List<Day>.from(json["Thursday"]!.map((x) => Day.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Friday": friday == null
            ? []
            : List<dynamic>.from(friday!.map((x) => x.toJson())),
        "Saturday": saturday == null
            ? []
            : List<dynamic>.from(saturday!.map((x) => x.toJson())),
        "Sunday": sunday == null
            ? []
            : List<dynamic>.from(sunday!.map((x) => x.toJson())),
        "Monday": monday == null
            ? []
            : List<dynamic>.from(monday!.map((x) => x.toJson())),
        "Tuesday": tuesday == null
            ? []
            : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
        "Wednesday": wednesday == null
            ? []
            : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
        "Thursday": thursday == null
            ? []
            : List<dynamic>.from(thursday!.map((x) => x.toJson())),
      };
}

class Day {
  int? id;
  String? day;
  DateTime? date;
  String? start;
  String? end;
  bool? encore;
  bool? split;
  bool? override;
  String? dayId;
  Show? show;

  Day({
    this.id,
    this.day,
    this.date,
    this.start,
    this.end,
    this.encore,
    this.split,
    this.override,
    this.dayId,
    this.show,
  });

  factory Day.fromRawJson(String str) => Day.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        id: json["ID"],
        day: json["day"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        start: json["start"],
        end: json["end"],
        encore: json["encore"],
        split: json["split"],
        override: json["override"],
        dayId: json["id"],
        show: json["show"] == null ? null : Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "day": day,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start": start,
        "end": end,
        "encore": encore,
        "split": split,
        "override": override,
        "id": dayId,
        "show": show?.toJson(),
      };
}

class Show {
  int? id;
  String? name;
  String? slug;
  String? url;
  String? latest;
  String? website;
  List<dynamic>? hosts;
  List<dynamic>? producers;
  List<dynamic>? genres;
  List<dynamic>? languages;
  String? avatarUrl;
  String? avatarId;
  String? imageUrl;
  String? imageId;
  String? route;
  String? feed;

  Show({
    this.id,
    this.name,
    this.slug,
    this.url,
    this.latest,
    this.website,
    this.hosts,
    this.producers,
    this.genres,
    this.languages,
    this.avatarUrl,
    this.avatarId,
    this.imageUrl,
    this.imageId,
    this.route,
    this.feed,
  });

  factory Show.fromRawJson(String str) => Show.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        url: json["url"],
        latest: json["latest"],
        website: json["website"],
        hosts: json["hosts"] == null
            ? []
            : List<dynamic>.from(json["hosts"]!.map((x) => x)),
        producers: json["producers"] == null
            ? []
            : List<dynamic>.from(json["producers"]!.map((x) => x)),
        genres: json["genres"] == null
            ? []
            : List<dynamic>.from(json["genres"]!.map((x) => x)),
        languages: json["languages"] == null
            ? []
            : List<dynamic>.from(json["languages"]!.map((x) => x)),
        avatarUrl: json["avatar_url"],
        avatarId: json["avatar_id"],
        imageUrl: json["image_url"],
        imageId: json["image_id"],
        route: json["route"],
        feed: json["feed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "url": url,
        "latest": latest,
        "website": website,
        "hosts": hosts == null ? [] : List<dynamic>.from(hosts!.map((x) => x)),
        "producers": producers == null
            ? []
            : List<dynamic>.from(producers!.map((x) => x)),
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "avatar_url": avatarUrl,
        "avatar_id": avatarId,
        "image_url": imageUrl,
        "image_id": imageId,
        "route": route,
        "feed": feed,
      };
}
