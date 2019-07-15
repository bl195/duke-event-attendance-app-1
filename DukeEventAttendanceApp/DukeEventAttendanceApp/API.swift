//  This file was automatically generated and should not be edited.

import Apollo

public final class GetCardQueryQuery: GraphQLQuery {
  public let operationDefinition =
    "query getCardQuery {\n  getDukeCardNumber\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getDukeCardNumber", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getDukeCardNumber: String) {
      self.init(unsafeResultMap: ["__typename": "Query", "getDukeCardNumber": getDukeCardNumber])
    }

    /// Returns duke card number by duke unique id
    public var getDukeCardNumber: String {
      get {
        return resultMap["getDukeCardNumber"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "getDukeCardNumber")
      }
    }
  }
}

public final class GetMyNameQuery: GraphQLQuery {
  public let operationDefinition =
    "query getMyName {\n  getMyname\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getMyname", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMyname: String) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMyname": getMyname])
    }

    /// Returns name by user's duke unique id from headers
    public var getMyname: String {
      get {
        return resultMap["getMyname"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "getMyname")
      }
    }
  }
}

public final class HostsEventsQuery: GraphQLQuery {
  public let operationDefinition =
    "query HostsEvents {\n  hostEvents {\n    __typename\n    eventid\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("hostEvents", type: .nonNull(.list(.nonNull(.object(HostEvent.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(hostEvents: [HostEvent]) {
      self.init(unsafeResultMap: ["__typename": "Query", "hostEvents": hostEvents.map { (value: HostEvent) -> ResultMap in value.resultMap }])
    }

    /// Returns all events for a particular host by host id
    public var hostEvents: [HostEvent] {
      get {
        return (resultMap["hostEvents"] as! [ResultMap]).map { (value: ResultMap) -> HostEvent in HostEvent(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: HostEvent) -> ResultMap in value.resultMap }, forKey: "hostEvents")
      }
    }

    public struct HostEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("eventid", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(eventid: String) {
        self.init(unsafeResultMap: ["__typename": "Event", "eventid": eventid])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var eventid: String {
        get {
          return resultMap["eventid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "eventid")
        }
      }
    }
  }
}

public final class GetInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetInfo($eventid: ID!, $attendeeid: ID!) {\n  getInfo(eventid: $eventid, attendeeid: $attendeeid)\n}"

  public var eventid: GraphQLID
  public var attendeeid: GraphQLID

  public init(eventid: GraphQLID, attendeeid: GraphQLID) {
    self.eventid = eventid
    self.attendeeid = attendeeid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid, "attendeeid": attendeeid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getInfo", arguments: ["eventid": GraphQLVariable("eventid"), "attendeeid": GraphQLVariable("attendeeid")], type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getInfo: [String]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getInfo": getInfo])
    }

    /// Returns name by duke unique id
    public var getInfo: [String] {
      get {
        return resultMap["getInfo"]! as! [String]
      }
      set {
        resultMap.updateValue(newValue, forKey: "getInfo")
      }
    }
  }
}

public final class AllAttendeesQuery: GraphQLQuery {
  public let operationDefinition =
    "query AllAttendees($id: ID!) {\n  allAttendees(id: $id) {\n    __typename\n    duid\n  }\n}"

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allAttendees", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.list(.nonNull(.object(AllAttendee.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allAttendees: [AllAttendee]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allAttendees": allAttendees.map { (value: AllAttendee) -> ResultMap in value.resultMap }])
    }

    /// Returns all attendees for a particular event by event id
    public var allAttendees: [AllAttendee] {
      get {
        return (resultMap["allAttendees"] as! [ResultMap]).map { (value: ResultMap) -> AllAttendee in AllAttendee(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllAttendee) -> ResultMap in value.resultMap }, forKey: "allAttendees")
      }
    }

    public struct AllAttendee: GraphQLSelectionSet {
      public static let possibleTypes = ["Attendee"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("duid", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(duid: String) {
        self.init(unsafeResultMap: ["__typename": "Attendee", "duid": duid])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var duid: String {
        get {
          return resultMap["duid"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "duid")
        }
      }
    }
  }
}

public final class SelfCheckInMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation SelfCheckIn($eventid: String!) {\n  selfCheckIn(eventid: $eventid) {\n    __typename\n    id\n  }\n}"

  public var eventid: String

  public init(eventid: String) {
    self.eventid = eventid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("selfCheckIn", arguments: ["eventid": GraphQLVariable("eventid")], type: .object(SelfCheckIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(selfCheckIn: SelfCheckIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "selfCheckIn": selfCheckIn.flatMap { (value: SelfCheckIn) -> ResultMap in value.resultMap }])
    }

    /// Check in as attendee
    public var selfCheckIn: SelfCheckIn? {
      get {
        return (resultMap["selfCheckIn"] as? ResultMap).flatMap { SelfCheckIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "selfCheckIn")
      }
    }

    public struct SelfCheckIn: GraphQLSelectionSet {
      public static let possibleTypes = ["Host"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Host", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class QrCheckInMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation QRCheckIn($eventid: String!, $duid: String!) {\n  qrCheckIn(eventid: $eventid, duid: $duid) {\n    __typename\n    id\n  }\n}"

  public var eventid: String
  public var duid: String

  public init(eventid: String, duid: String) {
    self.eventid = eventid
    self.duid = duid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid, "duid": duid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("qrCheckIn", arguments: ["eventid": GraphQLVariable("eventid"), "duid": GraphQLVariable("duid")], type: .object(QrCheckIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(qrCheckIn: QrCheckIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "qrCheckIn": qrCheckIn.flatMap { (value: QrCheckIn) -> ResultMap in value.resultMap }])
    }

    /// Check in as attendee
    public var qrCheckIn: QrCheckIn? {
      get {
        return (resultMap["qrCheckIn"] as? ResultMap).flatMap { QrCheckIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "qrCheckIn")
      }
    }

    public struct QrCheckIn: GraphQLSelectionSet {
      public static let possibleTypes = ["Host"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Host", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class CheckInHostMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CheckInHost($eventid: String!, $title: String!, $hostid: String!) {\n  hostCheckIn(eventid: $eventid, title: $title, hostid: $hostid) {\n    __typename\n    id\n  }\n}"

  public var eventid: String
  public var title: String
  public var hostid: String

  public init(eventid: String, title: String, hostid: String) {
    self.eventid = eventid
    self.title = title
    self.hostid = hostid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid, "title": title, "hostid": hostid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("hostCheckIn", arguments: ["eventid": GraphQLVariable("eventid"), "title": GraphQLVariable("title"), "hostid": GraphQLVariable("hostid")], type: .object(HostCheckIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(hostCheckIn: HostCheckIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "hostCheckIn": hostCheckIn.flatMap { (value: HostCheckIn) -> ResultMap in value.resultMap }])
    }

    /// Check in as host
    public var hostCheckIn: HostCheckIn? {
      get {
        return (resultMap["hostCheckIn"] as? ResultMap).flatMap { HostCheckIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "hostCheckIn")
      }
    }

    public struct HostCheckIn: GraphQLSelectionSet {
      public static let possibleTypes = ["Host"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Host", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}