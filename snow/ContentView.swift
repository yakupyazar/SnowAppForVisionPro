//
//  ContentView.swift
//  snow
//
//  Created by Yakup Yazar on 26.12.2023.
//

import SwiftUI
import RealityKit
import RealityKitContent
import SwiftUI
import AVKit


struct ContentView: View {
    @State private var showImmersivespace: Bool = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    private let player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
      //https://github.com/ChrisMash/AVPlayer-SwiftUI/blob/master/AVPlayer-SwiftUI/VideoView.swift
      var body: some View {
          Model3D(named: "Scene", bundle: realityKitContentBundle).padding(.top, -300)
          Toggle ("", isOn: $showImmersivespace)
              .toggleStyle(.button)
              .padding(.top, 0)

          VideoPlayer(player: player)
              .onAppear() {
                  // Start the player going, otherwise controls don't appear
                  player.play()
                  
              }
              .onDisappear() {
                  // Stop the player when the view disappears
                  player.pause()
              }
          
          .onChange(of: showImmersivespace){ _, newValue in Task{
              if newValue{
                  await openImmersiveSpace(id: "ImmersiveSpace")
              }
              else {
                  await dismissImmersiveSpace()
                  
              }
          }
              
          }
          
          
          
      }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
/*struct ContentView: View {
    @State private var showYouTubeVideo = false
    @State private var showImmersivespace: Bool = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
//        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 50)
//
//            Text("Hello, world!")
//            Toggle("Show ImmersiveSpace",isOn: $showImmersiveSpace).toggleStyle(.button).padding(.top, 50)
//            
//            
//        }
//        .padding()
        
        NavigationSplitView{
            List{
                Text("Item")
            }.navigationTitle("Sidebar")
        } detail: {
            VStack{
                
                Model3D(named: "Scene", bundle: realityKitContentBundle).padding(.bottom, 50)
                
                Text ("Make it snow")
                Button("Play YouTube Video") {
                               showYouTubeVideo = true
                           }
                .sheet(isPresented: $showYouTubeVideo) {
                    WebView(urlString: "https://www.youtube.com/embed/4nRg8cm5z4Y")
                }

                Toggle ("Show ImmersiveSpace", isOn: $showImmersivespace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
                              
            }
            .navigationTitle("Content")
            .padding()
        }
        .onChange(of: showImmersivespace){ _, newValue in Task{
            if newValue{
                await openImmersiveSpace(id: "ImmersiveSpace")
            }
            else {
                await dismissImmersiveSpace()
                
            }
        }
            
        }
        
        
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
*/
