//
//  ContentView.swift
//  test.mobile
//
//  Created by Agung Ardhiyanda on 12/09/24.
//

import SwiftUI

struct ContentView: View {
    @State var highPriority: [String] = []
    @State var mediumPriority: [String] = []
    @State var lowPriority: [String] = []
    @State private var showModal = false
    
    var body: some View {
        VStack{
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
            VStack(alignment: .trailing){
                Button("Add List"){
                    showModal.toggle()
            
                }
                .sheet(isPresented: $showModal){
                    ModalView{listName, selectedPriority in
                        addTask(listName: listName, priority: selectedPriority)
                    }
                }
            }
        }
    }
    
    private func addTask(listName: String, priority: String){
        switch priority {
        case "High Priority" :
            highPriority.append(listName)
        case "Medium Priority" :
            mediumPriority.append(listName)
        case "Low Priority" :
            lowPriority.append(listName)
        default:
            break
        }
    }
}

struct ModalView: View{
    @Environment(\.dismiss) var dismiss
    @State private var listName: String = ""
    @State private var selectedPriority: String = "High Priority"
    @State private var listPriority: Array = ["High Priority", "Low Priority", "Medium Priority"]
    
    var onAddTask: (String, String) -> Void
    
    var body: some View{
        VStack(){
            Text("Test Modal")
            TextField("Input Your List Today",
                      text: $listName).padding(4).overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                Picker("Priority Task", selection: $selectedPriority){
                    ForEach(listPriority, id:\.self){
                        priority in
                        Text(priority).tag(priority)
                    }
                }
            
            Spacer()
            
            Button("Add Modal"){
                onAddTask(listName, selectedPriority)
                dismiss()
            }
        }.padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
