func generateRoute(coords: [(Double, Double)]) -> [(Double, Double)] {

    var route = [(Double, Double)]()

    for (i, coord) in coords.enumerate() {
        guard i > 0 else { continue }
        let prevCoord = coords[i-1]
        let m = (prevCoord.1 - coord.1) / (prevCoord.0 - coord.0)
        let b = prevCoord.1 - (m * prevCoord.0)
        var lowLat = coord.0 < prevCoord.0 ? coord.0 : prevCoord.0
        let highLat = coord.0 < prevCoord.0 ? prevCoord.0 : coord.0

        while lowLat <= highLat {
            let lng = m * lowLat + b
            route.append((lowLat, lng))
            lowLat = lowLat + 0.0004
        }

    }


    return route
}

let commute = [
(40.74255874, -73.93117011),
(40.74437142, -73.93078387),
(40.74656607, -73.94371212),
(40.74475345, -73.94855618),
(40.73031579, -73.95430684),
(40.72483581, -73.9513886),
(40.71397209, -73.95196795),
(40.69575349, -73.94937158),
(40.68942461, -73.95366311),
(40.68717926, -73.97447705),
(40.68898531, -73.98559213),
(40.68631689, -73.99076343),
(40.67477966, -73.99732947),
(40.67017397, -73.99007678),
(40.66644687, -73.98061395),
(40.6615639, -73.98608565)
]

let toPark = [
(40.6615639, -73.98608565),
(40.65894322, -73.98177266),
(40.66099419, -73.97984147),
(40.66218243, -73.97443414),
(40.66532382, -73.97160172),
(40.66937649, -73.96988511),
(40.67201303, -73.9692843),
(40.67160616, -73.96582961)
]

let toSoho = [
(40.6615639, -73.98608565),
(40.66564934, -73.99284482),
(40.6702879, -73.989079),
(40.67702543, -73.98345709),
(40.68409585, -73.97863448),
(40.68965239, -73.98149371),
(40.69406151, -73.99029136),
(40.70388741, -74.0134871),
(40.71350042, -74.00694251),
(40.72397394, -73.99795175)
]

let bronxZoo = [
(40.85355277, -73.88046026),
(40.85147527, -73.88097525),
(40.84874844, -73.88106108),
(40.84660586, -73.87827158),
(40.84959247, -73.87681246),
(40.85335801, -73.87569666),
(40.85744791, -73.87462378),
(40.86212178, -73.87548208),
(40.86556206, -73.87779951)
]

let christmas = [
(40.76819172, -73.97030354),
(40.76424258, -73.97303939),
(40.75785519, -73.97764742)
]

print(generateRoute(commute))
print("")
print(generateRoute(toPark))
print("")
print(generateRoute(toSoho))
print("")
print(generateRoute(bronxZoo))
print("")
print(christmas)
