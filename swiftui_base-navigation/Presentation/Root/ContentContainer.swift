import SwiftUI

enum NavigationItem: Int {
    case products = 0
    case orders = 1
}

struct ContentContainer: View {
    @State var products = [
        Product(id: 1, name: "Banana", type: .food, price: 0.5, currency: .usd),
        Product(id: 2, name: "TV", type: .nonFood, price: 100.5, currency: .usd),
        Product(id: 3, name: "Camera", type: .nonFood, price: 50.5, currency: .usd)
    ]
    @State var orders: [Order] = []
    @State var selectedTap = NavigationItem.products

    var body: some View {
        TabView(selection: $selectedTap) {
            NavigationView {
                self.productsContent(self.products)
            }
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Products")
                    }.tag(NavigationItem.products)

            NavigationView {
                self.ordersContent(self.orders)
            }
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Orders")
                    }.tag(NavigationItem.orders)
        }
    }

    private func productsContent(_ products: [Product]) -> some View {
        ProductsView(
                props: ProductsViewProps(
                        models: self.products.map { ProductViewModel(id: $0.id, title: $0.name) },
                        onBuy: self.onBuyProduct
                )
        )
    }

    private func ordersContent(_ products: [Order]) -> some View {
        OrdersView(
                props: OrdersViewProps(
                        models: self.orders.map { OrderViewModel(id: $0.id, title: $0.name, date: $0.date) }
                )
        )
    }

    private func onBuyProduct(_ id: Int) {
        let newOrder =
                self.products
                    .filter { $0.id == id }
                    .map {
                        Order(
                                id: UUID().uuidString,
                                name: $0.name,
                                date: Date()
                        )
                    }
                    .first

        guard let order = newOrder else {
            //handle error
            return
        }
        self.orders.append(order)
        self.selectedTap = .orders
    }
}