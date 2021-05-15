# notion

`noppefoxwolf/notion` is a notion.so API library written in `swift`.

![](https://github.com/noppefoxwolf/notion/blob/main/.github/fox.png)

# Installation

## Xcode

Project > Swift Packages

```
git@github.com:noppefoxwolf/notion.git
```

![](https://github.com/noppefoxwolf/notion/blob/main/.github/xcode.jpg)

## Swift Package Manager

Append following line to Package.swift.

```
dependencies: [
    .package(url: "https://github.com/noppefoxwolf/notion", from: "0.1.0")
}
```

# Usage

```swift
import notion

let session = Session.shared
session.setAuthorization(token: "<<AUTHORIZE TOKEN>>")
session.send(V1.Users.List()).sink { result in
    // DO SOMETHING
}.store(in: &cancellables)
```

# Support features

## integration

- [x] internal integration
- [ ] public integration

## user

- [x] List all users
- [x] Retrieve a user

## search

- [x] Search

## block
  
- [x] Retrieve block children
- [x] Append block children

## page

- [x] Update page properties
- [x] Create a page
- [x] Retrieve a page

## database

~~List databases~~ [deprecated](https://developers.notion.com/reference/get-databases)
- [x] Query a database
- [x] Retrieve a database
 
# API Documents

[Start building with the Notion API](https://developers.notion.com)

# Author

[noppe](https://noppe.dev)
