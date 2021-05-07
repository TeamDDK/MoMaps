import Foundation
#if canImport(CoreLocation)
import CoreLocation
#else
import Turf
#endif

extension RouteLeg {
    /**
     A collection of per-segment attributes along a route leg.
     */
    public struct Attributes: Equatable {
        /**
         An array containing the distance (measured in meters) between each coordinate in the route leg geometry.
         
         This property is set if the `RouteOptions.attributeOptions` property contains `AttributeOptions.distance`.
         */
        public var segmentDistances: [CLLocationDistance]?
        
        /**
         An array containing the expected travel time (measured in seconds) between each coordinate in the route leg geometry.
         
         These values are dynamic, accounting for any conditions that may change along a segment, such as traffic congestion if the profile identifier is set to `.automobileAvoidingTraffic`.
         
         This property is set if the `RouteOptions.attributeOptions` property contains `AttributeOptions.expectedTravelTime`.
         */
        public var expectedSegmentTravelTimes: [TimeInterval]?
        
        /**
         An array containing the expected average speed (measured in meters per second) between each coordinate in the route leg geometry.
         
         These values are dynamic; rather than speed limits, they account for the road’s classification and/or any traffic congestion (if the profile identifier is set to `.automobileAvoidingTraffic`).
         
         This property is set if the `RouteOptions.attributeOptions` property contains `AttributeOptions.speed`.
         */
        public var segmentSpeeds: [LocationSpeed]?
        
        /**
         An array containing the traffic congestion level along each road segment in the route leg geometry.
         
         Traffic data is available in [a number of countries and territories worldwide](https://docs.mapbox.com/help/how-mapbox-works/directions/#traffic-data).
         
         You can color-code a route line according to the congestion level along each segment of the route.
         
         This property is set if the `RouteOptions.attributeOptions` property contains `AttributeOptions.congestionLevel`.
         */
        public var segmentCongestionLevels: [CongestionLevel]?
        
        /**
         An array containing the maximum speed limit along each road segment along the route leg’s shape.
         
         The maximum speed may be an advisory speed limit for segments where legal limits are not posted, such as highway entrance and exit ramps. If the speed limit along a particular segment is unknown, it is represented in the array by a measurement whose value is negative. If the speed is unregulated along the segment, such as on the German _Autobahn_ system, it is represented by a measurement whose value is `Double.infinity`.
         
         Speed limit data is available in [a number of countries and territories worldwide](https://docs.mapbox.com/help/how-mapbox-works/directions/).
         
         This property is set if the `RouteOptions.attributeOptions` property contains `AttributeOptions.maximumSpeedLimit`.
         */
        public var segmentMaximumSpeedLimits: [Measurement<UnitSpeed>?]?
    }
}

extension RouteLeg.Attributes: Codable {
    private enum CodingKeys: String, CodingKey {
        case segmentDistances = "distance"
        case expectedSegmentTravelTimes = "duration"
        case segmentSpeeds = "speed"
        case segmentCongestionLevels = "congestion"
        case segmentMaximumSpeedLimits = "maxspeed"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        segmentDistances = try container.decodeIfPresent([CLLocationDistance].self, forKey: .segmentDistances)
        expectedSegmentTravelTimes = try container.decodeIfPresent([TimeInterval].self, forKey: .expectedSegmentTravelTimes)
        segmentSpeeds = try container.decodeIfPresent([LocationSpeed].self, forKey: .segmentSpeeds)
        segmentCongestionLevels = try container.decodeIfPresent([CongestionLevel].self, forKey: .segmentCongestionLevels)
        
        if let speedLimitDescriptors = try container.decodeIfPresent([SpeedLimitDescriptor].self, forKey: .segmentMaximumSpeedLimits) {
            segmentMaximumSpeedLimits = speedLimitDescriptors.map { Measurement<UnitSpeed>(speedLimitDescriptor: $0) }
        } else {
            segmentMaximumSpeedLimits = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(segmentDistances, forKey: .segmentDistances)
        try container.encodeIfPresent(expectedSegmentTravelTimes, forKey: .expectedSegmentTravelTimes)
        try container.encodeIfPresent(segmentSpeeds, forKey: .segmentSpeeds)
        try container.encodeIfPresent(segmentCongestionLevels, forKey: .segmentCongestionLevels)
        
        if let speedLimitDescriptors = segmentMaximumSpeedLimits?.map({ SpeedLimitDescriptor(speed: $0) }) {
            try container.encode(speedLimitDescriptors, forKey: .segmentMaximumSpeedLimits)
        }
    }
    
    /**
     Returns whether any attributes are non-nil.
     */
    var isEmpty: Bool {
        return segmentDistances == nil &&
            expectedSegmentTravelTimes == nil &&
            segmentSpeeds == nil &&
            segmentCongestionLevels == nil &&
            segmentMaximumSpeedLimits == nil
    }
}
