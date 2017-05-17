# Clipinio

Lightweight clipboard manager for OS X.

## Usage

Press `CTRL` + `C` to copy, and `CTRL` + `SHIFT` + `V` to insert a clip via Clipinio. The hotkeys are hardcoded. If demanded, I will add a menu for customizing the keys.

## Build

```bash
sh build.sh
```

It automatically copies Clipinio to `/Applications/Clipinio.app`. Enjoy!

### Additional information

> I used to use ClipMenu as daily clipboard manager. As the recent version lacks of access to the source code I decided to switch. Thus I bought two clipboard manager from the App Store. Both did not work as I expected...so I wrote my own kinda lightweight clipboard manager. I wrote it in Swift as an introduction. This is nothing real awesome. Just fits my daily use case. Maybe I enhance it later. If anyone cares: I did not invoke the old carbon api as it felt unswifty implementing it. The disadvantage of this approach is that one is not able to consume hotkey events but to receive a copy of those. Meaning the hotkey event is dispatched to the current application.

#### Update

> Now I use the old Carbon API, thus being able to consume the events. It is also much faster now and feels more like the old ClipMenu.

## TODO

- [ ] Add the possibility of customizing max entries and hotkeys.
