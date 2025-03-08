import SwiftUI

struct TextLengthLimiter: ViewModifier {
    @Binding var text: String
    let maxLength: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(text.publisher.collect()) { output in
                text = String(output.prefix(maxLength))
            }
    }
}

public extension View {
    func maxLength(
        _ text: Binding<String>,
        length: Int
    ) -> some View {
        self.modifier(
            TextLengthLimiter(
                text: text,
                maxLength: length
            )
        )
    }
}
