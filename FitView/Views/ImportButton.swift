//
//  ImportButton.swift
//  GPXViewer
//
//  Created by Saad Beidouri on 29/12/2024.
//
import SwiftUI

struct ImportButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "figure.run")
                Text("Import GPX File")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
