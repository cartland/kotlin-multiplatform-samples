/*
 * Copyright 2024 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation
import SwiftUI
import shared

struct CartView : View {
    let cartDetails: [CartItemDetails]
    let mainViewModel: MainViewModel
    @State
    private var expanded = false

    var body: some View {
        if (cartDetails.isEmpty) {
            Text("Cart is empty, add some items").padding()
        } else {
            HStack {
                Text("Item types in cart: \(cartDetails.count)").padding()
                Spacer()
                Button {
                    expanded.toggle()
                } label: {
                    if (expanded) {
                        Text("collapse")
                    } else {
                        Text("expand")
                    }
                }.padding()
            }
            if (expanded) {
                CartDetailsView(mainViewModel: mainViewModel)
            }
        }
    }
}

struct CartDetailsView: View {
    let mainViewModel: MainViewModel
    @State
    private var cartUiState: CartUiState = CartUiState(cartDetails: [])

    var body: some View {
        VStack {
            ForEach(cartUiState.cartDetails, id: \.fruittie.id) { item in
                Text("\(item.fruittie.name): \(item.count)")
            }
        }.collectWithLifecycle(mainViewModel.cartUiState, binding: $cartUiState)
    }
}
