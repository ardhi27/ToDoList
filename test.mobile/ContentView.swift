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
    
    @State var highPriorityMenu = false
    @State var lowPriorityMenu = false
    @State var medPriorityMenu = false
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Text("To-Do List").font(.system(size: 20, weight: .bold)).italic()
                HStack(){
                    GroupBox(label: Text("High Priority").foregroundColor(Color.red)){
                        ScrollView(.vertical,showsIndicators: true){
                            VStack(alignment: .leading, spacing: 5){
                                ForEach(highPriority, id: \.self){
                                    task in
                                    Text(task).foregroundColor(Color.white)
                                }
                            }
                        }
                    }.backgroundStyle(Color.black).onTapGesture {
                        highPriorityMenu = true
                    }
                    .sheet(isPresented: $highPriorityMenu){
                        highPriorityListMenu(highPriority: $highPriority)
                    }
                    GroupBox(label: Text("Medium Priority").foregroundColor(Color.yellow)){
                        ScrollView(.vertical, showsIndicators: true){
                            VStack(alignment: .leading, spacing: 5){
                                ForEach(mediumPriority, id: \.self){
                                    task in
                                    Text(task).foregroundColor(Color.white)
                                }
                            }
                        }
                    }.backgroundStyle(Color.black).onTapGesture {
                        medPriorityMenu = true
                    }
                    .sheet(isPresented: $medPriorityMenu){
                        medPriorityListMenu(medPriority: $mediumPriority)
                    }
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
                    }.backgroundStyle(Color.black).onTapGesture{
                        lowPriorityMenu = true
                    }
                    .sheet(isPresented: $lowPriorityMenu){
                        lowPriorityListMenu(lowPriority: $lowPriority)
                    }
                }
            }.padding(10)
            VStack(alignment: .trailing){
                Button("Add List"){
                    showModal.toggle()
                    
                }
                .sheet(isPresented: $showModal){
                    AddModalView {listName, selectedPriority
                        in addTask(listName: listName, priority: selectedPriority)
                    }
                }
            }
        }
        .onAppear{
            loadData()
        }
    }
    
    //Function to Add Task And Save Task
    private func addTask(listName: String, priority: String){
        switch priority {
        case "High Priority" :
            highPriority.append(listName)
            saveTask(listName: listName, priority: "High Priority")
        case "Medium Priority" :
            mediumPriority.append(listName)
            saveTask(listName: listName, priority: "Medium Priority")
        case "Low Priority" :
            lowPriority.append(listName)
            saveTask(listName: listName, priority: "Low Priority")
        default:
            break
        }
    }
    
    private func saveTask(listName: String, priority: String){
        switch priority{
        case "High Priority" :
            UserDefaults.standard.set(highPriority, forKey:"highPriority")
        case "Medium Priority" :
            UserDefaults.standard.set(mediumPriority, forKey:"mediumPriority")
        case "Low Priority" :
            UserDefaults.standard.set(lowPriority, forKey:"lowPriority")
        default:
            break
        }
        
    }
    
    //Function to Load Data
    private func loadData(){
        highPriority = UserDefaults.standard.stringArray(forKey: "highPriority") ?? []
        mediumPriority = UserDefaults.standard.stringArray(forKey: "mediumPriority") ?? []
        lowPriority = UserDefaults.standard.stringArray(forKey: "lowPriority") ?? []
    }

}

struct highPriorityListMenu: View {
    @Environment(\.dismiss) var dismiss
    @Binding var highPriority: [String]
    var body: some View{
        VStack(){
            List{
                ForEach(highPriority, id: \.self){
                    task in
                    Text(task)
                    Button(action:{
                        deleteTask(task: task, from: &highPriority, priority: "High Priority")
                    }){
                        Text("Delete Task").foregroundColor(Color.red)
                    }
                    Button(action:{
                        updateTask()
                    }){
                        Text("Update Task").foregroundColor(Color.green)
                    }
                   
                }
            }
            Spacer()
            Button("Close Menu"){
                dismiss()
                
            }
        }
    }
}

struct medPriorityListMenu: View {
    @Environment(\.dismiss) var dismiss
    @Binding var medPriority: [String]
    var body: some View{
        VStack(){
            List{
                ForEach(medPriority, id:\.self){
                    task in
                    Text(task)
                    Button(action:{
                        deleteTask(task: task, from: &medPriority, priority: "Medium Priority")
                    }){
                        Text("Delete Task").foregroundColor(Color.red)
                    }
                    Button(action:{
                        updateTask()
                    }){
                        Text("Update Task").foregroundColor(Color.green)
                    }
                }
            }
            Spacer()
            Button("Close Menu"){
                dismiss()
            }
        }
    }
}

struct lowPriorityListMenu : View {
    @Environment(\.dismiss) var dismiss
    @Binding var lowPriority : [String]
    var body: some View{
        VStack(){
            List{
                ForEach(lowPriority, id:\.self){
                    task in
                    Text(task)
                    Button(action:{
                        deleteTask(task: task, from: &lowPriority, priority: "Low Priority")
                    }){
                        Text("Delete Task").foregroundColor(Color.red)
                    }
                    Button(action:{
                        updateTask()
                    }){
                        Text("Update Task").foregroundColor(Color.green)
                    }
                }
            }
            Spacer()
            Button("Close Menu"){
                dismiss()
            }
        }
    }
}


struct AddModalView: View{
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



//Function To Delete Task
func deleteTask(task: String, from list: inout [String], priority: String){
    if let index = list.firstIndex(of: task){
        list.remove(at: index)
        
        switch priority{
        case "High Priority":
            UserDefaults.standard.set(list, forKey: "highPriority")
        case "Medium Priority":
            UserDefaults.standard.set(list, forKey: "mediumPriority")
        case "Low Priority":
            UserDefaults.standard.set(list, forKey: "lowPriority")
        default:
            break
        }
    }
}


//Function to Update Task
func updateTask(){
    print("Calling Function to Update Task")
}

