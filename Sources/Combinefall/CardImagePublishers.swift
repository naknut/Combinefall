import Combine
import Foundation

public enum ImageVersion: String {
    case small, normal, large, png, artCrop = "art_crop", borderCrop = "border_crop"
}

public struct CardImageParameters {
    public let name: String
    public let version: ImageVersion

    public init(name: String, version: ImageVersion) {
        self.name = name
        self.version = version
    }
}

// swiftlint:disable:next identifier_name
func _cardImageDataPublisher<U: Publisher, R: Publisher>(upstream: U, dataTaskPublisher: @escaping (URLRequest) -> R)
    -> AnyPublisher<Data, Error>
    where
    U.Output == CardImageParameters,
    U.Failure == Never,
    R.Output == URLSession.DataTaskPublisher.Output,
    R.Failure == URLSession.DataTaskPublisher.Failure {
        dataPublisher(
            upstream: upstream.map { EndpointComponents.cardImage(named: $0.name, version: $0.version).urlRequest },
            dataTaskPublisher: dataTaskPublisher
        )
            .eraseToAnyPublisher()
}

/// Creates a publisher connected to upstream that queries the `card/named` endpoint of Scryfall.
///
/// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
/// For example: `"fIReBALL"` is the same as `"Fireball"` and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
///
/// - Parameter upstream: _Required_ A publisher which `Output` must be `(String, ImageVersion)`
/// The `String` should be set to the exact name of the card and `ImageVersion` desides what image will be returned.
/// - Returns: A publisher that publishes `Data` mathing the given `upstream` published element.
public func cardImageDataPublisher<U: Publisher>(upstream: U) -> AnyPublisher<Data, Error>
    where U.Output == CardImageParameters, U.Failure == Never {
        _cardImageDataPublisher(upstream: upstream, dataTaskPublisher: URLSession.shared.dataTaskPublisher)
}

public extension Publisher where Self.Output == CardImageParameters, Self.Failure == Never {
    /// Creates a publisher connected to upstream that queries the `card/named` endpoint of Scryfall.
    ///
    /// Names are case-insensitive and punctuation is optional (you can drop apostrophes and periods etc).
    /// For example: `"fIReBALL"` is the same as `"Fireball"`
    /// and `"smugglers copter"` is the same as `"Smuggler's Copter"`.
    ///
    /// - Parameter upstream: _Required_ A publisher which `Output` must be `(String, ImageVersion)`
    /// The `String` should be set to the exact name of the card and `ImageVersion` desides what image will be returned.
    /// - Returns: A publisher that publishes `Data` mathing the given `upstream` published element.
    func cardImageData() -> AnyPublisher<Data, Error> {
        cardImageDataPublisher(upstream: self)
    }
}
