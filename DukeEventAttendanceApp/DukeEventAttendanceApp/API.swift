//  This file was automatically generated and should not be edited.

import Apollo

public final class GetDataQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetData {\n  hostEvents(id: \"ahw26\") {\n    __typename\n    id\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("hostEvents", arguments: ["id": "ahw26"], type: .nonNull(.list(.nonNull(.object(HostEvent.selections))))),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Event", "id": id])
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

public final class GetAttendeesQuery: GraphQLQuery {
  public let operationDefinition =
    "query getAttendees {\n  allAttendees(id: \"event6\") {\n    __typename\n    id\n    duid\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allAttendees", arguments: ["id": "event6"], type: .nonNull(.list(.nonNull(.object(AllAttendee.selections))))),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("duid", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, duid: String) {
        self.init(unsafeResultMap: ["__typename": "Attendee", "id": id, "duid": duid])
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

public final class HostsEventsQuery: GraphQLQuery {
  public let operationDefinition =
    "query HostsEvents($id: ID!) {\n  hostEvents(id: $id) {\n    __typename\n    eventid\n  }\n}"

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
      GraphQLField("hostEvents", arguments: ["id": GraphQLVariable("id")], type: .nonNull(.list(.nonNull(.object(HostEvent.selections))))),
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

public final class CheckInAttendeeMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CheckInAttendee($eventid: String!, $duid: String!) {\n  attendeeCheckIn(eventid: $eventid, duid: $duid) {\n    __typename\n    id\n  }\n}"

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
      GraphQLField("attendeeCheckIn", arguments: ["eventid": GraphQLVariable("eventid"), "duid": GraphQLVariable("duid")], type: .object(AttendeeCheckIn.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(attendeeCheckIn: AttendeeCheckIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "attendeeCheckIn": attendeeCheckIn.flatMap { (value: AttendeeCheckIn) -> ResultMap in value.resultMap }])
    }

    /// Check in as attendee
    public var attendeeCheckIn: AttendeeCheckIn? {
      get {
        return (resultMap["attendeeCheckIn"] as? ResultMap).flatMap { AttendeeCheckIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "attendeeCheckIn")
      }
    }

    public struct AttendeeCheckIn: GraphQLSelectionSet {
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
    "mutation CheckInHost($eventid: String!, $hostid: String!) {\n  hostCheckIn(eventid: $eventid, hostid: $hostid) {\n    __typename\n    id\n  }\n}"

  public var eventid: String
  public var hostid: String

  public init(eventid: String, hostid: String) {
    self.eventid = eventid
    self.hostid = hostid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid, "hostid": hostid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("hostCheckIn", arguments: ["eventid": GraphQLVariable("eventid"), "hostid": GraphQLVariable("hostid")], type: .object(HostCheckIn.selections)),
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