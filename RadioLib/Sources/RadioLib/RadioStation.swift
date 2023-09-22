import Foundation

public struct RadioStation: Codable, Hashable, Identifiable {
  public var id: String {
    name
  }

  public let name: String
  public let imageName: String?
  public let url: String

  public var isPlaying: Bool = false

  private enum CodingKeys: String, CodingKey {
    case name
    case imageName
    case url
  }
}
