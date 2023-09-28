import SwiftUI

private enum Constants {
    static let itemsSpacing: CGFloat = 20
    static let trailingSpacing: CGFloat = 140
}

struct ViewPager<Content: View, T: Identifiable>: View {
    
    // MARK: - Public fields
    
    @Binding var index: Int
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    // MARK: - Private fields
    
    private let content: (T) -> Content
    private let list: [T]
    private let onScrollEnded: (() -> Void)?
    
    // MARK: - Initialisation
    
    init(
        index: Binding<Int>,
        items: [T],
        onScrollEnded:(() -> Void)? = nil,
        @ViewBuilder content: @escaping (T)->Content
    ){
        self.list = items
        self._index = index
        self.onScrollEnded = onScrollEnded
        self.content = content
    }
    
    // MARK: - Layout
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth = geometry.size.width - (Constants.trailingSpacing - Constants.itemsSpacing)
            let additionalWidth = (Constants.trailingSpacing / 2) - Constants.itemsSpacing
            
            HStack(spacing: Constants.itemsSpacing) {
                ForEach(Array(list.enumerated()), id: \.offset) { index, item in
                    content(item)
                        .frame(width: geometry.size.width - Constants.trailingSpacing)
                        .padding(.leading, currentIndex == 0 && index == 0 ? 50 : 0)
                }
            }
            .padding(.horizontal, Constants.itemsSpacing)
            .offset(x: (CGFloat(currentIndex) * -itemWidth) + (currentIndex != 0 ? additionalWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating(
                        $offset,
                        body: { value, out, _ in out = value.translation.width }
                    )
                    .onEnded { value in
                        let progress = -value.translation.width / itemWidth
                        currentIndex = max(min(currentIndex + Int(progress.rounded()), list.count - 1), 0)
                        currentIndex = index
                        
                        onScrollEnded?()
                    }
                    .onChanged { value in
                        let progress = -value.translation.width / itemWidth
                        index = max(min(currentIndex + Int(progress.rounded()), list.count - 1), 0)
                    }
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}
