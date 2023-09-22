import SwiftUI
import swiper
import media_player
import site_builder
import common_defs
import navigation

struct RadioStationView: View {
  var destination: () -> AnyView {
    {
      AnyView(RadioStationPlayerView(player: player, model: model, station: $station, swiper: swiper))
    }
  }

  var navigationInfo: NavigationInfo {
    NavigationInfo(item: NameAndDestination(mediaItem: MediaItem(name: "details"), destination: destination))
  }

  var player: MediaPlayer
  @ObservedObject var model: RadioStationsModel
  @Binding var station: RadioStation
  var swiper: Swiper<String, RadioStation>? = nil

  var body: some View {
    NavigationLink(value: navigationInfo) {
      radioStation()
    }
      .buttonStyle(BorderedButtonStyle())
  }

  @ViewBuilder
  func radioStation() -> some View {
    HStack {
      StationImageView(isPlaying: $station.isPlaying, imageName: station.imageName)
        .gesture(TapGesture().onEnded {
          if $station.wrappedValue.isPlaying {
            model.reset(player: player)
          }
          else {
            model.reload(station: station, player: player)
          }
        })

      Spacer()

      Text(station.name)
    }
  }
}

struct RadioStationView_Previews: PreviewProvider {
  static private var model = RadioStationsModel()
  static private var station = model.radioStations.first!

  static var previews: some View {
    RadioStationView(player: MediaPlayer(), model: RadioStationsModel(), station: Binding.constant(station))
  }
}
