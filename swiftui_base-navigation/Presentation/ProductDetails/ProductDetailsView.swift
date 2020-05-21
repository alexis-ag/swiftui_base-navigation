import SwiftUI

struct ProductDetailsView: View {
    let props: ProductDetailsViewProps

    var body: some View {
        self.details(props.model)
            .navigationBarTitle("Product details")
    }

    private func details(_ model: ProductViewModel) -> some View {
        ScrollView {
            Text("Product: \(model.title)")

            Button(action: self.props.onBuy) {
                Text("Buy it!")
            }
        }
    }
}