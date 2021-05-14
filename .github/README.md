# notion

`noppefoxwolf/notion` is a notion.so API library written in `swift`.


# Installation

## Xcode

Project > Swift Packages

```
git@github.com:noppefoxwolf/notion.git
```

## Swift Package Manager

Append following line to Package.swift.

```
dependencies: [
    .package(url: "https://github.com/noppefoxwolf/notion", from: "0.0.1")
}
```

# Usage

```swift
let session = Session.shared
session.setAuthorization(token: "<<AUTHORIZE TOKEN>>")
session.send(V1.Users.List()).sink { result in
    // DO SOMETHING
}.store(in: &cancellables)
```

# Features

## integration

- [x] internal integration
- [ ] public integration

## user

- [x] List all users
- [x] Retrieve a user

## search

- [ ] Search

## block
  
- [ ] Retrieve block children
- [ ] Append block children

## page

- [ ] Update page properties
- [ ] Create a page
- [ ] Retrieve a page

## database

- [ ] List databases
- [ ] Query a database
- [ ] Retrieve a database
 
# API Documents

[Start building with the Notion API](https://developers.notion.com)

# Author

[noppe](https://noppe.dev)