//
//  SearchView.swift
//  Cadr
//
//  Created by Наливайко Кирилл on 23.10.2026.
//

import SwiftUI

struct SearchView: View{
    @State private var viewModel: SearchViewModel
    @FocusState private var isFocused: Bool
    
    init(viewModel: SearchViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View{
        ZStack{
            Color.background.ignoresSafeArea()
            
            // Корневой
            VStack(alignment: .leading, spacing: 16){
                // Шапка
                Text("Поиск")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                
                // Строка поиска
                HStack(spacing: 8){
                    Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.textSecondary)
                    TextField(
                            "",
                            text: $viewModel.textRequest,
                            prompt: Text("Введи название фильма").foregroundStyle(Color.textSecondary)
                        )
                        .font(.subheadline)
                        .foregroundStyle(Color.textPrimary)
                        .focused($isFocused)
                        .autocorrectionDisabled()
                        .submitLabel(.search)
                    
                    if !viewModel.textRequest.isEmpty {
                            Button {
                                viewModel.textRequest = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color.textSecondary)
                            }
                            .buttonStyle(.plain)
                        }
                }
                .padding(12)
                .background(Color.surface, in: RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(isFocused ? Color.accent : Color.line, lineWidth: 1)
                )
                
                // Поиск
                VStack(alignment: .leading, spacing: 12){
                    switch viewModel.state{
                    case .idle:
                        VStack(spacing: 8){
                            Image(systemName: "magnifyingglass")
                                .frame(width: 32, height: 32)
                                .font(.system(size: 32))
                                .foregroundStyle(Color.textSecondary)
                            Text("Найди фильм")
                                .font(.system(.subheadline, weight: .semibold))
                                .foregroundStyle(Color.textPrimary)
                            Text("Введи название, например «Дюна»")
                                .font(.footnote)
                                .foregroundStyle(Color.textSecondary)
                        }
                        .padding(.top, 80)
                        .frame(maxWidth: .infinity, alignment: .center)
                    case .loading:
                        ProgressView()
                            .tint(Color.textPrimary)
                    case .noResults:
                        VStack(spacing: 8){
                            Image(systemName: "film")
                                .frame(width: 32, height: 32)
                                .font(.system(size: 32))
                                .foregroundStyle(Color.textSecondary)
                            Text("Ничего не найдено")
                                .font(.system(.subheadline, weight: .semibold))
                                .foregroundStyle(Color.textPrimary)
                            Text("Попробуйте изменить запрос")
                                .font(.footnote)
                                .foregroundStyle(Color.textSecondary)
                        }
                        .padding(.top, 80)
                        .frame(maxWidth: .infinity, alignment: .center)
                    case .error(let error):
                        VStack{
                            Text(error.errorDescription ?? "Ошибка")
                                .foregroundStyle(Color.textSecondary)
                                .font(.subheadline)
                            Button(action: {
                                Task{
                                    await viewModel.searchMovie()
                                }
                            }){
                                Text("Повторить")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 16)
                                    .frame(minHeight: 44)
                                    .background(Color.accent, in: RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .padding(.top, 50)
                        .frame(maxWidth: .infinity, alignment: .center)
                    case .success(let movies):
                        SectionHeader(title: "Найдено ", action: {})
                        ScrollView{
                            LazyVStack(spacing: 0){
                                ForEach(movies, id: \.id){ movie in
                                    NavigationLink(value: movie){
                                        MovieRow(movie: movie)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .scrollDismissesKeyboard(.interactively)
                    }
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
            
        }
        .task(id: viewModel.textRequest) {
            do{
                try await Task.sleep(for: .seconds(0.5))
            }catch {
                return
            }
            await viewModel.searchMovie()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack{
        SearchView(viewModel: SearchViewModel(movieService: MockMovieService(shouldFail: false)))
    }
}
