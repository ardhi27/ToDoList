//
//  ContentView.swift
//  test.mobile
//
//  Created by Agung Ardhiyanda on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    var highPriority = ["Wawancara", "Design Science Research"]
    var mediumPriority = ["Desain UI", "Menambahkan Kolom"]
    var lowPriority = ["Buat Content"]
    var body: some View {
        VStack(alignment: .leading){
            Text("To-Do List").font(.system(size: 20, weight: .bold)).italic()
            HStack(){
                GroupBox(label: Text("High Priority").foregroundColor(Color.red)){
                    ScrollView(.vertical, showsIndicators: true){
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(highPriority, id: \.self){
                                task in
                                Text(task).foregroundColor(Color.white)
                            }
                        }
                    }
                }.backgroundStyle(Color.black)
                GroupBox(label: Text("Medium Priority").foregroundColor(Color.yellow)){
                    ScrollView(.vertical, showsIndicators: true){
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(mediumPriority, id: \.self){
                                task in
                                Text(task).foregroundColor(Color.white)
                            }
                        }
                    }
                }.backgroundStyle(Color.black)
            }
            HStack(){
                GroupBox(label: Text("Low Priority").foregroundColor(Color.green)){
                    ScrollView(.vertical, showsIndicators: true){
                        VStack(alignment: .leading, spacing: 10){
                            ForEach(lowPriority, id:\.self){
                                task in
                                Text(task).foregroundColor(Color.white)
                            }
                        }
                    }
                }.backgroundStyle(Color.black)
            }
        }.padding(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
