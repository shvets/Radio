import SwiftUI
import swiper
import site_builder
import media_player
import common_ui
import navigation

public struct RadioStationsView: View {
    var swiper: Swiper<String, RadioStation> {
        let swiper = Swiper<String, RadioStation>(items: model.radioStations)
        
        swiper.currentItem = model.currentRadioStation
        
        return swiper
    }
    
    var context: AppContext
    @ObservedObject var model: RadioStationsModel
    
    public init(context: AppContext, model: RadioStationsModel) {
        self.context = context
        self.model = model
    }
    
    public var body: some View {
        List {
            ForEach($model.radioStations, id: \.name) { $station in
                RadioStationView(player: context.player, model: model, station: $station, swiper: swiper)
            }
        }
        .navigationTitle("Radio Stations")
        .modifier(ListStyleModifier())
        .task {
            if !model.isLoaded() {
                model.loadRadioStations()
            }
        }
        .navigationDestination(for: NavigationInfo.self) { navigationInfo in
            LazyView(navigationInfo.item.destination()
              .onAppear {
                if let onSelection = navigationInfo.onSelection {
                  onSelection(navigationInfo.item)
                }
              })
          }
    }
    
    //            VStack {
    //                Image(systemName: "globe")
    //                    .imageScale(.large)
    //                    .foregroundColor(.accentColor)
    //                Text("Hello, world!")
    //            }
    //            .padding()
}

struct RadioSiteView_Previews: PreviewProvider {
  static var previews: some View {
    RadioStationsView(context: AppContext(), model: RadioStationsModel())
  }
}
