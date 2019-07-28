//  This file was automatically generated and should not be edited.

import Apollo

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

public final class GetMyInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetMyInfo {\n  getMyInfo\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getMyInfo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMyInfo: [String]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMyInfo": getMyInfo])
    }

    /// Returns user info by access token
    public var getMyInfo: [String] {
      get {
        return resultMap["getMyInfo"]! as! [String]
      }
      set {
        resultMap.updateValue(newValue, forKey: "getMyInfo")
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

    /// Returns name and check in time by duke unique id
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

public final class GetEventQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetEvent($eventid: ID!) {\n  getEvent(eventid: $eventid) {\n    __typename\n    status\n    checkintype\n  }\n}"

  public var eventid: GraphQLID

  public init(eventid: GraphQLID) {
    self.eventid = eventid
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getEvent", arguments: ["eventid": GraphQLVariable("eventid")], type: .nonNull(.object(GetEvent.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getEvent: GetEvent) {
      self.init(unsafeResultMap: ["__typename": "Query", "getEvent": getEvent.resultMap])
    }

    /// Returns event info by id
    public var getEvent: GetEvent {
      get {
        return GetEvent(unsafeResultMap: resultMap["getEvent"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getEvent")
      }
    }

    public struct GetEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(String.self))),
        GraphQLField("checkintype", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: String, checkintype: String) {
        self.init(unsafeResultMap: ["__typename": "Event", "status": status, "checkintype": checkintype])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: String {
        get {
          return resultMap["status"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var checkintype: String {
        get {
          return resultMap["checkintype"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "checkintype")
        }
      }
    }
  }
}

public final class OpenEventMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation OpenEvent($eventid: String!, $checkintype: String!) {\n  openEvent(eventid: $eventid, checkintype: $checkintype) {\n    __typename\n    status\n    checkintype\n  }\n}"

  public var eventid: String
  public var checkintype: String

  public init(eventid: String, checkintype: String) {
    self.eventid = eventid
    self.checkintype = checkintype
  }

  public var variables: GraphQLMap? {
    return ["eventid": eventid, "checkintype": checkintype]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("openEvent", arguments: ["eventid": GraphQLVariable("eventid"), "checkintype": GraphQLVariable("checkintype")], type: .object(OpenEvent.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(openEvent: OpenEvent? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "openEvent": openEvent.flatMap { (value: OpenEvent) -> ResultMap in value.resultMap }])
    }

    /// open event for check in with type
    public var openEvent: OpenEvent? {
      get {
        return (resultMap["openEvent"] as? ResultMap).flatMap { OpenEvent(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "openEvent")
      }
    }

    public struct OpenEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(String.self))),
        GraphQLField("checkintype", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: String, checkintype: String) {
        self.init(unsafeResultMap: ["__typename": "Event", "status": status, "checkintype": checkintype])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: String {
        get {
          return resultMap["status"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var checkintype: String {
        get {
          return resultMap["checkintype"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "checkintype")
        }
      }
    }
  }
}

public final class CloseEventMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CloseEvent($eventid: String!) {\n  closeEvent(eventid: $eventid) {\n    __typename\n    status\n  }\n}"

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
      GraphQLField("closeEvent", arguments: ["eventid": GraphQLVariable("eventid")], type: .object(CloseEvent.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(closeEvent: CloseEvent? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "closeEvent": closeEvent.flatMap { (value: CloseEvent) -> ResultMap in value.resultMap }])
    }

    /// close event to check in
    public var closeEvent: CloseEvent? {
      get {
        return (resultMap["closeEvent"] as? ResultMap).flatMap { CloseEvent(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "closeEvent")
      }
    }

    public struct CloseEvent: GraphQLSelectionSet {
      public static let possibleTypes = ["Event"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(status: String) {
        self.init(unsafeResultMap: ["__typename": "Event", "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var status: String {
        get {
          return resultMap["status"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
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