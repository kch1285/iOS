//
//  APICaller.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import Foundation

final class APICaller {
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case PUT
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    static let shared = APICaller()
    
    private init() {
        
    }
    
    //MARK: - Search
    
    public func search(with query: String, completion: @escaping (Result<[SearchResults], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("search : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResults: [SearchResults] = []
                    searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0) }))
                    searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0) }))
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0) }))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0) }))
                    
                    completion(.success(searchResults))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: - Category
    
    public func getAllCategories(completion: @escaping (Result<[CategoryItem], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getAllCategories : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(AllCategories.self, from: data)
                    completion(.success(result.categories.items))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func getCategoryPlaylists(category: CategoryItem, completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category.id)/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getCategoryPlaylists : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylists.self, from: data)
                    let playlists = result.playlists.items
                    completion(.success(playlists))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    //MARK: - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetails, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + album.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getAlbumDetails : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(AlbumDetails.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserAlbums(completion: @escaping (Result<[Album], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/albums"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getCurrentUserAlbums : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(LibraryAlbums.self, from: data)
                    completion(.success(result.items.compactMap({ $0.album })))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func addAlbumToLibrary(album: Album, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/albums?ids=\(album.id)"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let code = (response as? HTTPURLResponse)?.statusCode, error == nil else {
                    completion(false)
                    return
                }
                print("addAlbumToLibrary : \(request)")
                completion(code == 200)
            }
            task.resume()
        }
    }
    
    //MARK: - Playlists
    
    public func getPlaylistsDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetails, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getAlbumDetails : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(PlaylistDetails.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getCurrentUserPlaylists : \(request)")
                do {
                    let result = try JSONDecoder().decode(LibraryPlaylists.self, from: data)
                    completion(.success(result.items))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                self?.createRequest(with: URL(string: urlString), type: .POST) { bodyRequest in
                    var request = bodyRequest
                    let json = ["name": name]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        print("createPlaylist : \(request)")
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            if let response = result as? [String: Any], response["id"] as? String != nil {
                                print("Created Playlist !")
                                completion(true)
                            }
                            else {
                                completion(false)
                            }
                        }
                        catch {
                            print("error : \(error.localizedDescription)")
                            completion(false)
                        }
                    }
                    task.resume()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "uris": ["spotify:track:\(track.id)"]
            ]
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                print("addTrackToPlaylist : \(request)")
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(result)
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
                catch {
                    print("addTrackToPlaylist - error : \(error.localizedDescription)")
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
            var request = baseRequest
            let json = [
                "tracks": [
                    [
                        "uri": "spotify:track:\(track.id)"
                    ]
                ]
            ]
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                print("addTrackToPlaylist : \(request)")
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(result)
                    if let response = result as? [String: Any], response["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                    else {
                        completion(false)
                    }
                }
                catch {
                    print("addTrackToPlaylist - error : \(error.localizedDescription)")
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Profile
    
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                print("getCurrentUserProfile : \(request)")
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK: - Browse
    
    public func getNewReleases(completion: @escaping (Result<NewReleases, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                print("getNewReleases : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(NewReleases.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("getNewReleases - error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylists, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                print("getFeaturedPlaylists : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylists.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendedGenres(completion: @escaping (Result<Genres, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                print("getRecommendedGenres : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(Genres.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<Recommendations, Error>) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=50&seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                print("getRecommendations : \(request)")
                
                do {
                    let result = try JSONDecoder().decode(Recommendations.self, from: data)
                    completion(.success(result))
                }
                catch {
                    print("error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            
            print("createRequest : \(request)")
            completion(request)
        }
    }
}
