import SwiftUI

struct PriceTag: View {
    let raw: String

    private var display: String {
        raw.replacingOccurrences(of: "宝", with: "元")
    }

    private var bgColor: Color {
        switch display {
        case "0元": return .green
        case "中":  return .red
        default:    return .yellow
        }
    }

    private var fgColor: Color {
        display == "中" || display == "0元" ? .white : .black
    }

    var body: some View {
        Text(display)
            .font(.system(size: 12, weight: .medium))
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(bgColor)
            .foregroundStyle(fgColor)
            .cornerRadius(5)
    }
}
