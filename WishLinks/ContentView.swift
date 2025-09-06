//
//  ContentView.swift
//  WishLinks
//
//  Created by Mark Anjoul on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - User Input
    @State private var pastedLink: String = ""

    // MARK: - Autofilled Data
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var imageURL: String = ""

    // UI state
    @State private var isFetching = false
    @State private var showCopiedToast = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                VStack{
                    Text("Add Item to Wish Link")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                    ScrollView {
                        VStack(spacing: 22) {
                            // Title / Subtitle
                            VStack(alignment: .leading, spacing: 6) {

                                Text("Paste a product link to auto-fill details.")
                                    .font(.callout)
                                    .foregroundStyle(.secondary)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Input Row
                            HStack(spacing: 10) {
                                HStack(spacing: 8) {
                                    Image(systemName: "link")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(.secondary)
                                    
                                    TextField("Paste product link here…", text: $pastedLink)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                        .font(.callout)
                                }
                                .padding(.vertical, 14)
                                .padding(.horizontal, 14)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .strokeBorder(Color.black.opacity(0.06))
                                )
                                
                                Button {
                                    if let s = UIPasteboard.general.string {
                                        pastedLink = s
                                        showHaptics()
                                        withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
                                            showCopiedToast = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                            withAnimation(.easeInOut(duration: 0.25)) {
                                                showCopiedToast = false
                                            }
                                        }
                                    }
                                } label: {
                                    Label("Paste", systemImage: "doc.on.clipboard")
                                        .labelStyle(.iconOnly)
                                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                                        .padding(.vertical, 14)
                                        .padding(.horizontal, 14)
                                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                                }
                                .accessibilityLabel("Paste from clipboard")
                            }
                            
                            // Fetch Button
                            Button(action: fetchTapped) {
                                HStack(spacing: 10) {
                                    if isFetching {
                                        ProgressView()
                                            .tint(.white)
                                    } else {
                                        Image(systemName: "sparkles")
                                    }
                                    Text(isFetching ? "Fetching…" : "Fetch Item Details")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(LinearGradient(colors: [.green, Color.green.opacity(0.85)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing),
                                            in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .foregroundStyle(.white)
                                .shadow(color: Color.green.opacity(0.25), radius: 14, y: 6)
                            }
                            .disabled(isFetching)
                            
                            // Preview Card or Empty State
                            Group {
                                if title.isEmpty {
                                    EmptyStateCard()
                                } else {
                                    PreviewCard(title: title, price: price, imageURL: imageURL)
                                        .transition(.asymmetric(insertion: .scale.combined(with: .opacity),
                                                                removal: .opacity))
                                }
                            }
                            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: title)
                            
                            // Add Button
                            Button {
                                // TODO: Add to wishlist action
                                showHaptics(.light)
                            } label: {
                                Text("Add to Wishlist")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                                            .fill(title.isEmpty ? Color.gray.opacity(0.25) : Color.accentColor)
                                    )
                            }
                            .disabled(title.isEmpty)
                        }
                        .padding(20)
                    }
                    
                    // Small “Copied!” toast
                    if showCopiedToast {
                        Text("Copied!")
                            .font(.subheadline.weight(.semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(.ultraThinMaterial, in: Capsule())
                            .overlay(Capsule().strokeBorder(Color.black.opacity(0.08)))
                            .shadow(radius: 4, y: 2)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .padding(.top, 12)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    // MARK: - Actions
    private func fetchTapped() {
        guard !isFetching else { return }
        showHaptics(.medium)
        isFetching = true

        // Simulate a short network fetch
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            fetchMockItemDetails()
            isFetching = false
        }
    }

    // MARK: - Mock Fetch Logic
    private func fetchMockItemDetails() {
        title = "Apple AirPods Pro (2nd Gen)"
        price = "$249.00"
        imageURL = "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQD83?wid=1200&hei=1200&fmt=jpeg"
    }

    // MARK: - Haptics
    private func showHaptics(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: style).impactOccurred()
        #endif
    }
}

// MARK: - Components

private struct EmptyStateCard: View {
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.ultraThinMaterial)
                VStack(spacing: 14) {
                    Image(systemName: "shippingbox")
                        .font(.system(size: 44, weight: .semibold))
                        .foregroundStyle(.secondary)
                    Text("No item yet")
                        .font(.headline)
                    Text("Paste a product link and tap **Fetch Item Details** to preview it here.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(26)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(Color.black.opacity(0.06))
            )
            .frame(maxWidth: .infinity, minHeight: 200)
        }
    }
}

private struct PreviewCard: View {
    let title: String
    let price: String
    let imageURL: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Preview")
                .font(.headline)

            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(.thinMaterial)

                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .transition(.opacity)
                    case .failure(_):
                        PlaceholderImage()
                    case .empty:
                        PlaceholderImage()
                    @unknown default:
                        PlaceholderImage()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                // Price badge
                Text(price)
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(Color.black.opacity(0.06))
                    )
                    .padding(12)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(Color.black.opacity(0.06))
            )
            .shadow(color: .black.opacity(0.08), radius: 16, y: 8)

            Text(title)
                .font(.title3.weight(.semibold))
                .lineLimit(2)
                .minimumScaleFactor(0.9)
        }
    }

    @ViewBuilder
    private func PlaceholderImage() -> some View {
        RoundedRectangle(cornerRadius: 22, style: .continuous)
            .fill(Color.gray.opacity(0.15))
            .frame(height: 260)
            .overlay(
                ProgressView()
            )
    }
}

#Preview {
    ContentView()
}
