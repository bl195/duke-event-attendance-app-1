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