import SwiftUI
import media_player
import swiper
import video_player
import site_builder

struct RadioStationPlayerView: View {
  var swipeChanged: ((SwipeModifier.Directions) -> Void)? {
#if os(iOS)
    return { direction in
      swiper?.handleSwipe(direction) { item in
        model.reload(station: item, player: player)
      }
    }
#elseif os(iOS)
    return nil
#else
    return nil
#endif
  }

#if os(iOS)
  var enableSwipe = true
#elseif os(tvOS)
  var enableSwipe = false
#endif

  @ObservedObject var player: MediaPlayer
  @ObservedObject var model: RadioStationsModel
  @Binding var station: RadioStation
  var swiper: Swiper<String, RadioStation>?

  init(player: MediaPlayer, model: RadioStationsModel, station: Binding<RadioStation>,
       swiper: Swiper<String, RadioStation>? = nil) {
    self.player = player
    self.model = model
    self._station = station
    self.swiper = swiper
  }

  var body: some View {
    if let url = URL(string: station.url) {
      PlainVideoPlayerView(player: player, name: name(), mediaSource: MediaSource(url: url), stopOnLeave: false,
          playImmediately: false, enableSwipe: enableSwipe, swipeChanged: swipeChanged)
        .onAppear {
          if station.name != model.currentRadioStation?.name || !player.isPlaying {
            model.reload(station: station, player: player)
          }
        }
    }
    else {
      EmptyView()
    }
  }

  func name() -> Binding<String> {
    Binding.constant(model.currentRadioStation?.name ?? "unknown")
  }
}
