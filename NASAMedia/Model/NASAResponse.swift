struct NASAResponse: Decodable {
    let collection: Collection

    struct Collection: Decodable {
        let items: [NASAItemWrapper]
    }
}
