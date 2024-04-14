//
//  CircularProfileImage.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 05/03/24.
//

import SwiftUI
import Kingfisher

struct AMCircularProfileImage: View {
    let user: User?
    var size: ProfileImageSize = .xLarge
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(Color.gray.opacity(0.5))
        }
    }
}

#Preview {
    AMCircularProfileImage(user: nil)
}
