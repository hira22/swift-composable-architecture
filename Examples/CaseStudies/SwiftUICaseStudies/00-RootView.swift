import Combine
import ComposableArchitecture
import SwiftUI

struct RootView: View {
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Getting started")) {
          NavigationLink(
            "Basics",
            destination: CounterDemoView(
              store: Store(
                initialState: CounterState(),
                reducer: counterReducer,
                environment: CounterEnvironment()
              )
            )
          )

          NavigationLink(
            "Pullback and combine",
            destination: TwoCountersView(
              store: Store(
                initialState: TwoCountersState(),
                reducer: twoCountersReducer,
                environment: TwoCountersEnvironment()
              )
            )
          )

          NavigationLink(
            "Bindings",
            destination: BindingBasicsView(
              store: Store(
                initialState: BindingBasicsState(),
                reducer: bindingBasicsReducer,
                environment: BindingBasicsEnvironment()
              )
            )
          )

          NavigationLink(
            "Optional state",
            destination: OptionalBasicsView(
              store: Store(
                initialState: OptionalBasicsState(),
                reducer: optionalBasicsReducer,
                environment: OptionalBasicsEnvironment()
              )
            )
          )

          NavigationLink(
            "Shared state",
            destination: SharedStateView(
              store: Store(
                initialState: SharedState(),
                reducer: sharedStateReducer,
                environment: ()
              )
            )
          )

          NavigationLink(
            "Animations",
            destination: AnimationsView(
              store: Store(
                initialState: AnimationsState(circleCenter: CGPoint(x: 50, y: 50)),
                reducer: animationsReducer,
                environment: AnimationsEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )
        }

        Section(header: Text("Effects")) {
          NavigationLink(
            "Basics",
            destination: EffectsBasicsView(
              store: Store(
                initialState: EffectsBasicsState(),
                reducer: effectsBasicsReducer,
                environment: .live
              )
            )
          )

          NavigationLink(
            "Cancellation",
            destination: EffectsCancellationView(
              store: Store(
                initialState: .init(),
                reducer: effectsCancellationReducer,
                environment: .live)
            )
          )

          NavigationLink(
            "Long-living effects",
            destination: LongLivingEffectsView(
              store: Store(
                initialState: LongLivingEffectsState(),
                reducer: longLivingEffectsReducer,
                environment: .live
              )
            )
          )

          NavigationLink(
            "Timers",
            destination: TimersView(
              store: Store(
                initialState: TimersState(),
                reducer: timersReducer,
                environment: TimersEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "System environment",
            destination: MultipleDependenciesView(
              store: Store(
                initialState: MultipleDependenciesState(),
                reducer: multipleDependenciesReducer,
                environment: .live(
                  environment: MultipleDependenciesEnvironment(
                    fetchNumber: {
                      Effect(value: Int.random(in: 1...1_000))
                        .delay(for: 1, scheduler: DispatchQueue.main)
                        .eraseToEffect()
                    }
                  )
                )
              )
            )
          )

          NavigationLink(
            "Web socket",
            destination: WebSocketView(
              store: Store(
                initialState: .init(),
                reducer: webSocketReducer,
                environment: WebSocketEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                  webSocket: .live
                )
              )
            )
          )
        }

        Section(header: Text("Navigation")) {
          NavigationLink(
            "Navigate and load data",
            destination: NavigateAndLoadView(
              store: Store(
                initialState: NavigateAndLoadState(),
                reducer: navigateAndLoadReducer,
                environment: NavigateAndLoadEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Load data then navigate",
            destination: LoadThenNavigateView(
              store: Store(
                initialState: LoadThenNavigateState(),
                reducer: loadThenNavigateReducer,
                environment: LoadThenNavigateEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Lists: Navigate and load data",
            destination: NavigateAndLoadListView(
              store: Store(
                initialState: NavigateAndLoadListState(
                  rows: [
                    .init(count: 1, id: UUID()),
                    .init(count: 42, id: UUID()),
                    .init(count: 100, id: UUID()),
                  ]
                ),
                reducer: navigateAndLoadListReducer,
                environment: NavigateAndLoadListEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Lists: Load data then navigate",
            destination: LoadThenNavigateListView(
              store: Store(
                initialState: LoadThenNavigateListState(
                  rows: [
                    .init(count: 1, id: UUID()),
                    .init(count: 42, id: UUID()),
                    .init(count: 100, id: UUID()),
                  ]
                ),
                reducer: loadThenNavigateListReducer,
                environment: LoadThenNavigateListEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Sheets: Present and load data",
            destination: PresentAndLoadView(
              store: Store(
                initialState: PresentAndLoadState(),
                reducer: presentAndLoadReducer,
                environment: PresentAndLoadEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Sheets: Load data then present",
            destination: LoadThenPresentView(
              store: Store(
                initialState: LoadThenPresentState(),
                reducer: loadThenPresentReducer,
                environment: LoadThenPresentEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )
        }

        Section(header: Text("Higher-order reducers")) {
          NavigationLink(
            "Reusable favoriting component",
            destination: EpisodesView(
              store: Store(
                initialState: EpisodesState(
                  episodes: .mocks
                ),
                reducer: episodesReducer,
                environment: EpisodesEnvironment(
                  favorite: favorite(id:isFavorite:),
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Reusable offline download component",
            destination: CitiesView(
              store: Store(
                initialState: .init(cityMaps: .mocks),
                reducer: mapAppReducer,
                environment: .init(
                  downloadClient: .live,
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Strict reducers",
            destination: DieRollView(
              store: Store(
                initialState: DieRollState(),
                reducer: dieRollReducer,
                environment: DieRollEnvironment(
                  rollDie: { .random(in: 1...6) }
                )
              )
            )
          )

          NavigationLink(
            "Elm-like subscriptions",
            destination: ClockView(
              store: Store(
                initialState: ClockState(),
                reducer: clockReducer,
                environment: ClockEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
              )
            )
          )

          NavigationLink(
            "Recursive state and actions",
            destination: NestedView(
              store: Store(
                initialState: .mock,
                reducer: nestedReducer,
                environment: NestedEnvironment(
                  uuid: UUID.init
                )
              )
            )
          )
        }
      }
      .navigationBarTitle("Case Studies")
      .onAppear { self.id = UUID() }

      Text("\(self.id)")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  // NB: This is a hack to force the root view to re-compute itself each time it appears so that
  //     each demo is provided a fresh store each time.
  @State var id = UUID()
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
