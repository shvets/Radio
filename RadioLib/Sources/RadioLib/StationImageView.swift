import SwiftUI

struct StationImageView: View {
  @Binding var isPlaying: Bool

  var imageName: String?

  var body: some View {
    if let imageName = imageName, let url = URL(string: imageName) {
      AsyncImage(url: url, content: { image in
        radioStationImage(image)
          .frame(width: 50)
      },
      placeholder: {
        ProgressView()
      })
    }
    else {
      radioStationImage(Image(systemName: "radio"))
        .frame(width: 30)
    }
  }

  private func radioStationImage(_ image: Image) -> some View {
    image.resizable()
      .aspectRatio(contentMode: .fit)
      .overlay {
        if isPlaying {
          Image(systemName: "pause")
        }
        else {
          Image(systemName: "play.fill")
        }
      }
  }
}
