import DiskStorage
import SwiftUI
import Foundation
import media_player

enum LoadError: Error {
  case cannotFindFile(filename: String)
  case cannotLoadFile(filename: String, error: Error)
  case cannotParse(filename: String, error: Error)
}

public class RadioStationsModel: ObservableObject {
  private var loaded: Bool = false

  @Published var radioStations: [RadioStation] = []
  @Published var currentRadioStation: RadioStation? = nil

  public init() {}


  func isLoaded() -> Bool {
    loaded
  }

  func loadRadioStations() {
    do {
      radioStations = try load("radio-stations.json")
    }
    catch let e {
      switch e {
      case LoadError.cannotFindFile(let filename):
        print("Couldn't find \(filename) in main bundle.")
      case LoadError.cannotLoadFile(let filename, let error):
        print("Couldn't load \(filename) from main bundle:\n\(error)")
      case LoadError.cannotParse(let filename, let error):
        print("Couldn't parse \(filename) as `RadioStation`:\n\(error)")
      default:
        print("Error: \(e.localizedDescription)")
      }
    }

    if radioStations.count > 0 {
      currentRadioStation = radioStations.first
    }

    resetPlaying()

    loaded = true
  }

  func load<T: Decodable>(_ filename: String, bundle: Bundle = Bundle.main) throws -> T {
    let data: Data

    guard let file = bundle.url(forResource: filename, withExtension: nil)

    else {
      throw LoadError.cannotFindFile(filename: filename)
    }

    do {
      data = try Data(contentsOf: file)
    }
    catch {
      throw LoadError.cannotLoadFile(filename: filename, error: error)
    }

    do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
    }
    catch {
      throw LoadError.cannotParse(filename: filename, error: error)
    }
  }

  func reload(station: RadioStation, player: MediaPlayer) {
    if let url = URL(string: station.url) {
      player.reload(mediaSource: MediaSource(url: url))

      setPlaying(name: station.name)
      currentRadioStation = station

      print("next item: \(station.name)")
    }
  }

  func reset(player: MediaPlayer) {
    player.stop()

    resetPlaying()
  }

  private func resetPlaying() {
    for index in 0..<radioStations.count {
      radioStations[index].isPlaying = false
    }
  }

  private func setPlaying(name: String) {
    for index in 0..<radioStations.count {
      if radioStations[index].name != name {
        radioStations[index].isPlaying = false
      }
      else {
        radioStations[index].isPlaying.toggle()
      }
    }
  }
}
