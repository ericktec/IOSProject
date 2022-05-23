//
//  ImageByURL.swift
//  IOSProject
//
//  Created by Erick Mendoza on 23/05/22.
//

import SwiftUI

struct ImageByURL: View {
    let imageURL: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: width, height: height)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
            }
        }
    }
}

struct ImageByURL_Previews: PreviewProvider {
    static var previews: some View {
        ImageByURL(imageURL: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gettyimages-838386570-1544458219.png", width: 30, height: 30)
    }
}
