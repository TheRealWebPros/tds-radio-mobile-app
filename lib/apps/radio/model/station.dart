import 'dart:convert';

class Station {
  Broadcast? broadcast;
  StationSchedule? schedule;
  List<Show>? shows;
  String? timezone;
  String? streamUrl;
  String? streamFormat;
  String? fallbackUrl;
  String? fallbackFormat;
  String? stationUrl;
  String? scheduleUrl;
  DateTime? dateTime;
  bool? success;
  Endpoints? endpoints;

  Station({
    this.broadcast,
    this.schedule,
    this.shows,
    this.timezone,
    this.streamUrl,
    this.streamFormat,
    this.fallbackUrl,
    this.fallbackFormat,
    this.stationUrl,
    this.scheduleUrl,
    this.dateTime,
    this.success,
    this.endpoints,
  });

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        broadcast: json["broadcast"] == null
            ? null
            : Broadcast.fromJson(json["broadcast"]),
        schedule: json["schedule"] == null
            ? null
            : StationSchedule.fromJson(json["schedule"]),
        shows: json["shows"] == null
            ? []
            : List<Show>.from(json["shows"]!.map((x) => Show.fromJson(x))),
        timezone: json["timezone"],
        streamUrl: json["stream_url"],
        streamFormat: json["stream_format"],
        fallbackUrl: json["fallback_url"],
        fallbackFormat: json["fallback_format"],
        stationUrl: json["station_url"],
        scheduleUrl: json["schedule_url"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        success: json["success"],
        endpoints: json["endpoints"] == null
            ? null
            : Endpoints.fromJson(json["endpoints"]),
      );

  Map<String, dynamic> toJson() => {
        "broadcast": broadcast?.toJson(),
        "schedule": schedule?.toJson(),
        "shows": shows == null
            ? []
            : List<dynamic>.from(shows!.map((x) => x.toJson())),
        "timezone": timezone,
        "stream_url": streamUrl,
        "stream_format": streamFormat,
        "fallback_url": fallbackUrl,
        "fallback_format": fallbackFormat,
        "station_url": stationUrl,
        "schedule_url": scheduleUrl,
        "date_time": dateTime?.toIso8601String(),
        "success": success,
        "endpoints": endpoints?.toJson(),
      };
}

class Broadcast {
  CurrentShow? currentShow;
  NextShow? nextShow;

  Broadcast({
    this.currentShow,
    this.nextShow,
  });

  factory Broadcast.fromRawJson(String str) =>
      Broadcast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Broadcast.fromJson(Map<String, dynamic> json) => Broadcast(
        currentShow: json["current_show"] == false
            ? null
            : CurrentShow.fromJson(json["current_show"]),
        nextShow: json["next_show"] == false
            ? null
            : NextShow.fromJson(json["next_show"]),
      );

  Map<String, dynamic> toJson() => {
        "current_show": currentShow?.toJson(),
        "next_show": nextShow?.toJson(),
      };
}

class NextShow {
  int? id;
  String? day;
  DateTime? date;
  String? start;
  String? end;

  bool? override;
  String? nextShowId;
  Show? show;

  NextShow({
    this.id,
    this.day,
    this.date,
    this.start,
    this.end,
    this.override,
    this.nextShowId,
    this.show,
  });

  factory NextShow.fromRawJson(String str) =>
      NextShow.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NextShow.fromJson(Map<String, dynamic> json) => NextShow(
        id: json["ID"],
        day: json["day"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        start: json["start"],
        end: json["end"],
        override: json["override"],
        nextShowId: json["id"],
        show: json["show"] == null ? null : Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "day": day,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start": start,
        "end": end,
        "override": override,
        "id": nextShowId,
        "show": show?.toJson(),
      };
}

class CurrentShow {
  int? id;
  String? day;
  DateTime? date;
  String? start;
  String? end;

  bool? override;
  String? currentShowId;
  Show? show;

  CurrentShow({
    this.id,
    this.day,
    this.date,
    this.start,
    this.end,
    this.override,
    this.currentShowId,
    this.show,
  });

  factory CurrentShow.fromRawJson(String str) =>
      CurrentShow.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentShow.fromJson(Map<String, dynamic> json) => CurrentShow(
        id: json["ID"],
        day: json["day"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        start: json["start"],
        end: json["end"],
        override: json["override"],
        currentShowId: json["id"],
        show: json["show"] == null ? null : Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "day": day,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "start": start,
        "end": end,
        "override": override,
        "id": currentShowId,
        "show": show?.toJson(),
      };
}

class StationSchedule {
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;
  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;

  late Map<String, List<Day>> dayScheduleMap;

  List<Day> getScheduleByDay(String day) {
    return dayScheduleMap[day] ?? [];
  }

  StationSchedule({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  }) {
    dayScheduleMap = {
      'Monday': monday!,
      'Tuesday': tuesday!,
      'Wednesday': wednesday!,
      'Thursday': thursday!,
      'Friday': friday!,
      'Saturday': saturday!,
      'Sunday': sunday!,
    };
  }

  factory StationSchedule.fromRawJson(String str) =>
      StationSchedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationSchedule.fromJson(Map<String, dynamic> json) =>
      StationSchedule(
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

  bool? override;
  String? dayId;
  Show? show;

  Day({
    this.id,
    this.day,
    this.date,
    this.start,
    this.end,
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

class Endpoints {
  String? station;
  String? broadcast;
  String? schedule;
  String? shows;
  String? genres;

  Endpoints({
    this.station,
    this.broadcast,
    this.schedule,
    this.shows,
    this.genres,
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
      );

  Map<String, dynamic> toJson() => {
        "station": station,
        "broadcast": broadcast,
        "schedule": schedule,
        "shows": shows,
        "genres": genres,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
