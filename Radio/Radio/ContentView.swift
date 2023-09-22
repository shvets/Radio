import SwiftUI
import RadioLib
import site_builder
import common_ui

struct ContentView: View {
    @ObservedObject var context = AppContext()
    @ObservedObject var model = RadioStationsModel()
    
    public var body: some View {
        NavigationStack(path: $context.navigationPath) {
            RadioStationsView(context: context, model: model)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
