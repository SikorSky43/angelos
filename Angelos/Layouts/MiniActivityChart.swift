//
//  MiniActivityTile.swift
//  Angelos
//
//  Created by BlackBird on 20/11/25.
//

import Foundation
import SwiftUI


// ------------------------------------------------------
// MARK: - Mini Activity Chart (bars)
// ------------------------------------------------------

struct MiniActivityChart: View {
    let values: [Double]

    // Normalising values for equal scale
    private var normalized: [Double] {
        let maxVal = values.max() ?? 1
        return values.map { max(0.05, $0 / maxVal) }
    }

    private let gradient = LinearGradient(
        colors: [.orange, .yellow, .green, .cyan, .blue, .purple],
        startPoint: .bottom,
        endPoint: .top
    )

    var body: some View {
        GeometryReader { geo in
            let count = CGFloat(values.count)
            let barWidth = (geo.size.width / count) * 0.52
            let spacing = (geo.size.width - (barWidth * count)) / (count - 1)

            ZStack(alignment: .bottomLeading) {

                // Background "ghost bars"
                HStack(alignment: .bottom, spacing: spacing) {
                    ForEach(values.indices, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.white.opacity(0.16))
                            .frame(width: barWidth, height: geo.size.height * 0.9)
                    }
                }

                // Foreground colored bars
                HStack(alignment: .bottom, spacing: spacing) {
                    ForEach(normalized.indices, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(gradient)
                            .frame(
                                width: barWidth,
                                height: normalized[i] * geo.size.height * 0.9
                            )
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

